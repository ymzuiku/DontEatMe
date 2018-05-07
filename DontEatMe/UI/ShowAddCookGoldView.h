//
//  ShowAddCookGoldView.h
//  DontEatMe
//
//  Created by ym on 15/3/3.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ShowAddCookGoldView : SKSpriteNode

+(id)createWithIsGold:(BOOL)isGold number:(int)number backCall:(void (^)())backCall;
-(id)initWithIsGold:(BOOL)isGold number:(int)number backCall:(void (^)())backCall;

@end
