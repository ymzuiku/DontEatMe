//
//  LaserBullet.h
//  AtlasTesing
//
//  Created by Tie Muer on 12/26/13.
//  Copyright (c) 2013 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Bullet.h"

@interface LaserBullet : Bullet

//@property CGRect bulletRect;
//@property int bullet;
@property CGRect rect;
@property int bulletType;
@property LaserBullet *bulletR;
@property int beSlow;

- (id)initWithPosition:(CGPoint)jellyPosition  zPosition:(float)zPos;
- (void)animationMove;
- (void)animationMove1;


@end
