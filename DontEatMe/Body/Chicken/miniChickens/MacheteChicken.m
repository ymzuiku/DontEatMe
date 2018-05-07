//
//  MacheteChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "MacheteChicken.h"

@implementation MacheteChicken
{
    int isDefenceReady;
    float defencePace;
    int isAttackingSpeedForDefence;       //test
}

-(id)init

{
    if (self = [super initWithTexture:Atlas(@"chicken_machete_move")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    
    [self sitDefaultHP:self.defaultHP*6];
    self.myName = @"machete";
    self.texString_attack = @"chicken_machete_attack";
    self.texString_move = @"chicken_machete_move";
    self.texString_rest = @"chicken_machete_rest";
    self.texString_skill = @"chicken_machete_block0";
    self.texstring_skill_B = @"chicken_machete_block1";
    self.texstring_skill_C = @"chicken_machete_block2";
    
    self.soundAction_skillA = [SKAction playSoundFileNamed:@"Sound/machete_block_0.mp3" waitForCompletion:YES];
    self.soundAction_skillB = [SKAction playSoundFileNamed:@"Sound/machete_block_1.mp3" waitForCompletion:YES];
    self.soundAction_attackA = [SKAction playSoundFileNamed:@"Sound/machete_attack_0.mp3" waitForCompletion:YES];
    self.soundAction_attackB = [SKAction playSoundFileNamed:@"Sound/machete_attack_1.mp3" waitForCompletion:YES];
    isDefenceReady = 1;
    defencePace = 0.8;
    isAttackingSpeedForDefence = 1;
    self.defaultHP = 100;   // test
    
}

//-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
//{
//    if (isDefenceReady == 1 && ![self actionForKey:s_defence]) {
//        [self useDefence];
//        return NO;
//    }else if (isDefenceReady == 0){
//        return [super changeHP:hurt attacker:attacker];
//    }
//    else {
//        return [super changeHP:hurt attacker:attacker];
//    }
//}

-(void)useAttack
{
    if (self.isSkillCDing == NO && ![self.nowStatus isEqualToString:s_attack]) {
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
        SKAction *wait = [SKAction waitForDuration:oneKey*(atlasCount*0.6)/self.speedAttack];
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
        
        //        self.attackAction = [SKAction repeatActionForever:group];
    }
    [self runAction:self.attackAction withKey:s_attack];
}


-(void)useSkill
{
    self.isSkillCDing = YES;
    [super useAttack];
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    if ([self actionForKey:s_defence]) {
        return NO;
    }else if (isDefenceReady == 1 && ![self actionForKey:s_defence]&&self.dizzyLoingBuff.isBuffing == NO && self.snailBuff.isBuffing == NO) {
        if (self.snailBuff.isBuffing == YES) {
            return [super changeHP:hurt attacker:attacker];
        }else{
            if ([self.nowStatus isEqualToString:s_attack]) {
                isAttackingSpeedForDefence = 0;
            }
            [self useDefence];
            return NO;
        }
    }else{
        return [super changeHP:hurt attacker:attacker];
    }
}

-(void)useDefence
{
    if (self.snailBuff.isBuffing == YES) {
        return;  
    }
    if ([self changCanStatusRun:s_defence]&& isDefenceReady == 0) {
        return;
    }
    self.canNotChangeStatus = @[s_defence,s_attack];
    //defence的开始阶段
    self.isSkillCDing = YES;
    SKAction *defence_animation_0 = [SKAction animateWithTextures:Atlas(self.texString_skill) timePerFrame:oneKey/20*self.speedSkill resize:YES restore:NO];
    SKAction *defence_beginBlock = [SKAction runBlock:^{
        [self defenceCD];
    }];
    SKAction *defence_group = [SKAction group:@[defence_animation_0,defence_beginBlock]];
    
    //defence的中间重复阶段
    SKAction *defence_Animation_1 = [SKAction animateWithTextures:Atlas(self.texstring_skill_B) timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
    
    SKAction *defenceMove_action = [SKAction moveByX:0 y:(float)self.pace*defencePace*self.paceRate duration:(47/2-6)*oneKey*0.6/self.speedMove];
    SKAction *defenceMove_wait = [SKAction waitForDuration:oneKey*0.5/self.speedMove*isAttackingSpeedForDefence];    //test
    SKAction *defenceMove_seq = [SKAction sequence:@[defenceMove_action, defenceMove_wait]];
    SKAction *defenceMove_Animation_seq = [SKAction sequence:@[defence_Animation_1,defenceMove_wait]];
    SKAction *defenceMove_Group = [SKAction group:@[defenceMove_Animation_seq,defenceMove_seq]];
    
    SKAction *repDefenceMove_Group = [SKAction repeatAction:defenceMove_Group count:6];
    
    //defence的结束阶段
    SKAction *defence_animation_2 = [SKAction animateWithTextures:Atlas(self.texstring_skill_C) timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
    SKAction *defence_endBlock = [SKAction runBlock:^{
        isDefenceReady = 0;
        isAttackingSpeedForDefence = 1;                 //test
        [self useMove];
    }];
    SKAction *defence_seq = [SKAction sequence:@[defence_animation_2,defence_endBlock]];
    //defence整合
    SKAction *defence = [SKAction sequence:@[defence_group,repDefenceMove_Group,defence_seq]];
    [self runAction:defence withKey:s_defence];
}

-(void)defenceCD
{
    SKAction *defenceCD_wait = [SKAction waitForDuration:10];
    SKAction *defenceCD_endBlock = [SKAction runBlock:^{
        isDefenceReady = 1;
    }];
    SKAction *defenceCD = [SKAction sequence:@[defenceCD_wait,defenceCD_endBlock]];
    
    [self runAction:defenceCD withKey:@"defenceCD"];
}

@end
