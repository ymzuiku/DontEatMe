//
//  LosterAnime.m
//  DontEatMe
//
//  Created by ym on 14/7/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "LosterAnime.h"

@implementation LosterAnime
{
    SKSpriteNode *face;
    SK_Button *againButton;
//    SK_Button *reviveButton;
    SK_Button *homeButton;
    SKSpriteNode *homeBackground;
    SK_Sound *soundFirstLost;
    SK_Sound *soundScendLost;
    int hummerNumber;
    int needGood;
}

-(id)init
{
    if (self = [super initWithColor:rgb(0x000000, 0) size:CGSizeMake(iw, ih)]) {
        self.userInteractionEnabled = YES;
        self.position = CGPointMake(0, 0);
        self.anchorPoint = CGPointMake(0, 0);
        
        hummerNumber = [[[[UserCenter dic] objectForKey:@"userRecord"] objectForKey:@"freeHammer"] intValue];
        SKAction *black = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.3*1.8];
        [self runAction:black];
        
        ViewController *vc = [ViewController single];
        int classNumber = vc.gameScene.classNumber;
        
        
        if (classNumber >= 0 && classNumber <= 4) {
            needGood = 5;
        }
        else if (classNumber >= 5 && classNumber <= 12) {
            needGood = 20;
        }
        else if ((classNumber >= 13 && classNumber <= 27) || (classNumber >= 72 && classNumber <= 75)) {
            needGood = 40;
        }
        else if ((classNumber >= 28 && classNumber <= 35) || (classNumber >= 76 && classNumber <= 79)) {
            needGood = 80;
        }
        else if (classNumber >= 36 && classNumber <= 53) {
            needGood = 150;
        }
        else if ((classNumber >= 54 && classNumber <= 61) || (classNumber >= 80 && classNumber <= 82)) {
            needGood = 220;
        }
        else if (classNumber >= 62 && classNumber <= 70) {
            needGood = 450;
        }
        else if (classNumber == 71) {
            needGood = 9999;
        }
        else {
            needGood = 50;
        }
        
        [self createButtons];
        [self touchButtonsEvens];
        
        soundFirstLost = [SK_Sound createNewSound:@"Sound/boom_attack_2.mp3" repeat:0];
        soundScendLost = [SK_Sound createNewSound:@"Sound/ui_prize.mp3" repeat:0];
        [soundFirstLost play];
        SKAction *wait = [SKAction waitForDuration:2.5];
        [self runAction:wait completion:^{
            [soundScendLost play];
        }];
        
    }
    return self;
}

-(void)removeFromParent
{
    [soundFirstLost stop]; soundFirstLost = nil;
    [soundScendLost stop]; soundScendLost = nil;
    
    [face removeFromParent];
    face = nil;
    [againButton removeFromParent];
    againButton = nil;
//    [reviveButton removeFromParent];
    [homeButton removeFromParent];
    homeButton = nil;
    [homeBackground removeFromParent];
    homeBackground = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}

