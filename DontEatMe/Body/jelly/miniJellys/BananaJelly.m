//
//  BananaJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "BananaJelly.h"
#import "Bullet.h"

@implementation BananaJelly
{
    SKNode *games;
    int bulletNumber;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_banana_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"banana";
    self.gemTexture = Atlas(@"ui_map_bigObj")[3];
    self.texString_attack = @"jelly_banana_attack";
    self.texString_rest = @"jelly_banana_rest";
    [self sitDefaultHP:500];
    self.attack = 20;
    [self changeGem];
    
    bulletNumber = 0;
    if (self.isGemA == YES) {
        self.haveBuffSkill = YES;
        self.haveDizzy_time = 1*iSpeed;
        self.haveDizzy_random = 20;
        bulletNumber = 1;
    }
    if (self.isGemB == YES) {
        self.haveBuffSkill = YES;
        self.haveSlow_time = 3*iSpeed;
        self.haveSlow_moveSpeed = 0.85;
        bulletNumber = 2;
    }
    if (self.isGemA && self.isGemB) {
        bulletNumber = 3;
    }
    
    ViewController *vc = [ViewController single];
    games = vc.gameScene.war.jellysBullets;
}

-(void)shoot
{
    Bullet *jellyBullet = [[Bullet alloc] initWithTexture:Atlas(@"allBullet")[bulletNumber]];
    [jellyBullet animationMove];
    jellyBullet.attack = self.attack ;
    jellyBullet.position = CGPointMake(self.position.x, self.position.y);
    jellyBullet.zPosition = self.zPosition-0.1;
    
    if (self.haveBuffSkill) {
        jellyBullet.haveBuffSkill = YES;
        jellyBullet.haveDizzy_time = self.haveDizzy_time;
        jellyBullet.haveDizzy_random = self.haveDizzy_random;
        jellyBullet.haveSlow_time = self.haveSlow_time;
        jellyBullet.haveSlow_moveSpeed = self.haveSlow_moveSpeed;
        jellyBullet.haveSlow_attackSpeed = self.haveSlow_attackSpeed;
    }
    
    [games addChild:jellyBullet];
    StaticActions *sa = [StaticActions single];
    [self runAction:sa.sound_bananaAttack];
    
    jellyBullet.haveBuffSkill = YES;
//    jellyBullet.haveDizzy_time = 2;
//    jellyBullet.haveDizzy_random = 50;
//    jellyBullet.haveBinding_time = 6;
//    jellyBullet.haveBinding_attack = 5;
//    jellyBullet.haveIce_time = 3;
//    jellyBullet.haveIce_attackSpeed = 0.5;
//    jellyBullet.havePoison_time = 5;
//    jellyBullet.havePoison_attack = 10;
//    jellyBullet.haveSleep_time = 5;
//    jellyBullet.haveSlow_time = 3;
//    jellyBullet.haveSlow_moveSpeed = 0.5;
//    jellyBullet.haveSlow_attackSpeed = 0.5;
//    jellyBullet.haveSnail_time = 10;
//    jellyBullet.haveSnail_changeHPRate = 5;
//    jellyBullet.haveShield_time = 5;
//    jellyBullet.haveShield_hp = 6;
//    jellyBullet.haveCure_time = 5;
//    jellyBullet.haveCure_rate = 0.6;
//    jellyBullet.haveAmok_time = 5;
//    jellyBullet.haveAmok_speed = 1.4;
//    jellyBullet.haveNormalChicken_time = 999;
//    jellyBullet.haveBoom_time = 999;
//    jellyBullet.haveBoom_hurt = 500;
//    jellyBullet.haveStave_time = 2;
//    jellyBullet.haveStave_hurt = 9999;
//    jellyBullet.haveYoda_time = 1;
//    jellyBullet.haveYoda_hurt = 5;
}
@end
