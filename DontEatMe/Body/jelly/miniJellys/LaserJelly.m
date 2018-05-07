//
//  LaserJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "LaserJelly.h"
#import "Bullet.h"

@implementation LaserJelly
{
    SKNode *games;
    SKSpriteNode *laser;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_laser_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"laser";
    self.gemTexture = Atlas(@"ui_map_bigObj")[3];
    self.texString_attack = @"jelly_laser_attackLeft";
    self.texString_rest = @"jelly_laser_rest";
    [self changeGem];
    
    ViewController *vc = [ViewController single];
    games = vc.gameScene.war.jellysBullets;
    laser = [SKSpriteNode spriteNodeWithTexture:Atlas(@"jelly_laser_bulletLeft")[0]];
    laser.position = CGPointMake(self.position.x, self.position.y+96*2-20.);
    laser.zPosition = -1;
    [self addChild:laser];
    
    self.defAttackRect = CGRectMake(-171, 97*3+13, 114*3, 97);
    self.attack = 40;
    if (self.isGemA == YES) {
        self.haveBuffSkill = YES;
        self.haveSlow_time = 2;
        self.haveSlow_moveSpeed = 0.4;
        self.haveSlow_attackSpeed = 0.4;
    }
    if (self.isGemB == YES) {
        self.attack *= 1.3;
    }
}

-(void)useAttack
{
    if ([self changCanStatusRun:s_attack] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_attack];
    
    SKAction *animateRe = [SKAction animateWithTextures:Atlas(@"jelly_laser_rest") timePerFrame:oneKey resize:YES restore:NO];
    SKAction *animateRest = [SKAction repeatAction:animateRe count:2];
    SKAction *animateLeft = [SKAction animateWithTextures:Atlas(@"jelly_laser_attackLeft") timePerFrame:oneKey resize:YES restore:NO];
    SKAction *animateRight = [SKAction animateWithTextures:Atlas(@"jelly_laser_attackRight" ) timePerFrame:oneKey resize:YES restore:NO];
    SKAction *laserLeft = [SKAction animateWithTextures:Atlas(@"jelly_laser_bulletLeft") timePerFrame:oneKey resize:YES restore:NO];
    SKAction *laserRight = [laserLeft reversedAction];
    
    //firstAttack
    SKAction *firstAttack = [SKAction runBlock:^{
        [self runAction:animateLeft];
        [laser runAction:laserLeft];
        [self shootIsLeft:YES];
    }];
    
    SKAction *secendAttack = [SKAction runBlock:^{
        [self runAction:animateRight];
        [laser runAction:laserRight];
        [self shootIsLeft:NO];
    }];
    SKAction *sitChangStatusBlock = [SKAction runBlock:^{
        self.canNotChangeStatus = @[];
        [self useRest];
    }];
    SKAction *wait = [SKAction waitForDuration:animateLeft.duration];
    SKAction *seq = [SKAction sequence:@[firstAttack, wait, secendAttack, wait, animateRest,sitChangStatusBlock]];
    [self runAction:seq withKey:s_attack];
}

-(void)shootIsLeft:(BOOL)isLeft
{
    if (isLeft) {
        Bullet *bullet = [[Bullet alloc] init];
        bullet.myName = @"laserBullet";
        bullet.boxRect = CGRectMake(-10, -60, 20, 120);
        bullet.attack = self.attack;
        bullet.hidden = YES;
        bullet.isThrough = YES;
        [games addChild:bullet];
        bullet.position = CGPointMake(self.position.x-96*1.5, self.position.y+92*4-20);
        SKAction *move = [SKAction moveByX:96*3 y:0 duration:24*oneKey];
        [bullet runAction:move completion:^{
            [bullet removeFromParent];
        }];
    }
    else {
        Bullet *bullet = [[Bullet alloc] init];
        bullet.myName = @"laserBullet";
        bullet.boxRect = CGRectMake(-10, -50, 20, 100);
        bullet.attack = self.attack;
        bullet.hidden = YES;
        bullet.isThrough = YES;
        [games addChild:bullet];
        bullet.position = CGPointMake(self.position.x+96*1.5, self.position.y+92*4-20);
        SKAction *move = [SKAction moveByX:-96*3 y:0 duration:25*oneKey];
        [bullet runAction:move completion:^{
            [bullet removeFromParent];
        }];
    }
}

@end
