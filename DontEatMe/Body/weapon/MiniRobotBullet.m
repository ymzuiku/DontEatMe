//
//  MiniRobotBullet.m
//  DontEatMe
//
//  Created by 木尔 铁 on 24/2/15.
//  Copyright (c) 2015 ym. All rights reserved.
//

#import "MiniRobotBullet.h"

@implementation MiniRobotBullet
{
    int blowUp;
}

- (id)initWithPosition:(CGPoint)bodyPosition zPosition:(float)zPos
{
    if (self = [super initWithTexture:AtlasNum(@"chicken_robot_move_down", 0) color:[UIColor whiteColor] size:CGSizeMake(50, 50)]) {
        self.zPosition = zPos-1;
        self.boxRect = CGRectMake(-10, -10, 50, 50);
        self.position = bodyPosition;
        self.bulletRect = CGRectMake(bodyPosition.x, bodyPosition.y, 114, 94);
        self.damage = 50;
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
    int aNumber = 60;
    SKAction *actionBulletMove = [SKAction moveByX:-(aNumber*2) y:-(aNumber*3) duration:1.0];
    SKAction *animaBulletMove = [SKAction animateWithTextures:Atlas(@"chicken_robot_move_down") timePerFrame:oneKey*0.5 resize:NO restore:NO];
    [self runAction:[SKAction repeatActionForever:actionBulletMove] withKey:@"move"];
    [self runAction:[SKAction repeatActionForever:animaBulletMove]];
}

- (void)animationBlowUp:(Body *)targetBody
{
    if (blowUp > 0) {
        return;
    }
    blowUp = 1;
    self.zPosition = targetBody.zPosition+1;
    SKAction *animaBulletBlowUp = [SKAction animateWithTextures:Atlas(@"chicken_bomb_attack")  timePerFrame:oneKey resize:YES restore:NO];
    [self runAction:animaBulletBlowUp completion:^{
        [self removeFromParent];
    }];
    
}

-(void)attackBody:(Body *)body
{
    if (blowUp > 0) {
        return;
    }
    
    if (CGRectIntersectsRect(self.boxRect, body.boxRect) && ![body.myName isEqualToString:@"xiaowei"]) {
        [self removeActionForKey:@"move"];
        [body changeHP:body.defaultHP/7 attacker:self];
        [self animationBlowUp:body];
    }
}


@end
