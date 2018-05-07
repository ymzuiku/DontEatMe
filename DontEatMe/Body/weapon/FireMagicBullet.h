//
//  FireMagicBullet.h
//  DontEatMe
//
//  Created by ym on 15-5-21.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "Weapon.h"

@interface FireMagicBullet : Weapon

@property CGRect bulletRect;
@property int damage;

- (id)initWithPosition:(CGPoint)jellyPosition  zPosition:(float)zPos;
- (int)attack:(CGRect)pirateCollinRect;
- (void)animationMove;
- (void)animationBlowUp;

@end
