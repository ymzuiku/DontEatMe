//
//  TouchButton.h
//  DontEatMe
//
//  Created by ym on 14/7/7.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "SK_Button.h"

@interface TouchButton : SKSpriteNode
{
    int _mana;
    BOOL _canCreateJelly;
}
@property (nonatomic) int mana;
@property (nonatomic) float time;
@property (nonatomic) BOOL canCreateJelly;
@property (nonatomic) BOOL isTimeOver;
-(void)event:(void (^)())block;
-(void)addGemA:(BOOL)isGemA gemB:(BOOL)isGemB;

@end
