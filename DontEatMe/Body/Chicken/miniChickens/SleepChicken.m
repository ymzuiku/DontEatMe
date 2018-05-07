//
//  SleepChicken.m
//  DontEatMe
//
//  Created by ym on 15-5-22.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "SleepChicken.h"

@implementation SleepChicken
{
    BOOL isSleeping;
    BOOL isGetUping;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_sleep_move")[0]]) {
        
    }
    return self;
}


-(void)createInit
{
    [super createInit];
    self.myName = @"sleep";
    self.texString_attack = @"chicken_sleep_attack";
    self.texString_skill = @"chicken_sleep_sleepIn";
    self.texstring_skill_B = @"chicken_sleep_sleepRest";
    self.texString_move = @"chicken_sleep_move";
    self.texString_rest = @"chicken_sleeprest";
    [self sitDefaultHP:self.defaultHP*3];
    self.attack = self.attack*1.2;
}

-(void)startup
{
    [self addHpBar:CGPointMake(hpPosX, hpPosY) name:self.texString_hpBar];
    self.hpBar.hidden = YES;
    self.hidden = NO;
    [self firstMove];
    self.isStartup = 1;
}

-(void)firstMove
{
    self.speedMove = 2;
    self.paceRate = 1.5;
    [self useMove];
    SKAction *wait = [SKAction waitForDuration:5];
    [self runAction:wait completion:^{
        [self sleep];
    }];
}

-(void)sleep
{
    if (isSleeping) {
        return;
    }
    isSleeping = YES;
    [self removeActionForKey:self.nowStatus];
    SKAction *animeIn = [SK_Actions actionAnime:Atlas(self.texString_skill) repeat:1];
    SKAction *animeRest = [SK_Actions actionAnime:Atlas(self.texstring_skill_B) repeat:35]; //睡眠时间=35*0.8秒
    SKAction *comple = [SKAction runBlock:^{
        [self getUp];
    }];
    SKAction *seq = [SKAction sequence:@[animeIn, animeRest, comple]];
    [self beBuff_sleep:30];
    [self runAction:seq withKey:@"sleep"];
}

-(void)getUp
{
    if (isGetUping) {
        return;
    }
    isGetUping = YES;
    
    self.speedMove = 1;
    [self removeActionForKey:@"sleep"];
    SKAction *anime = [SK_Actions actionAnime:Atlas(self.texString_skill) repeat:1];
    SKAction *animeOut = [anime reversedAction];
    [self runAction:animeOut completion:^{
        self.texture = Atlas(@"chicken_sleep_move")[0];
        self.canNotChangeStatus = @[];
        self.paceRate = 1;
        [self useMove];
        isSleeping = NO;
    }];
    [self.sleepBuff clearBuff];
}

-(void)useAttack
{
    if (isSleeping) {
        return;
    }
    self.speedMove = 1;
    self.paceRate = 1;
    [super useAttack];
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    [self getUp];
    return [super changeHP:hurt attacker:attacker];
}

@end
