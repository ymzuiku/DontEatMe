//
//  Buff.h
//  DontEatMe
//
//  Created by ym on 15/1/20.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class Body;

@interface Buff : SKSpriteNode

@property   float time;
@property   float hurt;
@property   float attackSpeed;
@property   float moveSpeed;
@property   float skillSpeed;
//@property   float otherValue;

@property   BOOL isBuffing;

-(id)initWithBody:(Body *)aBody;
-(void)beginBuff;
-(void)clearBuff;
-(void)changeColorIn:(UIColor *)color blend:(float)blend time:(float)time body:(SKNode *)aBody;
-(void)changeColorOutWithBody:(SKNode *)aBody;

@end
