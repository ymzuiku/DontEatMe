//
//  DownSomeBody.m
//  DontEatMe
//
//  Created by ymMac on 14-9-25.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "DownSomeBody.h"
@implementation DownSomeBody
{
    SKTexture *objTexture;
    NSString *objName;
    int objNumber;
    int isWinObject;
    ClassCenter *cc;
    SKAction *soundDown;
    SKAction *soundTouch;
    SKSpriteNode *shadow;
    SKSpriteNode *objImage;
    void (^touchBlock)();
}

-(void)removeFromParent
{
    objTexture = nil;
    [self removeActionForKey:@"soundDown"];
    [self removeActionForKey:@"soundTouch"];
    
    [shadow removeFromParent];
    shadow = nil;
    
    [objImage removeFromParent];
    objImage = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}

-(id)initWithBodyTpye:(NSString *)downType;
{
    if (self = [super initWithColor:[UIColor clearColor] size:CGSizeMake(88*2, 88*2)]) {
        shadow = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_bigObj")[10]];
        shadow.zPosition = -0.02;
        [self addChild:shadow];
        self.userInteractionEnabled = YES;
        cc = [ClassCenter singleton];
        NSArray *nameArray = [downType componentsSeparatedByString:@"."];
        objName = nameArray[0];
        if (nameArray.count > 1) {
            objNumber = [nameArray[1] intValue];
        }
        if (nameArray.count == 3) {
            isWinObject = 1;
        }
        
        NSDictionary *allObjDic = @{@"mana":@10, @"gold":@0, @"cook":@1, @"map":@2, @"whistle":@12, @"moreChickens":@13, @"banana":@3,
                                    @"boom":@4, @"shield":@6, @"ice":@7, @"energy":@5, @"jelly":@8, @"jellyPro":@8};
        
        objTexture = Atlas(@"ui_map_bigObj")[0];
        
        if ([objName isEqualToString:@"gem"]) {
//            NSString *string = [[[[UserCenter dic] objectForKey:@"jellyData"] objectAtIndex:[nameArray[1] intValue]] objectForKey:@"type"];
            NSString *string = [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:nameArray[1]] objectForKey:@"type"];
            [allObjDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
                if ([key isEqualToString:string]) {
                    objTexture = Atlas(@"ui_map_bigObj")[[obj intValue]];
                }
            }];
        }
        else {
            [allObjDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
                if ([key isEqualToString:objName]) {
                    objTexture = Atlas(@"ui_map_bigObj")[[obj intValue]];
                }
            }];
        }
        
        objImage = [SKSpriteNode spriteNodeWithTexture:objTexture];
        objImage.zPosition = -0.01;
        objImage.alpha = 0;
        [self addChild:objImage];
        
        [self setEvent];
    }
    return self;
}

-(void)event:(void (^)())block
{
    touchBlock = block;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.userInteractionEnabled = NO;
    if (touchBlock) {
        touchBlock();
    }
    SKAction *wait = [SKAction waitForDuration:0.3];
    [self runAction:wait completion:^{
        [self removeFromParent];
    }];
}

-(void)setDownPosition:(CGPoint)position
{
    CGPoint pos = [self changePos:position];
    self.position = pos;
    cc.lastObjPosition = pos;
    [self downAnime];
}

-(CGPoint)changePos:(CGPoint)pos
{
    float x = pos.x; //+138;
    float y = pos.y; //-60;
    if (x <= 0+120) x = 120;
    if (x > iw-120) x = iw-120;
    if (y > ih-120) y = ih-120;
    if (y < 0+120)  y = 120;
    
    x += skRand(-2, 2);
    return CGPointMake(x, y);
}

