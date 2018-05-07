//
//  MiniRobotBullet.h
//  DontEatMe
//
//  Created by 木尔 铁 on 24/2/15.
//  Copyright (c) 2015 ym. All rights reserved.
//

#import "Weapon.h"

@interface MiniRobotBullet : Weapon

@property CGRect bulletRect;
@property int damage;

- (id)initWithPosition:(CGPoint)jellyPosition  zPosition:(float)zPos;
- (int)attack:(CGRect)pirateCollinRect;
- (void)animationMove;
- (void)animationBlowUp:(Body *)targetBody;

@end
