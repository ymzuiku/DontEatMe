//
//  AboutUs.m
//  DontEatMe
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AboutUs.h"

@implementation AboutUs
{
    BOOL isMiddle;
    SKSpriteNode *plate;
    SK_Button *shareButton;
    SK_Button *closeButton;
    SKSpriteNode *cookImage;
    SKSpriteNode *canvas;
}

-(id)init
{
    if (self = [super initWithColor:rgb(0x000000, 0.0) size:CGSizeMake(iw, ih)]) {
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        
        [self createButton];
        [self moveWindow];
        [self buttonsEvent];
    }
    return self;
}

-(void)createButton
{
    canvas = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(iw, ih)];
    canvas.position = CGPointMake(0, 0);
    canvas.anchorPoint = CGPointMake(0, 0);
    [self addChild:canvas];
    
    plate = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_main_about", 0)];
    plate.anchorPoint = CGPointMake(0, 0);
    plate.position = CGPointMake(51, -50);
    [canvas addChild:plate];
    
    SKSpriteNode *dateImage = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_main_about", 2)];
    dateImage.position = CGPointMake(280-10, 460-60+40);
    [plate addChild:dateImage];
    
    closeButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_main_about", 1)];
    closeButton.position = CGPointMake(500, 171+40);
    [plate addChild:closeButton];
    
    shareButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_main_about", 3)];
    shareButton.position = CGPointMake(plate.size.width/2, 662+40);
    [plate addChild:shareButton];
    
    cookImage = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_main_about", 4)];
    cookImage.position = CGPointMake(0, 10);
    [shareButton addChild:cookImage];
}

-(void)moveWindow
{
    StaticActions *sa = [StaticActions single];
    if (!isMiddle) {
        //移动视图
        canvas.position = CGPointMake(0, -canvas.size.height);
        [canvas runAction:sa.actionSpringUpWindow];
        //背景发灰
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.3*1.8];
        [self runAction:color];
        isMiddle = YES;
        
    }
    else if (isMiddle) {
        //移动视图
        [canvas runAction:sa.actionSpringDownWindow];
        //背景透明
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, 0) colorBlendFactor:1 duration:0.3*1.8];
        [self runAction:color completion:^{
            [self removeAllChildren];
            [self removeFromParent];
        }];
        
        ViewController *vc = [ViewController single];
        [vc.homeScene moveBar];
        
        isMiddle = NO;
    }
}


-(void)buttonsEvent
{
    StaticActions *sa = [StaticActions single];
    [shareButton playSound:sa.sound_buttonA];
    [shareButton event:^{
        [UserCenter createNewDic];
        [UserCenter save];
    }];
    
    [closeButton playSound:sa.sound_buttonA];
    [closeButton event:^{
        [self moveWindow];
    }];
}

@end
