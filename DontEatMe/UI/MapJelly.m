//
//  MapJelly.m
//  DontEatMe
//
//  Created by ymMac on 14-8-4.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "MapJelly.h"

@implementation MapJelly
{
    BOOL isMoving;
    SK_PSD *mapLine;
    int lineMainMax;
    int subNode;      
    int subBegin;
    int subEnd;
    int isLost;
    int gotoNumber;
    float moveTime;
    int theIdx;
    int nowClass;
    float defalutScale;
    SKAction *soundMove;
    SKAction *blinkMove;
    SKNode *soundPlayerNode;
}

-(id)initWithLine:(SK_PSD *)line_
{
    if (self = [super initWithImageNamed:@"ui_map_jellyMove_0.png"]) {
//        ViewController *vc = [ViewController single];
//        if(vc.isLastWin == 0) {
//            self.userInteractionEnabled = NO;
//        }
        defalutScale = 0.9;
        [self setScale:defalutScale];
        mapLine = line_;
        lineMainMax = 71;
        moveTime = 0.85;
        soundPlayerNode = [SKNode node];
        [self addChild:soundPlayerNode];
        soundMove = [SKAction playSoundFileNamed:@"Sound/chicken_move_grass_3.mp3" waitForCompletion:1]; //soundMove.volume /= 2;
        blinkMove = [SKAction playSoundFileNamed:@"Sound/shield_attack_1.mp3" waitForCompletion:1]; //soundMove.volume /= 2;
        [self rest];
    }
    return self;
}

-(void)removeFromParent
{
    [soundPlayerNode removeAllActions];
    [soundPlayerNode removeFromParent];
    [self removeAllChildren];
    [super removeFromParent];
}

-(void)moveTo:(int)number lineIdx:(int)lineIdx isLost:(int)isLost_
{
    if (isMoving) {
        return;
    }
    
    isLost = isLost_;
    gotoNumber = number;
    theIdx = lineIdx;
    
    if ([[[UserCenter dic] objectForKey:@"cook"] intValue] <= 0) {
        ViewController *vc = [ViewController single];
        [vc.mapScene.topBar tipPickCook];
        return;
    }

    if ([[UserCenter dic][@"mapLine"][gotoNumber][0] isEqualToString:@"close"] && isLost == 0) {
        return;
    }
    
    nowClass = [[[UserCenter dic] objectForKey:@"nowClass"] intValue];
    
    if (isLost == 0) {
        [soundPlayerNode runAction:soundMove];
    }
    
    if ((nowClass <71 && gotoNumber >= 71) || (nowClass >=71 && gotoNumber < 71)) {
        if ((nowClass >= 71 && nowClass <= 74) || (gotoNumber >= 71 && gotoNumber <= 74)) {
            [self doubleWayNode:16 nextNode:71];
        }
        else if ((nowClass >= 75 && nowClass <= 78) || (gotoNumber >= 75 && gotoNumber <= 78)) {
            [self doubleWayNode:32 nextNode:75];
        }
        else if ((nowClass >= 78 && nowClass <= 81) || (gotoNumber >= 78 && gotoNumber <= 81)) {
            [self doubleWayNode:56 nextNode:78];
        }
    }
    else {
        moveTime = 0.9;
        [self wayFind:gotoNumber isBlink:NO completion:^{
            [self runEnd:gotoNumber];
        }];
    }
    
//    else if (nowClass - gotoNumber > 6 || nowClass - gotoNumber < -6) {
//        [self blinkMove:lineIdx];
//    }
}

-(void)doubleWayNode:(int)node nextNode:(int)nexNode
{
    int a = node;
    int b = nexNode;
    if (nowClass > gotoNumber) {
        a = nexNode;
        b = node;
    }

    moveTime = 0.5;
    if (nowClass == a) {
        [self wayFindOne:b completion:^{
            nowClass = b;
            if (gotoNumber == nowClass) {
                [self runEnd:gotoNumber];
            }
            else {
                [self wayFind:gotoNumber isBlink:NO completion:^{
                    moveTime = 0.9;
                    [self runEnd:gotoNumber];
                }];
            }
        }];
    }
    else {
        [self wayFind:a isBlink:NO completion:^{
            [self wayFindOne:b completion:^{
                nowClass = b;
                if (gotoNumber == nowClass) {
                    [self runEnd:gotoNumber];
                }
                else {
                    [self wayFind:gotoNumber isBlink:NO completion:^{
                        moveTime = 0.9;
                        [self runEnd:gotoNumber];
                    }];
                }
            }];
        }];
    }
}

-(void)blinkMove:(int)number
{
    if (isLost == 0) {
        [soundPlayerNode runAction:blinkMove];
    }
    
    SKNode *node = [mapLine.children objectAtIndex:number];
    self.position = CGPointMake(node.position.x, node.position.y+32);
    
    SKAction *down0 = [SKAction moveByX:0 y:15 duration:0.1];
    SKAction *down1 = [SKAction moveByX:0 y:-15 duration:0.1];
    SKAction *down2 = [SKAction moveByX:0 y:5 duration:0.1];
    SKAction *down3 = [SKAction moveByX:0 y:-5 duration:0.1];
    down0.timingMode = SKActionTimingEaseOut;
    down1.timingMode = SKActionTimingEaseIn;
    down2.timingMode = SKActionTimingEaseOut;
    down3.timingMode = SKActionTimingEaseIn;
    SKAction *seq = [SKAction sequence:@[down0, down1, down2, down3]];
    [self runAction:seq completion:^{
        [self runEnd:gotoNumber];
    }];
}

