//
//  RobotBullet.h
//  DontEatMe
//
//  Created by pringlesfox on 8/7/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Weapon.h"

@interface RobotBullet : Weapon

@property CGRect bulletRect;
@property int damage;

- (id)initWithPosition:(CGPoint)jellyPosition  zPosition:(float)zPos;
- (int)attack:(CGRect)pirateCollinRect;
- (void)animationMove;
- (void)animationBlowUp;

@end
