//
//  TouchLayer.h
//  DontEatMe
//
//  Created by ym on 14/7/6.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TouchButton.h"

@interface TouchLayer : SKSpriteNode

-(void)changeMana:(int)theMana;
-(void)closeTouchUI;
-(void)createTreeDic;

@property (nonatomic) BOOL isCanTouch;
@property (nonatomic) BOOL isCanSpoon;
@property (nonatomic) NSMutableArray *buttonArray;

@end
