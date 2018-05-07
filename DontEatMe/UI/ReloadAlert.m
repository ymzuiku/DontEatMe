//
//  ReloadAlert.m
//  DontEatMe
//
//  Created by ym on 14/12/27.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "ReloadAlert.h"

@implementation ReloadAlert
{
    BOOL isBlack;
    SK_Button *okButton;
    SK_Button *cancelButton;
    void (^cancelBlock)();
}

-(id)init
{
    if (self = [super initWithColor:rgb(0x000000, 0.0) size:CGSizeMake(iw, ih)]) {
        self.userInteractionEnabled = YES;
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        isBlack = NO;
        
        [self createButton];
        [self touchButtonsEvens];
    }
    return self;
}

-(void)cancel:(void (^)())block
{
    cancelBlock = block;
}

-(void)createButton
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_main_alert", 0)];
    background.position = CGPointMake(iw/2, ih/2+70);
    [self addChild:background];
    
    okButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_main_alert", 2)];
    okButton.position = CGPointMake(104, -71);
    [background addChild:okButton];
    
    cancelButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_main_alert", 1)];
    cancelButton.position = CGPointMake(-99, -71);
    [background addChild:cancelButton];
    
    int line = iSEnglish ? 20 : 13;
    SK_Label *label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:line size:36 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];   //rgb(0x91B000, 1)
    label.text = iString(@"again game");
    label.position = CGPointMake(0, 40);
    [background addChild:label];
}

-(void)colorBlack:(dispatch_block_t)block
{
    if (isBlack == NO) {
        self.position = CGPointMake(0, 0);
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.3*0.6];
        [self runAction:color completion:^{
            if (block != nil) block();
        }];
        isBlack = YES;
    }
    
    else if (isBlack == YES) {
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, 0) colorBlendFactor:1 duration:0.3*0.6];
        [self runAction:color completion:^{
            if (block != nil) block();
            self.position = CGPointMake(640*2, 0);
        }];
        isBlack = NO;
    }
}

-(void)touchButtonsEvens
{
    ViewController *vc = [ViewController single];
    StaticActions *sa = [StaticActions single];
    [okButton playSound:sa.sound_buttonB];
    
    [okButton event:^{
        
        int nowCook = [[[UserCenter dic] objectForKey:@"cook"] intValue];
        if (nowCook > 0 || vc.gameScene.classNumber < 4) {
            [UserCenter addCook:-1];
            if (vc.gameScene.topBar) {
                [vc.gameScene.topBar reloadLabel:^{
                    [vc.gameScene goon];
                    [vc.gameScene reloadGame];
                    [self removeFromParent];
                }];
            }
            else {
                [vc.gameScene goon];
                [vc.gameScene reloadGame];
                [self removeFromParent];
            }

        }
        else {
           [vc.gameScene.topBar tipPickCook];
        }
    }];
    
    [cancelButton playSound:sa.sound_buttonA];
    [cancelButton event:^{
        if (cancelBlock) {
            cancelBlock();
            [self removeFromParent];
        }
        else {
            [self colorBlack:^{
                [self removeFromParent];
            }];
        }
    }];
}

@end
