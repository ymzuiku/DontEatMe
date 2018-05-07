//
//  FreeWhistlePro.m
//  DontEatMe
//
//  Created by ym on 14/12/19.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "FreeWhistlePro.h"

@implementation FreeWhistlePro
{
    AVAudioPlayer *winnerSound;
    SK_Button *nextButton;
    SK_Button *buyButton;
    SKSpriteNode *background;
    SKVideoNode *video;
}

-(id)initWith:(NSString *)string;
{
    if (self = [super initWithColor:rgb(0x000000, iGrayFloat) size:CGSizeMake(iw, ih)]) {
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        [self createScene];
        [self touchEvent];
        [self moveUpFadeIn:background];
        
    }
    return self;
}

-(void)createScene
{
    background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_free")[1]];
    background.zPosition = self.zPosition +1;
    background.position = CGPointMake(iw/2, ih/2);
    [self addChild:background];
    
    SKSpriteNode *whistleImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_free")[30]];
    whistleImage.position = CGPointMake(0, 124);
    [background addChild:whistleImage];
    
    SK_Label *title = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:27 color:rgb(0xc18eec, 0.8) horizontal:SKLabelHorizontalAlignmentModeLeft];
    title.text = iString(@"whistleProTitle");
    title.position = CGPointMake(-185, -60);
    [background addChild:title];
    
    int lineNumber = iSEnglish ? 22 : 11;
    SK_Label *info = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:lineNumber size:36 color:rgb(0xc18eec, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
    info.text = iString(@"whistleProInfo");
    info.position = CGPointMake(-185, -125);
    [background addChild:info];
    
    nextButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[2]];
    nextButton.position = CGPointMake(115, -282);
    [background addChild:nextButton];
    
    buyButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[3]];
    buyButton.position = CGPointMake(-113, -282);
    [background addChild:buyButton];
    
    int needGold = 720;
    SK_Label *buyLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:lineNumber size:38 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    buyLabel.text = [NSString stringWithFormat:@"%d", needGold];
    buyLabel.position = CGPointMake(8, -1);
    [buyButton addChild:buyLabel];
    
    ViewController *vc = [ViewController single];
    [vc.gameScene pause];
    [vc.gameScene.buttonBar hiddenBar];
}

-(void)moveUpFadeIn:(SKSpriteNode *)sprite
{
    sprite.alpha = 0;
    float value = -0.3;
    SKAction *move_0 = [SKAction moveBy:CGVectorMake(0, -100*value) duration:0.01];
    SKAction *move_1 = [SKAction moveBy:CGVectorMake(0, 120*value) duration:0.3];
    SKAction *move_2 = [SKAction moveBy:CGVectorMake(0, -30*value) duration:0.3*1.2];
    SKAction *move_3 = [SKAction moveBy:CGVectorMake(0, 10*value) duration:0.3*1.6];
    SKAction *seq = [SKAction sequence:@[move_0, move_1, move_2, move_3]];
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.3*1.2];
    SKAction *group = [SKAction group:@[seq, fadeIn]];
    group.timingMode = SKActionTimingEaseInEaseOut;
    [sprite runAction:group completion:^{
        SKAction *action0 = [self createAction:1];
        SKAction *action1 = [self createAction:1.2];
        
        SKAction *seq0 = [SKAction sequence:@[action0, action1]];
        [sprite runAction:[SKAction repeatActionForever:seq0]];
    }];
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

-(void)touchEvent
{
    ViewController *vc = [ViewController single];
    [nextButton event:^{
        [self removeFromParent];
        [vc.gameScene.buttonBar showGamesBar];
        [vc.gameScene goon];
    }];
    
    [buyButton event:^{
        int nowGold = [[[UserCenter dic] objectForKey:@"gold"] intValue];
        int needGold = 720;
        if (needGold < nowGold && needGold > 0) {
            [UserCenter addGold:-needGold];
            [[[UserCenter dic] objectForKey:@"userRecord"] setValue:@2 forKey:@"whistle"];
            [UserCenter save];
            [vc.gameScene.buttonBar reloadWhistlePro];
            void (^tempBlock)() = ^{
                SKAction *fadeOut = [SKAction fadeOutWithDuration:0.6];
                [buyButton runAction:fadeOut completion:^{
                    [buyButton removeFromParent];
                }];
            };
            [vc.gameScene.topBar reloadLabel:tempBlock];
        }else {
            [vc.gameScene.topBar tipPickGold];
        }
    }];
}

-(void)removeFromParent
{
    [winnerSound stop]; winnerSound = nil;
    [video pause];
    [video removeFromParent];
    [self removeAllActions];
    [super removeFromParent];
}


@end
