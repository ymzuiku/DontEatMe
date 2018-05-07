//
//  Story.m
//  DontEatMe
//
//  Created by ymMac on 14-8-10.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

//if ([theString rangeOfString:str].location == NSNotFound) {
//    [self removeFromParent];
//}

#import "Story.h"

@implementation Story
{
    int lineNumber;
    NSString *keyString;
    NSArray *storyArray;
    NSString *lastBodyName;
    SKSpriteNode *background;
    int num;
    BOOL isLeft;
    void (^myBlock)();
    SK_Sound *soundBodySay;
}

-(void)removeFromParent
{
    storyArray = nil;
    [soundBodySay stop]; soundBodySay = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}

+(id)createWithNumber:(int)number string:(NSString *)string;
{
    return [[self alloc] initWithNumber:number string:string];
}

-(id)initWithNumber:(int)number string:(NSString *)string;
{
    if (self = [super initWithColor:[UIColor clearColor] size:CGSizeMake(iw, ih)]) {
        self.anchorPoint = CGPointMake(0, 0);
        self.userInteractionEnabled = YES;
        lineNumber = number;
        keyString = string;
        num = 0;
        ViewController *vc = [ViewController single];
        [vc.mapScene moveBarHidden];
        [vc.mapScene.topBar moveUp];
        [vc.gameScene.buttonBar hiddenBar];
        
        [vc.book removeFromParent];
        vc.book = nil;
        [vc.shop removeFromParent];
        vc.shop = nil;
        
        [self loadStoryArray];
        [self reloadUI];
    }
    return self;
}

-(void)loadStoryArray
{
    if (lineNumber == -1) {
        NSMutableArray *endArray = [NSMutableArray array];
        NSArray *array = [keyString componentsSeparatedByString:@" - "];
        for (NSString *subString in array) {
            NSArray *subArray = [subString componentsSeparatedByString:@":"];
            [endArray addObject:subArray];
        }
        storyArray = endArray;
    }
    else {
        NSMutableArray *endArray = [NSMutableArray array];
        NSString *string = [UserCenter dic][@"mapLine"][lineNumber][2][keyString];
        NSArray *array = [string componentsSeparatedByString:@" - "];
        for (NSString *subString in array) {
            NSArray *subArray = [subString componentsSeparatedByString:@":"];
            [endArray addObject:subArray];
        }
        storyArray = endArray;
    }
}

