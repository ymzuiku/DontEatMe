//
//  RecoveryBuff.m
//  DontEatMe
//
//  Created by ym　 on 15/2/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "RecoveryBuff.h"

@implementation RecoveryBuff
{
    Body *body;
    SKEmitterNode *startPartique;
}
-(id)initWithBody:(Body *)aBody
{
    if (self = [super initWithBody:aBody]) {
        body = aBody;
        
        startPartique = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"noDieParticle" ofType:@"sks"]];
        startPartique.zPosition = 1;
        startPartique.targetNode = self;
        startPartique.userInteractionEnabled = NO;
        startPartique.position = CGPointMake(0, -25);
        [startPartique setScale:0.05];
        [self addChild:startPartique];
        startPartique.particleLifetime = 0;
        startPartique.particleLifetimeRange = 0;
    }
    return self;
}
-(void)beginBuff
{
    [super beginBuff];
    startPartique.particleLifetime = 0.7;
    startPartique.particleLifetimeRange = 1.2;
    //持续时间
    [self removeActionForKey:@"wait"];
    SKAction *wait = [SKAction waitForDuration:self.time];
    SKAction *block = [SKAction runBlock:^{
        [self clearBuff];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq withKey:@"wait"];
    
    SKAction *interval = [SKAction waitForDuration:self.miniCDtime];
    SKAction *hpBlock = [SKAction runBlock:^{
        [body changeHP:self.hurt attacker:nil];
    }];
    SKAction *seq2 = [SKAction sequence:@[interval, hpBlock]];
    SKAction *rep = [SKAction repeatActionForever:seq2];
    [self runAction:rep withKey:@"hp"];
    
    SKAction *sound = [SKAction playSoundFileNamed:@"Sound/cure_attack_0.mp3" waitForCompletion:YES];
    [self runAction:sound];
}
-(void)clearBuff
{
    [super clearBuff];
    [self removeActionForKey:@"hp"];
    startPartique.particleLifetime = 0;
    startPartique.particleLifetimeRange = 0;
}
-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [super removeFromParent];
}


@end
