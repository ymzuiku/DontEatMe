//
//  ButtonBar.h
//  DontEatMe
//
//  Created by ym on 14-5-3.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ButtonBar : SKSpriteNode

-(void)hiddenBar;
-(void)showGamesBar;
-(void)changeMana:(int)theMana;
-(void)reloadWhistlePro;

@property (nonatomic) SK_Button *whistleButton;
@property (nonatomic) SK_Button *whistleProButton;

@end
