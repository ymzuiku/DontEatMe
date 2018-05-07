//
//  BoomJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "BoomJelly.h"
#import "SnailBuff.h"
#import "ShieldBuff.h"
#import "HPbar.h"

@implementation BoomJelly
{
    Body *killer;
    BOOL isBoomOne;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_boom_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"boom";
    self.gemTexture = Atlas(@"ui_map_bigObj")[4];
    self.texString_attack = @"jelly_boom_create";
    self.texString_rest = @"jelly_boom_rest";
    self.haveBuffSkill = YES;
    self.haveBoom_time = 1;
    self.haveBoom_hurt = 250;
    [self changeGem];
    
    [self setScale:1.1];
    if (self.isGemA == YES) {
        self.haveBoom_hurt *= 2;
    }
}

-(void)useDie
{
    if (self.isGemB == NO && !isBoomOne) {
        [killer beBuff_Boom:self.haveBoom_time hurt:self.haveBoom_hurt];
        killer = nil;
        isBoomOne = YES;
        [super useDie];
    }
    else if (self.isGemB == YES && !isBoomOne) {
        [killer beBuff_Boom:self.haveBoom_time hurt:self.haveBoom_hurt];
        killer = nil;
        isBoomOne = YES;
        self.hpBar.hidden = YES;
        [self setScale:0.85];
        
        SKAction *mini = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey*2 resize:YES restore:NO];
        [self runAction:mini completion:^{
            self.isGemB = 0;
			self.haveBoom_hurt /= 2;
            isBoomOne = NO;
            [self changeHP:-self.defaultHP attacker:nil];
        }];
    }
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker;
{
    killer = attacker;
    return [super changeHP:hurt attacker:attacker];
}

@end
