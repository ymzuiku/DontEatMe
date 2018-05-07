//
//  JellyXiaowei.m
//  DontEatMe
//
//  Created by ym on 15/4/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "JellyXiaowei.h"

@implementation JellyXiaowei
{
    ClassCenter *cc;
    BOOL isStarBooming;
    SKNode *chickens;
    BOOL isGameOver;
    SK_Button *hummerButton;
    BOOL isUseHummered;
    int hummerNumber;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"xiaowei";
    self.texString_attack = @"jelly_xiaowei_rest3";
    self.texString_rest = @"jelly_xiaowei_rest3";
    [self sitDefaultHP:3];
    self.attack = 500;
    self.defBoxRect = CGRectMake(-130, -30, 260, 60);
    self.defAttackRect = CGRectMake(-520/2, -300/2, 520, 300);
    self.position = CGPointMake(iw/2, -50);
    self.zPosition = 1999 - 250;
    Grid *myGrid = [GridArray getGridArray][40];
    myGrid.hasNode = 9;
    myGrid.nodeInGrid = self;
    self.speedRest = 0.6;
    ViewController *vc = [ViewController single];
    chickens = vc.gameScene.war.chickens;
    cc = [ClassCenter singleton];
    hummerNumber = [[[[UserCenter dic] objectForKey:@"userRecord"] objectForKey:@"freeHammer"] intValue];
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    if (isStarBooming == YES) {
        return NO;
    }
    if (hurt%10 == 7) {
        return NO;
    }
    BOOL isDie = NO;
    isStarBooming = YES;
    
    
    self.nowHP -= 1;
    cc.startNumber -= 1;
    
    if (self.nowHP >= 0) {
        [self skill:attacker];
    }
    else if (self.nowHP < 0) {
        isDie = YES;
        [self useDie];
        ViewController *vc = [ViewController single];
        if (isGameOver == NO) {
            isGameOver = YES;
            [vc.gameScene loster];
        }
    }
    return isDie;
}

-(void)useAttack
{
//    [self useHummer];
}

-(void)useHummer
{
    if (isUseHummered == YES) {
        return;
    }
    
    if (hummerButton == nil) {
        if (hummerNumber > 0) {
            hummerButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_scene_hammer")[2]];
        }
        else {
            hummerButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_scene_hammer")[3]];
        }
        
        hummerButton.position = CGPointMake(200, -32);
        [self addChild:hummerButton];
        hummerButton.hidden = YES;
    }
    
    if (hummerButton.hidden == NO) {
        return;
    }
    
    ViewController *vc = [ViewController single];
    if (hummerNumber <= 0) {
        [vc.gameScene.topBar moveDown];
    }
    
    hummerButton.zPosition = 1999.5-self.zPosition+0.1;
    hummerButton.hidden = NO;
    SKAction *whiter = [SK_Actions actionWaterOnes];
    SKAction *comple = [SKAction runBlock:^{
        hummerButton.hidden = YES;
        SKAction *miniWait = [SKAction waitForDuration:1];
        SKAction *miniBlock = [SKAction runBlock:^{
            if (hummerButton.hidden == YES) {
                [vc.gameScene.topBar moveUp];
            }
        }];
        SKAction *miniSeq = [SKAction sequence:@[miniWait, miniBlock]];
        [self runAction:miniSeq withKey:@"closeHummerButton"];
    }];
    SKAction *seq = [SKAction sequence:@[whiter, comple]];
    [hummerButton runAction:seq withKey:s_attack];
    
    [hummerButton event:^{
        int gold = [[[UserCenter dic] objectForKey:@"gold"] intValue];
        
        if (hummerNumber > 0) {
            [[[UserCenter dic] objectForKey:@"userRecord"] setValue:@(hummerNumber-1) forKey:@"freeHammer"];
            [vc.gameScene goon];
            SKAction *black = [SKAction waitForDuration:1];
            [self runAction:black completion:^{
                [vc.gameScene.topBar moveUp];
                [vc.gameScene revive];
                [vc.gameScene.buttonBar showGamesBar];
            }];
            hummerButton.hidden = YES;
            isUseHummered = YES;
        }
        else if (gold >= 20) {
            [UserCenter addGold:-20];
            void (^block)() = ^{
                SKAction *black = [SKAction waitForDuration:1];
                [self runAction:black completion:^{
                    [vc.gameScene.topBar moveUp];
                    [vc.gameScene revive];
                    [vc.gameScene.buttonBar showGamesBar];
                }];
            };
            [vc.gameScene goon];
            [vc.gameScene.topBar reloadLabel:block];
            hummerButton.hidden = YES;
            isUseHummered = YES;
        }
        else {
            [vc.gameScene.topBar tipPickGold];
        }
    }];
}

-(void)move
{
    self.canNotChangeStatus = @[s_move];
    SKAction *moveAnime = [SKAction animateWithTextures:Atlas(@"jelly_xiaowei_move") timePerFrame:0.042 resize:YES restore:NO];
    SKAction *repAnime = [SKAction repeatActionForever:moveAnime];
    [self runAction:repAnime];
    
    float moveTime = iPhone5?4:2.5;
    SKAction *moveUp = [SKAction moveTo:CGPointMake(iw/2, ih-896) duration:moveTime];
    [self runAction:moveUp completion:^{
        [self reloadRect];
        [self resetZPostion];
        [self removeAllActions];
        [self rest];
    }];
}

