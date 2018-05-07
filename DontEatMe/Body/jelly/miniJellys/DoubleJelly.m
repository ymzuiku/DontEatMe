//
//  DoubleJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "DoubleJelly.h"
#import "Bullet.h"

@implementation DoubleJelly
{
    SKNode *games;
    int isThrough;
    int bulletNumber;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_double_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"double";
    self.gemTexture = Atlas(@"ui_map_bigObj")[3];
    self.texString_attack = @"jelly_double_attack";
    self.texString_rest = @"jelly_double_rest";
    [self changeGem];
    [self sitDefaultHP:300];    
    self.attack = 16;
    
    bulletNumber = 0;
    if (self.isGemA == YES) {
        self.defSpeedAttack = 1.4;
        self.defSpeedRest = 1.4;
        bulletNumber = 5;
    }
    if (self.isGemB == YES) {
        isThrough = 1;
        bulletNumber = 4;
    }
    if (self.isGemA && self.isGemB) {
        bulletNumber = 4;
    }
}

-(void)startup
{
    [super startup];
    self.defAttackRect = CGRectMake(-150, 0, 300, ih-self.position.y-20);
    [self reloadRect];
}

-(void)shoot
{
    if (!games) {
        ViewController *vc = [ViewController single];
        games = vc.gameScene.war.jellysBullets;
    }
    [self createBulletWitchVector:1];
    [self createBulletWitchVector:-1];
}

-(void)createBulletWitchVector:(int)vector
{
    Bullet *jellyBullet = [[Bullet alloc] initWithTexture:Atlas(@"allBullet")[bulletNumber]];
    [jellyBullet animationMove];
    jellyBullet.attack = self.attack;
    jellyBullet.position = CGPointMake(self.position.x+10*vector, self.position.y);
    jellyBullet.zPosition = self.zPosition-0.1;
    jellyBullet.isThrough = isThrough;
    
    SKAction *rotA = [SKAction rotateByAngle:M_PI*(-45*vector)/180 duration:0.05];
    SKAction *moveA = [SKAction moveByX:100*vector y:0 duration:0.2];
    SKAction *roteA = [SKAction rotateByAngle:M_PI*(45*vector)/180 duration:0.1];
    SKAction *shootRota = [SKAction sequence:@[rotA,moveA,roteA]];
    [jellyBullet runAction:shootRota];
    
    [games addChild:jellyBullet];
    StaticActions *sa = [StaticActions single];
    [self runAction:sa.sound_bananaAttack];
}

@end
