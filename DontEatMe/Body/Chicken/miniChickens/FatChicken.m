//
//  FatChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "FatChicken.h"

@implementation FatChicken

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_fat_move")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"fat";
    self.texString_attack = @"chicken_fat_attack_0";
    self.texString_attack_B = @"chicken_fat_attack_1";
    self.texString_attack_C = @"chicken_fat_attack_2";
    self.texString_move = @"chicken_fat_move";
    self.texString_rest = @"chicken_fat_rest";
    
    [self sitDefaultHP:self.defaultHP*3];
    
    self.soundAction_skillA = [SKAction playSoundFileNamed:@"Sound/fat_attack_0.mp3" waitForCompletion:YES];
    self.soundAction_skillB = [SKAction playSoundFileNamed:@"Sound/fat_attack_3.mp3" waitForCompletion:YES];
    self.soundAction_skillC = [SKAction playSoundFileNamed:@"Sound/fat_attack_4.mp3" waitForCompletion:YES];
}

-(void)useAttack
{
    [self useSkill];
}

-(void)useSkill
{    if (![self changCanStatusRun:s_skill] || [self.dizzyLoingBuff actionForKey:@"anime"]) {
        return;
    }
    self.canNotChangeStatus = @[s_skill];
    SKAction *skill_animation_0 = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
//    SKAction *skill_group_0 = [SKAction group:@[skill_animation_0,self.soundAction_skillA]];
    
    SKAction *skill_animation_1 = [SKAction animateWithTextures:Atlas(self.texString_attack_B) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
    SKAction *skill_animation_1_rep = [SKAction repeatAction:skill_animation_1 count:9];
    SKAction *soundAction_skillB_rep = [SKAction repeatAction:self.soundAction_skillB count:5];
    SKAction *skill_group_1 = [SKAction group:@[skill_animation_1_rep,soundAction_skillB_rep]];
    
    SKAction *skill_animation_2 = [SKAction animateWithTextures:Atlas(self.texString_attack_C) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
    SKAction *skill_group_2 = [SKAction group:@[skill_animation_2,self.soundAction_skillC]];
    SKAction *skill_beginBlock = [SKAction runBlock:^{
        [self.attackBody changeHP:self.attackBody.defaultHP attacker:self];
    }];
    SKAction *skill_endBlock = [SKAction runBlock:^{
        [self useMove];
    }];
    SKAction *skill_waitForBegin = [SKAction waitForDuration:oneKey*8];
    SKAction *skill_seq = [SKAction sequence:@[skill_waitForBegin,skill_beginBlock]];
    SKAction *skill_group = [SKAction group:@[skill_animation_0,skill_seq,self.soundAction_skillA]];
    SKAction *skill_seq1 = [SKAction sequence:@[skill_group,skill_group_1,skill_group_2,skill_endBlock]];
    SKAction *skill = [SKAction group:@[skill_seq1,self.soundAction_skillA]];
    [self runAction:skill withKey:s_skill];
}

@end