-(void)rest
{
    if ([self changCanStatusRun:s_rest] == NO) {
        return;
    }
    SKAction *rest = [SKAction animateWithTextures:Atlas(self.texString_rest) timePerFrame:oneKey/self.speedRest resize:YES restore:NO];
    self.restAction = [SKAction repeatActionForever:rest];
    [self runAction:self.restAction withKey:s_rest];
}

-(void)skill:(Body *)attacker
{
    if ([self changCanStatusRun:s_skill] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_skill];
    
    if (!self.attackAction) {
        SKAction *completion = [SKAction runBlock:^{
            isStarBooming = NO;
            [self rest];
            self.canNotChangeStatus = @[];
        }];
        
        SKAction *scale1 = [SKAction scaleXTo:1 y:1.15 duration:0.15];
        SKAction *scale2 = [SKAction scaleXTo:1 y:0.95 duration:0.15];
        SKAction *scale3 = [SKAction scaleXTo:1 y:1.05 duration:0.15];
        SKAction *scale4 = [SKAction scaleXTo:1 y:1 duration:0.15];
        
        SKAction *attackAnima = [SKAction sequence:@[scale1, scale2, scale3, scale4]];
        SKAction *shoot = [SKAction runBlock:^{
            [self shoot];
            [attacker changeHP:self.attack attacker:nil];
            for (Chicken *chicken in chickens.children) {
                if (CGRectIntersectsRect(self.attackRect, chicken.boxRect)) {
                    [chicken changeHP:self.attack attacker:self];
                }
            }
        }];
        self.attackAction = [SKAction sequence:@[shoot, attackAnima, completion]];
    }
    [self runAction:self.attackAction withKey:s_skill];
}

-(void)shoot
{
    if (self.nowHP == 2) {
        self.texture = Atlas(@"jelly_xiaowei_rest2")[0];
        self.texString_rest = @"jelly_xiaowei_rest2";
        
        SKAction *boomStart = [SKAction animateWithTextures:Atlas(@"jelly_xiaowei_startBoom") timePerFrame:0.03 resize:YES restore:NO];
        SKSpriteNode *startAimaeNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"jelly_xiaowei_startBoom")[0]];
        [startAimaeNode setScale:1.5];
        [self addChild:startAimaeNode];
        startAimaeNode.position = CGPointMake(69, 28);
        startAimaeNode.zRotation = iPI(-30);
        [startAimaeNode runAction:boomStart];
        SKAction *sound_start1 = [SKAction playSoundFileNamed:@"Sound/star_1s.mp3" waitForCompletion:NO];
        [self runAction:sound_start1];
    }
    else if (self.nowHP == 1) {
        self.texture = Atlas(@"jelly_xiaowei_rest1")[0];
        self.texString_rest = @"jelly_xiaowei_rest1";
        
        SKAction *boomStart = [SKAction animateWithTextures:Atlas(@"jelly_xiaowei_startBoom") timePerFrame:0.03 resize:YES restore:NO];
        SKSpriteNode *startAimaeNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"jelly_xiaowei_startBoom")[0]];
        [startAimaeNode setScale:1.5];
        [self addChild:startAimaeNode];
        startAimaeNode.position = CGPointMake(0, 32);
        startAimaeNode.zRotation = iPI(10);
        [startAimaeNode runAction:boomStart];
        SKAction *sound_start1 = [SKAction playSoundFileNamed:@"Sound/star_2s.mp3" waitForCompletion:NO];
        [self runAction:sound_start1];
    }
    else if (self.nowHP == 0) {
        self.texture = Atlas(@"jelly_xiaowei_rest0")[0];
        self.texString_rest = @"jelly_xiaowei_rest0";
        
        SKAction *boomStart = [SKAction animateWithTextures:Atlas(@"jelly_xiaowei_startBoom") timePerFrame:0.03 resize:YES restore:NO];
        SKSpriteNode *startAimaeNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"jelly_xiaowei_startBoom")[0]];
        [startAimaeNode setScale:1.5];
        [self addChild:startAimaeNode];
        startAimaeNode.position = CGPointMake(-69, 28);
        startAimaeNode.zRotation = iPI(40);
        [startAimaeNode runAction:boomStart];
        SKAction *sound_start1 = [SKAction playSoundFileNamed:@"Sound/star_3s.mp3" waitForCompletion:NO];
        [self runAction:sound_start1];
    }
}

-(void)beBuff_ice:(float)time attackSpeed:(float)attackSpeed{}
-(void)beBuff_dizzy:(float)time random:(int)randomIceBuff{}
-(void)beBuff_dizzyLong:(float)time{}
-(void)beBuff_poison:(float)time attack:(float)value{}
-(void)beBuff_slow:(float)time moveSpeed:(float)value attackSpeed:(float)valueB{}
-(void)beBuff_binding:(float)time attack:(float)value{}
-(void)beBuff_sleep:(float)time{}
-(void)beBuff_snail:(float)time changeHPRate:(float)value{}
-(void)beBuff_normalChicken{}
-(void)beBuff_Boom:(float)time hurt:(float )theHurt{}
-(void)beBuff_Yoda:(float)time hurt:(float )theHurt{}
-(void)beBuff_Stave:(float)time hurt:(float )theHurt{}
-(void)beBuff_Floor:(float)time hurt:(float)theHurt{}

//增益buff
-(void)beBuff_Shield:(float)time shieldHP:(int)shieldHP noDieTime:(float)noDieTime{}
-(void)beBuff_Cure:(float)time hp:(float)addHPRate{}
-(void)beBuff_Amok:(float)time speed:(float)speed{}
-(void)beBuff_recovery:(float)time miniCD:(float)miniCD hurt:(int)hurt{}


@end
