//
//  ShieldBuff.h
//  DontEatMe
//
//  Created by ym on 15/1/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "Buff.h"

@interface ShieldBuff : Buff

@property float noDieTime;
@property float shieldHP;
-(void)shieldChangeHP:(int)hurt;

@end
