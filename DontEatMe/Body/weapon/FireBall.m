//
//  FireBall.m
//  DontEatMe
//
//  Created by pringlesfox on 8/26/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "FireBall.h"

@implementation FireBall

- (id)initWithPosition:(CGPoint)bodyPosition zPosition:(float)zPos
{
    if (self = [super init]) {
        self.zPosition = zPos-1;
        
        self.position = bodyPosition;
//        self.bulletRect = CGRectMake(self.position.x, self.position.y, 114, 94);
        self.damage = 130;
        self.name = @"chickenBullet";
        self.bullet = 6;
        self.boxRect = CGRectMake(-10, -10, 20, 20);
        self.attackRect = CGRectMake(self.position.x-57, self.position.y, 114, 94);
        self.waveEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"FireBallParticle" ofType:@"sks"]];
        self.waveEmitter.position = CGPointMake(50,0);
        self.waveEmitter.zPosition += 1;
        
        self.waveEmitter.name = @"jetEmitter";
        [self addChild:self.waveEmitter];
        self.waveEmitter.hidden = NO;
        
        [self setAccelerating:YES];
        [self animationMove];
    }
    return self;
    
}

- (void)animationMove
{
    self.waveEmitter.particleBirthRate = 0;
    SKAction *wait1 = [SKAction waitForDuration:0.3];
    SKAction *particleAdd = [SKAction runBlock:^{
        self.waveEmitter.particleBirthRate += 150;
    }];
    SKAction *particleAdd_seq = [SKAction repeatAction:[SKAction sequence:@[wait1,particleAdd]] count:6];
    
    SKAction *animaBulletMove = [SKAction moveByX:0 y:-356 duration:1.0];
    SKAction *repMove = [SKAction repeatActionForever:animaBulletMove];
    SKAction *seq = [SKAction sequence:@[particleAdd_seq,repMove]];
    [self runAction:seq withKey:@"move"];
    SKAction *emitter = [SKAction runBlock:^{
   //     self.mp3eEmitter.emissionAngle = 175.0;
    }];
    SKAction *waveEmitterMove = [SKAction moveByX:-57 y:0 duration:0.5];
    SKAction *wait = [SKAction waitForDuration:2];
    SKAction *seqWaveEmitter = [SKAction sequence:@[wait,emitter,waveEmitterMove]];
    [[self childNodeWithName:@"jetEmitter"] runAction:seqWaveEmitter withKey:@"waveEmitterMove"];
    
}

-(void)attackBody:(Body *)body
{
    if (CGRectIntersectsRect(self.attackRect, body.boxRect)) {
        if (body.idNumber != self.targetIDNumber) {
            self.targetIDNumber = body.idNumber;
            [body changeHP:self.damage attacker:nil];
        }
    }
}

- (void) setAccelerating:(BOOL)accelerating
{
    if (accelerating) {
        if (self.waveEmitter.hidden) {
            self.waveEmitter.hidden = NO;
        }
    } else {
        self.waveEmitter.hidden = YES;
    }
    _accelerating = accelerating;
}

@end
