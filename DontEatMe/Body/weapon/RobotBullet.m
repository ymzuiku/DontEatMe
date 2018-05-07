//
//  RobotBullet.m
//  DontEatMe
//
//  Created by pringlesfox on 8/7/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "RobotBullet.h"

@implementation RobotBullet
{
    int blowUp;
}

- (id)initWithPosition:(CGPoint)bodyPosition zPosition:(float)zPos
{
    if (self = [super initWithImageNamed:@"chicken_robot_weapon.png"]) {
        self.zPosition = zPos-1;
        self.boxRect = CGRectMake(-10, -10, 20, 20);
        self.position = bodyPosition;
        self.bulletRect = CGRectMake(bodyPosition.x, bodyPosition.y, 114, 94);
        self.damage = 1000;
        self.name = @"chickenBullet";
        self.bullet = 5;
        
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
    SKAction *animaBulletMove = [SKAction moveByX:0 y:-300 duration:1.0];
    SKAction *repMove = [SKAction repeatActionForever:animaBulletMove];
    [self runAction:repMove withKey:@"move"];
}

- (void)animationBlowUp
{
    if (blowUp > 0) {
        return;
    }
    blowUp = 1;
    [self removeActionForKey:@"move"];
    SKAction *animaBulletBlowUp = [SKAction animateWithTextures:Atlas(@"chicken_bomb_attack")  timePerFrame:0.042 resize:YES restore:NO];
    [self runAction:animaBulletBlowUp completion:^{
        [self removeFromParent];
    }];
    
}

-(void)attackBody:(Body *)body
{
    if (blowUp > 0) {
        return;
    }
    if (CGRectIntersectsRect(self.boxRect, body.boxRect)) {
        [body changeHP:self.damage attacker:self];
        [self animationBlowUp];
    }
}


@end
