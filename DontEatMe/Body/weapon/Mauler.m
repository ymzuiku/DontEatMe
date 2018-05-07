//
//  Mauler.m
//  AtlasTesing
//
//  Created by Tie Muer on 12/31/13.
//  Copyright (c) 2013 ym. All rights reserved.
//

#import "Mauler.h"

static SKAction *moveA;

@implementation Mauler
- (id)initWithPosition:(CGPoint)jellyPosition zPosition:(float)zPos
{
    if (self = [super initWithColor:rgb(0x000000, 0) size:CGSizeMake(114, 96)]) {
        self.position = jellyPosition;
        self.boxRect = CGRectMake(-10, -10, 20, 20);
        self.attackRect = CGRectMake(self.position.x, self.position.y, 114+57, 94);
        self.damage = 10;
        self.name = @"jellyBullet";
        self.bullet = 3;
        [self animationMove];
    }
    return self;
    
}

- (int)attack:(CGRect)pirateCollinRect
{
    return self.damage;
}

- (void)animationMove
{
    if (moveA == nil) {
        moveA = [SKAction moveToY:self.position.y+96 duration:0.3];
    }
    [self runAction:moveA withKey:@"move"];
}

- (void)animationBlowUp
{
    SKAction *animaBulletBlowUp = [SKAction waitForDuration:0.1];
    [self runAction:animaBulletBlowUp completion:^{
        [self removeFromParent];
    }];
}

-(void)dealloc
{
    moveA = nil;
}

@end
