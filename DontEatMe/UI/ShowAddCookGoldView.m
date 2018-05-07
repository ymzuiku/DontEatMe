//
//  ShowAddCookGoldView.m
//  DontEatMe
//
//  Created by ym on 15/3/3.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "ShowAddCookGoldView.h"

@implementation ShowAddCookGoldView

+(id)createWithIsGold:(BOOL)isGold number:(int)number backCall:(void (^)())backCall
{
    return [[self alloc] initWithIsGold:isGold number:number backCall:backCall];
}

-(id)initWithIsGold:(BOOL)isGold number:(int)number backCall:(void (^)())backCall
{
    SKTexture *backTexture;
    if (isGold) {
        backTexture = Atlas(@"ui_map_topBar")[5];
    }
    else {
        backTexture = Atlas(@"ui_map_topBar")[4];
    }
    if (self = [super initWithTexture:backTexture]) {
        self.zPosition = 9900;
        SK_Label *label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:40 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeLeft];
        label.position = CGPointMake(-20, 65);
        if (number > 0) {
            label.text = [NSString stringWithFormat:@"+%d", number];
        }
        else if (number < 0) {
            label.text = [NSString stringWithFormat:@"%d", number];
        }
        [self addChild:label];
        
        
        if (isGold) {
            [UserCenter addGold:number]; 
        }
        else {
            [UserCenter addCook:number];
        }
        
        self.alpha = 0.5;
        SKAction *moveUp = [SKAction moveByX:0 y:50 duration:1];
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.4];
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.6];
        SKAction *group = [SKAction group:@[moveUp, fadeIn]];
        SKAction *group2 = [SKAction group:@[moveUp, fadeOut]];
        SKAction *seq = [SKAction sequence:@[group, group2]];
        [self runAction:seq completion:^{
            if (backCall) {
                backCall();
            }
            [self removeFromParent];
        }];

    }
    return self;
}

@end
