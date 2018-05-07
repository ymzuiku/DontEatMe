//
//  GoldBar.h
//  DontEatMe
//
//  Created by ym on 14-7-4.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TopBar : SKSpriteNode

@property int isCanSee;

-(void)reloadLabel:(void(^)())block;
-(void)tipPickCook;
-(void)tipPickGold;
-(void)moveDown;
-(void)moveUp;
-(void)hiddenBackground;
-(void)showBackground;
-(void)reloadCookLabel;

@end
