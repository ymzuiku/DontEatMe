//
//  ShadowChicken.m
//  DontEatMe
//
//  Created by ym on 15/5/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "ShadowChicken.h"

@implementation ShadowChicken

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_shadow_move")[0]]) {
        
    }
    return self;
}


-(void)createInit
{
    [super createInit];
    self.myName = @"shadow";
    self.texString_attack = @"chicken_shadow_attack";
    self.texString_skill = @"chicken_shadow_hidden";
    self.texString_move = @"chicken_shadow_move";
    self.texString_rest = @"chicken_shadow_rest";
    self.attack = self.attack*1.5;
    [self sitDefaultHP:self.defaultHP*4];
}

-(void)useAttack
{
    if ([self.attackBody.myName isEqualToString:@"iceThin"] ||
        [self.attackBody.myName isEqualToString:@"iceThick"] ||
        [self.attackBody.myName isEqualToString:@"iceThorn"] ||
        [self.attackBody.myName isEqualToString:@"iceMist"]) {
        [self useSkill];
        return;
    }
    if (![self changCanStatusRun:s_attack]) {
        return;
    }
    self.canNotChangeStatus = @[s_attack, s_skill];
    if (!self.attackAction) {
        NSArray *atlasArray = Atlas(self.texString_attack);
        int atlasCount = (int)atlasArray.count;
        SKAction *animate = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey*1.2/self.speedAttack resize:YES restore:NO];
        SKAction *wait = [SKAction waitForDuration:oneKey*(atlasCount-4)/self.speedAttack];
        SKAction *runBlock = [SKAction runBlock:^{
            [self.attackBody changeHP:self.attack attacker:self];
        }];
        SKAction *soundChop;
        if (skRand(0, 2) == 0) {
            soundChop =  self.soundAction_attackA;
        }
        else {
            soundChop = self.soundAction_attackB;
        }
        SKAction *seq1 = [SKAction sequence:@[wait, runBlock, soundChop]];
        SKAction *group = [SKAction group:@[seq1, animate]];
        SKAction *complet = [SKAction runBlock:^{
            [self useMove];
        }];
        self.attackAction = [SKAction sequence:@[group, complet]];
    }
    [self runAction:self.attackAction withKey:s_attack];
}

-(void)useSkill
{
    if (![self changCanStatusRun:s_skill]) {
        return;
    }
    self.canNotChangeStatus = @[s_skill];
    
    self.isCanNotCoill = YES;
    if (!self.moveAction) {
        SKAction *anime = [SKAction animateWithTextures:Atlas(self.texString_move) timePerFrame:oneKey*0.6/self.speedMove resize:YES restore:NO];
        SKAction *move = [SKAction moveByX:0 y:(float)self.pace*self.paceRate duration:(47/2-6)*oneKey*0.6/self.speedMove];
        SKAction *wait = [SKAction waitForDuration:oneKey*0.6*12/self.speedMove];
        SKAction *seq = [SKAction sequence:@[move, wait, move]];  //必须让anima的总时间和sequence的总时间相等
        SKAction *group = [SKAction group:@[anime, seq]];
        SKAction *miniWait = [SKAction waitForDuration:0.2];
        SKAction *reptGroup = [SKAction repeatActionForever:group];
        self.moveAction = [SKAction sequence:@[miniWait, reptGroup]];
    }
    SKAction *hidd = [SK_Actions actionAnime:Atlas(self.texString_skill) repeat:1];
    SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.8];
    SKAction *groupHidden = [SKAction group:@[hidd, color]];
    SKAction *shadowMove = [SKAction sequence:@[groupHidden, self.moveAction]];
    [self runAction:shadowMove withKey:@"shadowMove"];
    
    
    SKAction *show = [SK_Actions actionAnime:Atlas(self.texString_skill) repeat:-1];
    SKAction *color2 = [SKAction colorizeWithColor:rgb(0x000000, 1) colorBlendFactor:0 duration:0.8];
    SKAction *groupShow = [SKAction group:@[show, color2]];
    
    SKAction *wait = [SKAction waitForDuration:6.4];
    SKAction *block = [SKAction runBlock:^{
        [self removeActionForKey:@"shadowMove"];
        [self runAction:groupShow completion:^{
            self.isCanNotCoill = NO;
            [self useMove];
        }];
    }];
    SKAction *backSeq = [SKAction sequence:@[wait, block]];
    [self runAction:backSeq withKey:s_skill];
}

@end