-(void)reloadUI
{
    if (num >= storyArray.count) {
        ViewController *vc = [ViewController single];
        if (vc.mapScene.isBottomMove == YES) {
            [vc.mapScene moveBarShow];
        }
        [vc.mapScene.topBar moveDown];
        [vc.gameScene.buttonBar showGamesBar];
        
        self.userInteractionEnabled = NO;
        CGPoint temp = CGPointMake(0, 0);
        if (isLeft) {
            temp = CGPointMake(background.position.x-550, background.position.y);
        }else {
            temp = CGPointMake(background.position.x+550, background.position.y);
        }
        SKAction *moveOut = [SKAction moveTo:temp duration:0.5];
        moveOut.timingMode = SKActionTimingEaseOut;
        [background runAction:moveOut completion:^{
            if (myBlock) myBlock();
            [self removeFromParent];
        }];
        return;
    }
    
    [self removeAllChildren];
    NSArray *subArray = storyArray[num];
    if ([subArray[0] isEqualToString:@"banana"] ||
        [subArray[0] isEqualToString:@"boxer"] ||
        [subArray[0] isEqualToString:@"energy"] ||
        [subArray[0] isEqualToString:@"violent"]) {
        isLeft = YES;
        background = [SKSpriteNode spriteNodeWithImageNamed:@"ui_bigJelly/ui_story_background.png"];
        background.position = CGPointMake(77, 450);
        [self addChild:background];
        NSString *bodyImageName = [NSString stringWithFormat:@"ui_bigJelly/ui_bigJelly_%@.png", subArray[0]];
        SKSpriteNode *body = [SKSpriteNode spriteNodeWithImageNamed:bodyImageName];
        body.position = CGPointMake(70, 20);
        [background addChild:body];
        SKSpriteNode *bubble = [SKSpriteNode spriteNodeWithImageNamed:@"ui_bigJelly/ui_left_bubble.png"];
        bubble.position = CGPointMake(273, 290);
        [background addChild:bubble];
        
        int fontLine = iSEnglish ? 14 : 9;
        SK_Label *label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:fontLine size:32 color:rgb(0x61637d, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        label.text = iString(subArray[1]);
        label.position = CGPointMake(0, 20);
        [bubble addChild:label];
        
        if (![lastBodyName isEqualToString:subArray[0]]) {
            CGPoint temp = background.position;
            background.position = CGPointMake(temp.x-250, temp.y);
            SKAction *moveTo = [SKAction moveTo:temp duration:0.2];
            moveTo.timingMode = SKActionTimingEaseOut;
            [background runAction:moveTo completion:^{
                NSString *jellySaySting = [NSString stringWithFormat:@"Sound/jelly_say_%d.mp3", (int)skRand(0, 5)];
                [soundBodySay stop];
                soundBodySay = [SK_Sound createNewSound:jellySaySting repeat:0];
                soundBodySay.volume /= 2;
                [soundBodySay play];
            }];
        }
        bubble.alpha = 0;
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.4];
        fadeIn.timingMode = SKActionTimingEaseOut;
        [bubble runAction:fadeIn];
        lastBodyName = subArray[0];
    }
    else {
        isLeft = NO;
        background = [SKSpriteNode spriteNodeWithImageNamed:@"ui_bigJelly/ui_story_background.png"];
        background.position = CGPointMake(563, 450);
        [self addChild:background];
        NSString *bodyImageName = [NSString stringWithFormat:@"ui_bigJelly/ui_bigJelly_%@.png", subArray[0]];
        SKSpriteNode *body = [SKSpriteNode spriteNodeWithImageNamed:bodyImageName];
        body.position = CGPointMake(-70, 20);
        if ([subArray[0] isEqualToString:@"shield"] ||
            [subArray[0] isEqualToString:@"iceThin"] ||
            [subArray[0] isEqualToString:@"banana"]) {
            body.xScale = -1;
        }
        [background addChild:body];
        SKSpriteNode *bubble = [SKSpriteNode spriteNodeWithImageNamed:@"ui_bigJelly/ui_right_bubble.png"];
        bubble.position = CGPointMake(-273, 290);
        [background addChild:bubble];
        
        int fontLine = iSEnglish ? 14 : 9;
        SK_Label *label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:fontLine size:32 color:rgb(0x61637d, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        label.text = iString(subArray[1]);
        label.position = CGPointMake(0, 20);
        [bubble addChild:label];
        
        if (num == 0) {

        }
        if (![lastBodyName isEqualToString:subArray[0]]) {
            CGPoint temp = background.position;
            background.position = CGPointMake(temp.x+250, temp.y);
            SKAction *moveTo = [SKAction moveTo:temp duration:0.2];
            moveTo.timingMode = SKActionTimingEaseOut;
            [background runAction:moveTo completion:^{
                if ([subArray[0] isEqualToString:@"spoon"] ||
                    [subArray[0] isEqualToString:@"fur"] ||
                    [subArray[0] isEqualToString:@"maid"] ||
                    [subArray[0] isEqualToString:@"rifile"] ||
                    [subArray[0] isEqualToString:@"robot"] ||
                    [subArray[0] isEqualToString:@"saw"] ||
                    [subArray[0] isEqualToString:@"fire"] ||
                    [subArray[0] isEqualToString:@"yoda"]) {
                    
                    NSString *chickenSaySting = [NSString stringWithFormat:@"Sound/chicken_say_%d.mp3", (int)skRand(0, 7)];
                    [soundBodySay stop];
                    soundBodySay = [SK_Sound createNewSound:chickenSaySting repeat:0];
                    soundBodySay.volume /= 2;
                    [soundBodySay play];
                    
                }
                else {
                    NSString *jellySaySting = [NSString stringWithFormat:@"Sound/jelly_say_%d.mp3", (int)skRand(0, 5)];
                    [soundBodySay stop];
                    soundBodySay = [SK_Sound createNewSound:jellySaySting repeat:0];
                    soundBodySay.volume /= 2;
                    [soundBodySay play];
                }
            }];
        }
        bubble.alpha = 0;
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.4];
        fadeIn.timingMode = SKActionTimingEaseOut;
        [bubble runAction:fadeIn];
        lastBodyName = subArray[0];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    num++;
    [self reloadUI];
}


-(void)event:(void(^)())block
{
    myBlock = block;
}

-(void)modoTouch
{
    num++;
    [self reloadUI];
}

@end
