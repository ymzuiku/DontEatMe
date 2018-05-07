//
//  Chest.m
//  DontEatMe
//
//  Created by ym on 15/5/28.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "Chest.h"
#import "ShowAddCookGoldView.h"

@implementation Chest
{
    SK_Button *button;
    SKSpriteNode *star;
    SK_Label *label;
    int chestNum;
    int needNumber;
}

-(void)removeFromParent
{
    [button removeAllChildren];
    [button removeFromParent];
    button = nil;
    
    [star removeAllChildren];
    [star removeFromParent];
    star = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}

-(id)initWithNowNumber:(int)nowNumber needNumber:(int)theNeedNumber chestNum:(int)theChestNum;
{
    needNumber = theNeedNumber;
    chestNum = theChestNum;
    int isOpen = [[[UserCenter dic] objectForKey:@"chestIsOpen"][chestNum] intValue];
    if (self = [super initWithTexture:Atlas(@"ui_map_chest")[isOpen]]) {
        button = [SK_Button spriteNodeWithColor:rgb(0x000000, 0) size:CGSizeMake(120, 150)];
        button.position = CGPointMake(-20, 40);
        button.zPosition = 0.2;
        button.backgoundImage = self;
        [button event:^{
            if (nowNumber >= needNumber && isOpen == 0) {
                [self buttonTouch];
            }
        }];
        [self addChild:button];
        
        if (isOpen == 0) {
            star = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_chest")[2]];
            star.position = CGPointMake(-20, 90);
            star.zPosition = 0.1;
            [self addChild:star];
            
            label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:28 color:rgb(0x43aaf3, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
            label.position = CGPointMake(-24, 5);
            label.text = [NSString stringWithFormat:@"%d/%d", nowNumber, needNumber];
            [star addChild:label];
        }
    }
    return self;
}

-(void)buttonTouch
{
    [[UserCenter dic] objectForKey:@"chestIsOpen"][chestNum] = @1;
    ViewController *vc = [ViewController single];
    
    if (needNumber == 25) {
        needNumber = 50;
    }
    
    ShowAddCookGoldView *addGoldView = [ShowAddCookGoldView createWithIsGold:YES number:needNumber/2 backCall:nil];
    addGoldView.position = CGPointMake(iw/2, ih/2);
    [vc.mapScene addChild:addGoldView];
    
    SKAction *wait = [SKAction waitForDuration:1.5];
    [self runAction:wait completion:^{
        ShowAddCookGoldView *addCookView = [ShowAddCookGoldView createWithIsGold:NO number:4+chestNum backCall:^{
            [vc.mapScene.topBar reloadLabel:nil];
        }];
        addCookView.position = CGPointMake(iw/2, ih/2-40);
        [vc.mapScene addChild:addCookView];
    }];
    
    self.texture = Atlas(@"ui_map_chest")[1];
    [label removeFromParent];
    [star removeFromParent];
    [UserCenter save];
}



@end
