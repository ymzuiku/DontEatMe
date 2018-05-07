//
//  BounceBullet.m
//  DontEatMe
//
//  Created by pringlesfox on 8/19/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "BounceBullet.h"

static SKAction *bulletMove;
static SKAction *bulletBlowUp;

@implementation BounceBullet

- (id)initWithPosition:(CGPoint)jellyPosition zPosition:(float)zPos
{
    if (self = [super initWithTexture:AtlasNum(@"jelly_violent_bullet", 0)]) {
        self.zPosition = zPos-1;
        
        self.position = CGPointMake(jellyPosition.x, jellyPosition.y-50);
        self.zPosition = (1999-self.position.y);
        self.bulletRect = CGRectMake(self.position.x, self.position.y, 114, 94);
        self.damage = 10;
        self.name = @"chickenBullet";
        self.bullet = 4;
        
        self.dizze = 0;
        self.slow = 0;
        self.isThrough = 0;
        self.isPoison = 0;
        
        [self setScale:0.6];
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
    if (bulletMove == nil) {
        SKAction *animaBulletMove = [SKAction moveByX:0 y:-1136 duration:2.5];
        bulletMove = [SKAction sequence:@[animaBulletMove]];
    }
    
    [self runAction:bulletMove withKey:@"move"];
}

- (void)animationBlowUp
{
    if (bulletBlowUp == nil) {
        bulletBlowUp = [SKAction animateWithTextures:Atlas(@"jelly_violent_bullet")  timePerFrame:0.042];
    }
    [self runAction:bulletBlowUp completion:^{
        [self removeAllChildren];
        [self removeFromParent];
    }];
    
}

-(void)dealloc
{
    bulletMove = nil;
    bulletBlowUp = nil;
}

@end
