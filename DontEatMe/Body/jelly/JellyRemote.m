//
//  JellyRemote.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "JellyRemote.h"

@implementation JellyRemote

-(void)createInit
{
    [super createInit];
    self.attack = 14;
    
}

-(void)startup
{
    self.defAttackRect = CGRectMake(-20, 0, 40, ih-self.position.y-20);
    [super startup];
}

-(void)useAttack
{
    if ([self changCanStatusRun:s_attack] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_attack];
    
    if (!self.attackAction) {
        SKAction *completion = [SKAction runBlock:^{
            self.canNotChangeStatus = @[];
            [self useRest];
        }];
        SKAction *restAnimate = [SKAction animateWithTextures:Atlas(self.texString_rest) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
        SKAction *animateRest = [SKAction repeatAction:restAnimate count:1];
        
        SKAction *attackAnima = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
        SKAction *shoot = [SKAction runBlock:^{
            [self shoot];
        }];
        SKAction *waitShoot = [SKAction waitForDuration:0.2/self.speedAttack];
        SKAction *seqShoot = [SKAction sequence:@[waitShoot, shoot]];
        SKAction *shootBullet = [SKAction sequence:@[attackAnima, animateRest, completion]];
        
        self.attackAction = [SKAction group:@[shootBullet,seqShoot]];
    }
    float tempTime = skRand(0, 5)/10;
    SKAction *randomWait = [SKAction waitForDuration:tempTime];
    SKAction *seq = [SKAction sequence:@[randomWait, self.attackAction]];
    [self runAction:seq withKey:s_attack];
}

-(void)shoot{}

@end
