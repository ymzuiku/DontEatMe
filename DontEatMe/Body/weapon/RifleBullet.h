//
//  RifleBullet.h
//  AtlasTesing
//
//  Created by pringlesfox on 4/23/14.
//  Copyright (c) 2014 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Weapon.h"

@interface RifleBullet : Weapon

@property CGRect bulletRect;
@property int damage;

- (id)initWithPosition:(CGPoint)jellyPosition  zPosition:(float)zPos;
- (int)attack:(CGRect)pirateCollinRect;
- (void)animationMove;
- (void)animationBlowUp;


@end
