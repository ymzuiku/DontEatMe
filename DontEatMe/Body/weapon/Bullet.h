//
//  Bullet.h
//  AtlasTesing
//
//  Created by Tie Muer on 12/9/13.
//  Copyright (c) 2013 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Weapon.h"

@interface Bullet : Weapon

@property CGRect bulletRect;

@property int isThrough;

- (id)init;
- (void)animationMove;
- (void)animationBlowUp:(NSString *)chickenName;


@end