-(void)wayFindOne:(int)number completion:(void (^)())block
{
    if (isMoving) return;
    [mapLine.children enumerateObjectsUsingBlock:^(SKNode *node, NSUInteger idx, BOOL *stop) {
        int mapIdx = [mapLine.lineNumbers[idx] intValue];
        if (mapIdx == number) {
            SKAction *turnBack = [SKAction runBlock:^{
                if (node.position.x >= self.position.x) {
                    self.xScale = defalutScale;
                }else {
                    self.xScale = -defalutScale;
                }
            }];
            SKAction *moveTo = [SKAction moveTo:CGPointMake(node.position.x, node.position.y+32) duration:moveTime];
            SKAction *seq = [SKAction sequence:@[turnBack, moveTo]];
            isMoving = YES;
            
            SKAction *moveAnime = [SKAction animateWithTextures:Atlas(@"ui_map_jellyMove") timePerFrame:0.016];
            SKAction *repMoveAnime = [SKAction repeatActionForever:moveAnime];
            [self runAction:repMoveAnime];
            
            [self runAction:seq completion:^{
                isMoving = NO;
                if (block) block();
            }];
        }
    }];
}

-(void)wayFind:(int)number isBlink:(BOOL)isBlink completion:(void (^)())block
{
    if (isMoving) return;
    [self removeAllActions];
    if (number == nowClass) {
        if (block) block();
        return;
    }
    int maxNum = (number - nowClass) >= 0 ? number : nowClass;
    int minNum = (number - nowClass) < 0 ? number : nowClass;
    int subNum = maxNum - minNum;
    
    NSMutableArray *actionArray = [NSMutableArray array];
    [mapLine.children enumerateObjectsUsingBlock:^(SKNode *node, NSUInteger idx, BOOL *stop) {
        int mapIdx = [mapLine.lineNumbers[idx] intValue];
        if (mapIdx >= minNum && mapIdx <= maxNum && mapIdx != nowClass) {
            
            SKAction *turnBack = [SKAction runBlock:^{
                if (node.position.x >= self.position.x) {
                    self.xScale = defalutScale;
                }else {
                    self.xScale = -defalutScale;
                }
            }];
            
            SKAction *moveTo = [SKAction moveTo:CGPointMake(node.position.x, node.position.y+32) duration:moveTime/subNum];
            SKAction *seq = [SKAction sequence:@[turnBack, moveTo]];
            [actionArray addObject:seq];
        }
    }];
    
    if (nowClass > number) {
        actionArray = [NSMutableArray arrayWithArray:[[actionArray reverseObjectEnumerator] allObjects]];
    }
    
    if (actionArray.count == 0) return;
    isMoving = YES;
    SKAction *moveAnime = [SKAction animateWithTextures:Atlas(@"ui_map_jellyMove") timePerFrame:0.016];
    SKAction *repMoveAnime = [SKAction repeatActionForever:moveAnime];
    [self runAction:repMoveAnime];
    
    [self runAction:[SKAction sequence:actionArray] completion:^{
        isMoving = NO;
        if (block) block();
    }];
}

-(void)rest
{
    [self removeAllActions];
    SKAction *rest = [SKAction animateWithTextures:Atlas(@"ui_map_jellyRest") timePerFrame:0.042];
    [self runAction:[SKAction repeatActionForever:rest]];
}

-(void)runEnd:(int)number
{
    [self removeAllActions];
    [self rest];
    
    ViewController *vc = [ViewController single];
    [UserCenter setNowClass:number];
    
    if (isLost == 1) {
        self.xScale = self.xScale*-defalutScale;
        return;
    }
    
    NSArray *mapDic = [UserCenter dic][@"mapLine"];
    NSString *string = mapDic[number][0];
    NSString *story = mapDic[number][2][@"begin"];
    if ([string isEqualToString:@"first"] && story.length > 1) {
        [vc.mapScene createStoryWithNumber:number string:@"begin" block:^{
            [vc.mapScene createAGame:number classString:@"first"];
            [vc.mapScene moveBarShow];
        }];
    }
//    else if ([string isEqualToString:@"first"] && story.length <= 1) {
//        [vc.mapScene createAGame:number classString:@"first"];
//        [vc.mapScene moveBarShow];
//    }
//    else if ([string isEqualToString:@"close"]) {
//
//    }
    else {
        [vc.mapScene createAGame:number classString:string];
        [vc.mapScene moveBarShow];
    }
    
    [self event:^{
        [vc.mapScene createAGame:number classString:mapDic[number][0]];
        [vc.mapScene moveBarShow];
    }];
}


@end