-(void)downAnime
{
    StaticActions *sa = [StaticActions single];
    if ([objName isEqualToString:@"jelly"] || [objName isEqualToString:@"jellyPro"]) {
        SKAction *downAction = sa.actionDown;
        [objImage runAction:downAction];
        
        SKSpriteNode *pick = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_hand")[0]];
        [pick setScale:0.75];
        pick.userInteractionEnabled = NO;
        pick.position = CGPointMake(-10, 10);
        pick.anchorPoint = CGPointMake(0, 1);
        pick.zPosition = 0.01;
        pick.alpha = 0;
        [self addChild:pick];
        
        SKAction *wait = [SKAction waitForDuration:3];
        SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_hand") timePerFrame:0.042*0.8 resize:YES restore:YES];
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.3/2];
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.3/2];
        
        SKAction *seq = [SKAction sequence:@[wait, fadeIn, anime, anime, fadeOut]];
        
        SKAction *waitSound_0 = [SKAction waitForDuration:3+anime.duration/2];
        SKAction *waitSound_1 = [SKAction waitForDuration:anime.duration];
        SKAction *block_0 = [SKAction runBlock:^{
            StaticActions *sa = [StaticActions single];
            [self runAction:sa.sound_pickTouch_0];
        }];
        
        SKAction *seq2 = [SKAction sequence:@[waitSound_0, block_0, waitSound_1, block_0]];
        SKAction *group = [SKAction group:@[seq, seq2]];
        [pick runAction:[SKAction repeatActionForever:group]];
    }
    else if ([objName isEqualToString:@"mana"]) {
        SKAction *seq = [SKAction sequence:@[sa.actionVerticalDown, sa.actionWait]];
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.5];
        SKAction *group = [SKAction group:@[seq, fadeIn]];
        [objImage runAction:group];
    }
    else {
        SKAction *seq = [SKAction sequence:@[sa.actionDown, sa.actionWait]];
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.5];
        SKAction *group = [SKAction group:@[seq, fadeIn]];
        [objImage runAction:group];
    }
    SKAction *soundWait = [SKAction waitForDuration:0.042*16];
    [self runAction:soundWait completion:^{
        if ([objName isEqualToString:@"gold"]) {
            soundDown = [SKAction playSoundFileNamed:@"Sound/war_down_gold_3.mp3" waitForCompletion:0];
            [self runAction:soundDown withKey:@"soundDown"];
        }
        else if ([objName isEqualToString:@"mana"]) {
            soundDown = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_20.mp3" waitForCompletion:0];
            [self runAction:soundDown withKey:@"soundDown"];
        }
        else {
            soundDown = [SKAction playSoundFileNamed:@"Sound/war_down_obj.mp3" waitForCompletion:0];
            [self runAction:soundDown withKey:@"soundDown"];
        }
    }];
}

-(void)setEvent
{
    //12秒之后消失
    if (objNumber < 9 && isWinObject != 1) {
        SKAction *waitKillSelf = [SKAction waitForDuration:12];
        [self runAction:waitKillSelf completion:^{
            [self removeFromParent];
        }];
    }
    
    ViewController *vc = [ViewController single];
    if ([objName isEqualToString:@"mana"]) {
        cc.groupManas += objNumber;
        SKAction *manaAtlas = [SK_Actions actionAnime:Atlas(@"ui_games_mana") repeat:-2];
        [objImage runAction:manaAtlas];
        
        if (objNumber == 1) {
            [self setScale:0.85];
        }
        else if (objNumber == 2) {
            [self setScale:1];
        }
        else if (objNumber == 3) {
            [self setScale:1];
        }
        else if (objNumber == 5) {
            [self setScale:1.3];
        }
        else if (objNumber >= 99) {
            [self setScale:2.5];
        }
        [self event:^{
            [self chickIsWin];
            cc.groupManas -= objNumber;
            [self manaTouchAnime];
            [vc.gameScene changeMana:objNumber];
        }];
    }
    else if ([objName isEqualToString:@"gold"]) {
        if (isWinObject == 1) {
            [self setScale:1.5];
        }
        [self event:^{
            [self chickIsWin];
            [self touchAnime];
            if (isWinObject == 1) {
                cc.isWinObject = 1;
            }
            else {
                [UserCenter addGold:1];
            }
            [vc.gameScene.touchLayer closeTouchUI];
        }];
    }
    else if ([objName isEqualToString:@"cook"]) {
        if (isWinObject == 1) {
            [self setScale:1.4];
        }
        [self event:^{
            [self chickIsWin];
            [vc.gameScene.touchLayer closeTouchUI];
            [self touchAnime];
            
            if (isWinObject == 1) {
                cc.isWinObject = 1;
            }
            else {
                [UserCenter addCook:1];
                [vc.gameScene.topBar reloadCookLabel];
            }
        }];
    }
    else if ([objName isEqualToString:@"gem"]) {
        [self setScale:1.5];
        [self event:^{
            [self chickIsWin];
            [vc.gameScene.touchLayer closeTouchUI];
            [self touchAnime];
            
            if (isWinObject == 1) {
                cc.isWinObject = 1;
            }
        }];
    }
    else if ([objName isEqualToString:@"jelly"]) {
        [self event:^{
            [self chickIsWin];
            [vc.gameScene.touchLayer closeTouchUI];
            [self touchAnime];
            
            if (isWinObject == 1) {
                cc.isWinObject = 1;
            }
        }];
    }
    else if ([objName isEqualToString:@"jellyPro"]) {
        SKSpriteNode *sprtie = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_bigObj")[9]];
        sprtie.position = CGPointMake(0, -15);
        [sprtie setScale:1.2];
        [objImage addChild:sprtie];
        
        [self event:^{
            [self chickIsWin];
            [vc.gameScene.touchLayer closeTouchUI];
            [self touchAnime];
            
            if (isWinObject == 1) {
                cc.isWinObject = 1;
            }
        }];
    }
    else if ([objName isEqualToString:@"map"]) {
        [self setScale:1.5];
        objImage.position = CGPointMake(0, 100);
        [self event:^{
            [self chickIsWin];
            [vc.gameScene.touchLayer closeTouchUI];
            [self touchAnime];
            
            if (isWinObject == 1) {
                cc.isWinObject = 1;
            }
        }];
    }
    else if ([objName isEqualToString:@"whistle"]) {
        [self event:^{
            [self chickIsWin];
            [vc.gameScene.touchLayer closeTouchUI];
            [self touchAnime];
            
            if (isWinObject == 1) {
                cc.isWinObject = 1;
            }
        }];
    }
    else if ([objName isEqualToString:@"moreChickens"]) {
        [self event:^{
            [self chickIsWin];
            [vc.gameScene.touchLayer closeTouchUI];
            [self touchAnime];
            
            if (isWinObject == 1) {
                cc.isWinObject = 1;
            }
            else {
                [vc.gameScene.war moreChickensHammer];
            }
        }];
    }
}

