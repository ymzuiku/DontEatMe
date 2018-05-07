//
//  BounceBullet.h
//  DontEatMe
//
//  Created by pringlesfox on 8/19/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Weapon.h"

@interface BounceBullet : Weapon

@property CGRect bulletRect;
@property int damage;
@property int dizze;
@property int slow;
@property int isThrough;
@property int isPoison;

- (id)initWithPosition:(CGPoint)jellyPosition  zPosition:(float)zPos;
- (int)attack:(CGRect)pirateCollinRect;
- (void)animationMove;
- (void)animationBlowUp;

@end
