//
//  FireBall.h
//  DontEatMe
//
//  Created by pringlesfox on 8/26/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Bullet.h"
@interface FireBall : Weapon

@property (strong, nonatomic) SKEmitterNode *waveEmitter;
@property (nonatomic) BOOL accelerating;
@property CGRect bulletRect;

@property float whichJelly;
@property int damage;

- (id)initWithPosition:(CGPoint)bodyPosition zPosition:(float)zPos;
@end
