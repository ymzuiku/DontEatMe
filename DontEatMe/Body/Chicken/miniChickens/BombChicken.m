//
//  BombChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "BombChicken.h"

@implementation BombChicken

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_bomb_move")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"bomb";
    self.texString_attack = @"chicken_bomb_attack2";
    self.texString_attack_B = @"chicken_bomb_attack";
    self.texString_move = @"chicken_bomb_move";
    self.texString_rest = @"chicken_bomb_move";
    self.soundAction_skillA = [SKAction playSoundFileNamed:@"Sound/aoeBoom_attack_0.mp3" waitForCompletion:YES];
    [self sitDefaultHP:self.defaultHP*6.0];
    self.speedMove *= 2;
}

-(void)useDie
{
    if (![self changCanStatusRun:s_die]) {
        return;
    }
    self.canNotChangeStatus = @[s_move, s_rest, s_attack, s_die, s_dizzy, s_ice, s_slow,
                                s_sleep, s_skill, s_poison, s_snail];
    self.haveBuffSkill = YES;
    self.haveBoom_time = 1;
    self.haveBoom_hurt = 3500;
    
    Body *empty = self.attackBody;
    [empty changeHP:10 attacker:self];
    [empty beSkillWithAttacker:self];
    [super useDieBase];
}

-(void)useAttack
{
    [self useDie];
}


//-(void)useAttack
//{
//    if (self.isSkillCDing == NO) {
//        [self useSkill];
//        return;
//    }
//    if (![self changCanStatusRun:s_attack]) {
//        return;
//    }
//    self.canNotChangeStatus = @[s_attack, s_skill];
//    if (!self.attackAction) {
//        NSArray *atlasArray = Atlas(self.texString_attack);
//        int atlasCount = (int)atlasArray.count;
//        SKAction *animate = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey*1.2/self.speedAttack resize:YES restore:NO];
//        SKAction *wait = [SKAction waitForDuration:oneKey*(atlasCount-4)/self.speedAttack+1.5];
//        SKAction *runBlock = [SKAction runBlock:^{
//            [self.attackBody changeHP:self.attack attacker:self];
//        }];
//        SKAction *soundChop;
//        if (skRand(0, 2) == 0) {
//            soundChop =  self.soundAction_attackA;
//        }
//        else {
//            soundChop = self.soundAction_attackB;
//        }
//        SKAction *seq1 = [SKAction sequence:@[wait, runBlock, soundChop]];
//        SKAction *group = [SKAction group:@[seq1, animate]];
//        SKAction *complet = [SKAction runBlock:^{
//            [self useMove];
//        }];
//        self.attackAction = [SKAction sequence:@[group, complet]];
//        
//        //        self.attackAction = [SKAction repeatActionForever:group];
//    }
//    [self runAction:self.attackAction withKey:s_attack];
//}



@end
