//
//  SkillBar.h
//  DontEatMe
//
//  Created by ym on 15-5-21.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SkillBar : SKSpriteNode

@property float defaultSkillCD_skillBar;

@property BOOL isCding;
-(id)initWithName:(NSString *)name;
-(void)changeBar:(float)currentHP;

@end
