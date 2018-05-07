//
//  LaserBullet.m
//  AtlasTesing
//
//  Created by Tie Muer on 12/26/13.
//  Copyright (c) 2013 ym. All rights reserved.
//

#import "LaserBullet.h"


@implementation LaserBullet
{
    float perKey;
}
- (id)initWithPosition:(CGPoint)jellyPosition zPosition:(float)zPos
{
    if (self = [super initWithTexture:AtlasNum(@"jelly_laser_bulletLeft", 0)]) {
        self.zPosition = zPos;
        self.position = CGPointMake(jellyPosition.x, jellyPosition.y-70);
        self.anchorPoint = CGPointMake(0.5, 0);
        self.name = @"jellyBullet";
        self.bullet = 2;
        self.bulletType = 1;
        self.isThrough = 1;
        
        _bulletR = [[LaserBullet alloc] initWithColor:rgb(0xff00ff, 0) size:CGSizeMake(10, 96)];   //碰撞体正式上线要删除
    }
    return self;
}

- (void)animationMove
{
    _bulletType = 1;
    SKAction *animaBullet = [SKAction animateWithTextures:Atlas(@"jelly_laser_bulletLeft")  timePerFrame:oneKey];
    SKAction *animaBulletActionBefore = [SKAction rotateByAngle:M_PI*(5)/180 duration:0.1];
    SKAction *animaBulletActionAfter = [SKAction rotateByAngle:M_PI*(-10)/180 duration:oneKey*25];
    SKAction *animaBulletAttack = [SKAction customActionWithDuration:1.5 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        _rect = CGRectMake(self.position.x-114, self.position.y+(96*4), 1, 1);
        [self removeFromParent];
    }];
    SKAction *animaBulletAction = [SKAction sequence:@[animaBulletActionBefore,animaBulletActionAfter,animaBulletAttack]];
    SKAction *animaBulletMove = [SKAction group:@[animaBulletAction,animaBullet]];
    [self runAction:animaBulletMove withKey:@"move"];
}

- (void)animationMove1
{
    _bulletType = 2;
    SKAction *animaBullet = [SKAction animateWithTextures:Atlas(@"jelly_laser_bulletLeft")  timePerFrame:oneKey];
    SKAction *animaBulletActionBefore = [SKAction rotateByAngle:M_PI*(-5)/180 duration:0.1];
    SKAction *animaBulletActionAfter = [SKAction rotateByAngle:M_PI*(10)/180 duration:oneKey*25];
    SKAction *animaBulletAttack = [SKAction customActionWithDuration:1.5 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
         _rect = CGRectMake(self.position.x-114, self.position.y+(96*4), 1, 1);
        [self removeFromParent];
    }];
    SKAction *animaBulletAction = [SKAction sequence:@[animaBulletActionBefore,animaBulletActionAfter,animaBulletAttack]];
    SKAction *animaBulletMove = [SKAction group:@[animaBulletAction,animaBullet]];
        [self runAction:animaBulletMove withKey:@"move"];
}

@end
