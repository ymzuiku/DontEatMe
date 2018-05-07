//
//  ViolentJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "ViolentJelly.h"
#import "Bullet.h"

@implementation ViolentJelly
{
    SKNode *games;
    int theRandom;
    int bulletNumber;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_violent_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"violent";
    self.gemTexture = Atlas(@"ui_map_bigObj")[3];
    self.texString_attack = @"jelly_violent_attack";
    self.texString_rest = @"jelly_violent_rest";
    self.attack = 15;
    [self sitDefaultHP:350];
    [self changeGem];
    
    bulletNumber = 0;
    if (self.isGemA == YES) {
        self.haveBuffSkill = YES;
        self.dropObj = @"mana.2";
        bulletNumber = 7;
    }
    if (self.isGemB == YES) {
        self.haveBuffSkill = YES;
        self.havePoison_time = 3;
        self.havePoison_attack = 30;
        bulletNumber = 6;
    }
    if (self.isGemA && self.isGemB) {
        bulletNumber = 8;
    }
}

-(void)shoot
{
    if (!games) {
        ViewController *vc = [ViewController single];
        games = vc.gameScene.war.jellysBullets;
    }
    [self createBulletWait:0.1];
    [self createBulletWait:0.2];
    [self createBulletWait:0.3];
    [self createBulletWait:0.4];
}

-(void)createBulletWait:(float)time
{
    SKAction *wait = [SKAction waitForDuration:time];
    [self runAction:wait completion:^{
        Bullet *jellyBullet = [[Bullet alloc] initWithTexture:Atlas(@"allBullet")[bulletNumber]];
        [jellyBullet animationMove];
        jellyBullet.speed = 1;
        jellyBullet.attack = self.attack;
        jellyBullet.position = CGPointMake(self.position.x, self.position.y);
        jellyBullet.zPosition = self.zPosition-0.1;
        
        if (self.haveBuffSkill) {
            theRandom = arc4random()%100-1;
            if (theRandom < 25) {
                jellyBullet.haveBuffSkill = YES;
                jellyBullet.havePoison_time = self.havePoison_time;
                jellyBullet.havePoison_attack = self.havePoison_attack;
                jellyBullet.dropObj = self.dropObj;
            }
        }
        
        [games addChild:jellyBullet];
        StaticActions *sa = [StaticActions single];
        [self runAction:sa.sound_bananaAttack];
    }];
}

@end