-(void)createAddGoldLabel:(NSString *)labelText
{
    SK_Label *label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:28 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
    label.text = labelText;
    label.position = CGPointMake(40, -10);
    [self addChild:label];
    label.alpha = 1;
    
    SKAction *moveUp = [SKAction moveByX:0 y:30 duration:0.3];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:1.2];
    SKAction *group = [SKAction group:@[moveUp, fadeOut]];
    
    [label runAction:group completion:^{
        [label removeFromParent];
    }];
}

-(void)chickIsWin
{
    if (isWinObject == 0) {
        return;
    }
    ViewController *vc = [ViewController single];
    vc.gameScene.war.jellys.speed = 0; //防止能量果冻继续播放声音
    [vc.gameScene winner];
}

-(void)touchAnime
{
    if ([objName isEqualToString:@"gold"]) {
        soundTouch = [SKAction playSoundFileNamed:@"Sound/addOneGold.mp3" waitForCompletion:0];
    }
    else {
        soundTouch = [SKAction playSoundFileNamed:@"Sound/gold.caf" waitForCompletion:0];
    }
    ViewController *vc = [ViewController single];
    [vc.gameScene.war runAction:soundTouch];
    
    SKAction *wait = [SKAction waitForDuration:0.8];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.21];
    float objButtonScale = objImage.xScale;
    SKAction *big_0 = [SKAction scaleTo:(1-0.15)*objButtonScale duration:oneKey*1.5*0.7];
    SKAction *big_1 = [SKAction scaleTo:(1+0.12)*objButtonScale duration:oneKey*2*0.7];
    SKAction *big_2 = [SKAction scaleTo:(1-0.065)*objButtonScale duration:oneKey*2*0.7];
    SKAction *big_3 = [SKAction scaleTo:1*objButtonScale duration:oneKey*1.5*0.7];
    SKAction *moveSeq = [SKAction sequence:@[big_0, big_1, big_2, big_3]];
    SKAction *moveUp = [SKAction moveByX:0 y:20 duration:0.21];
    SKAction *group = [SKAction group:@[moveSeq, moveUp, fadeOut, wait]];
    [objImage runAction:group completion:^{
        [self removeFromParent];
    }];
    
    [shadow runAction:fadeOut];
}


-(void)manaTouchAnime
{
    float allTime = 0.35;
    self.userInteractionEnabled = NO;
    soundTouch = [SKAction playSoundFileNamed:@"Sound/jelly_touch_3.mp3" waitForCompletion:0];
    ViewController *vc = [ViewController single];
    [vc.gameScene.war runAction:soundTouch];
    
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.2];
    [shadow runAction:fadeOut];

    SKAction *moveTo = [SKAction moveTo:CGPointMake(266, 43) duration:allTime];
    moveTo.timingMode = SKActionTimingEaseIn;
    
    SKAction *scale1 = [SKAction scaleTo:0.66 duration:0.8*allTime];
    SKAction *scale2 = [SKAction scaleTo:0.8 duration:0.12*allTime];
    SKAction *scale3 = [SKAction scaleTo:0.6 duration:0.08*allTime];
    SKAction *seqScale = [SKAction sequence:@[scale1, scale2, scale3]];
    SKAction *group = [SKAction group:@[moveTo, seqScale]];
    [self runAction:group completion:^{
        [self removeFromParent];
    }];
}


@end