-(void)createButtons
{
    againButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_games_other", 3)];
    againButton.position = CGPointMake(iw/2, ih/2+ih/10-120-100);
    [self addChild:againButton];
    againButton.alpha = 0;
    
    SKSpriteNode *cookImage = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_other", 4)];
    cookImage.position = CGPointMake(-130, 0);
    [againButton addChild:cookImage];
    
    SK_Label *cookLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:30 color:rgb(0x98A721, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
    cookLabel.position = CGPointMake(35, 0);
    cookLabel.text = @"x1";
    [cookImage addChild:cookLabel];
    
    SK_Label *againLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:36 color:rgb(0x98A721, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    againLabel.position = CGPointMake(66, 0);
    againLabel.text = iString(@"again");
    [againButton addChild:againLabel];
    
    homeBackground = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_bottom")[13]];
    homeBackground.anchorPoint = CGPointMake(0, 0);
    homeBackground.position = CGPointMake(0, 0);
    [self addChild:homeBackground];
    
    homeButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_lawn")[16]];
    homeButton.position = CGPointMake(57, 64);
    [homeBackground addChild:homeButton];
    
    face = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_bottom")[0]];
    [face setScale:2];
    face.position = CGPointMake(iw/2, ih/2+ih/10-100);
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_lost_create") timePerFrame:oneKey];
    SKAction *wait = [SKAction animateWithTextures:Atlas(@"ui_games_lost_rest") timePerFrame:oneKey];
    SKAction *repa = [SKAction repeatActionForever:wait];
    SKAction *seq = [SKAction sequence:@[anime, repa]];
    [face runAction:seq];
    [self addChild:face];
    [self moveFace];
}

-(void)moveFace
{
    SKAction *action0 = [self createAction:1];
    SKAction *action1 = [self createAction:1.2];
    SKAction *seq0 = [SKAction sequence:@[action0, action1]];
    [face runAction:[SKAction repeatActionForever:seq0]];
    
    SKAction *move = [SKAction moveByX:0 y:180 duration:0.3];
    [face runAction:move];
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.3];
    [againButton runAction:fadeIn];
//    [reviveButton runAction:fadeIn];
}

-(SKAction *)createAction:(float)value
{
    SKAction *wait = [SKAction waitForDuration:0.3/3*value];
    SKAction *roteUp = [SKAction rotateByAngle:iPI(-0.6) duration:0.3*3*value];
    SKAction *moveUp = [SKAction moveByX:0 y:10 duration:0.3*4*value];
    SKAction *roteDown = [SKAction rotateByAngle:iPI(0.6) duration:0.3*4*value];
    SKAction *moveDown = [SKAction moveByX:0 y:-10 duration:0.3*5*value];
    SKAction *seq = [SKAction sequence:@[wait, roteUp, moveUp, roteDown, moveDown]];
    seq.timingMode = SKActionTimingEaseInEaseOut;
    return seq;
}

-(void)reloadCook:(void(^)())block
{
    int next = [[[UserCenter dic] objectForKey:@"cook"] intValue]-1;
    [[UserCenter dic] setValue:@(next) forKey:@"cook"];
    
    ViewController *vc = [ViewController single];
    [vc.gameScene.topBar reloadLabel:block];
}

-(void)touchButtonsEvens
{
    ViewController *vc = [ViewController single];
    
    [againButton event:^{
        int cook = [[[UserCenter dic] objectForKey:@"cook"] intValue];
        if (cook>0) {
            [self reloadCook:^{
                [vc.gameScene reloadGame];
                [self removeFromParent];
            }];
        }
        else {
            [vc.gameScene.topBar tipPickCook];
        }
    }];
    
    /*
    [reviveButton event:^{
        int gold = [[[UserCenter dic] objectForKey:@"gold"] intValue];
        if (hummerNumber > 0) {
            [[[UserCenter dic] objectForKey:@"userRecord"] setValue:@(hummerNumber-1) forKey:@"freeHammer"];
            [vc.gameScene goon];
            SKAction *black = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.3*1.8];
            [self runAction:black completion:^{
                [vc.gameScene.topBar moveUp];
                [vc.gameScene revive];
                [vc.gameScene.buttonBar showGamesBar];
                [self removeFromParent];
            }];
            SKAction *fadeOut = [SKAction fadeOutWithDuration:0.3];
            [face runAction:fadeOut];
            [homeBackground runAction:fadeOut];
            [againButton runAction:fadeOut];
            [reviveButton runAction:fadeOut];
        }
        else if (gold >= needGood) {
            [UserCenter addGold:-needGood];
            void (^block)() = ^{
                SKAction *black = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.3*1.8];
                [self runAction:black completion:^{
                    [vc.gameScene.topBar moveUp];
                    [vc.gameScene revive];
                    [vc.gameScene.buttonBar showGamesBar];
                    [self removeFromParent];
                }];
                SKAction *fadeOut = [SKAction fadeOutWithDuration:0.3];
                [face runAction:fadeOut];
                [homeBackground runAction:fadeOut];
                [againButton runAction:fadeOut];
                [reviveButton runAction:fadeOut];
            };
            [vc.gameScene goon];
            [vc.gameScene.topBar reloadLabel:block];
            
        }
        else {
            [vc.gameScene.topBar tipPickGold];
        }
    }];
    */
     
    [homeButton event:^{
        [vc.gameScene gotoMap:-1];
        [self removeFromParent];
    }];
}


@end
