//
//  WoodenBasinChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "WoodenBasinChicken.h"

@implementation WoodenBasinChicken

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_woodenBasin_move")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"woodenBasin";
    self.texString_attack = @"chicken_woodenBasin_attack";
    self.texString_move = @"chicken_woodenBasin_move";
    self.texString_rest = @"chicken_woodenBasin_move";
    self.texString_drop = @"chicken_woodenBasin_dropDown";
    
    [self sitDefaultHP:self.defaultHP*2.3];
    
    StaticActions *sa = [StaticActions single];
    self.soundAction_attackA = sa.sound_basinChickenAttack0;
    self.soundAction_attackB = sa.sound_basinChickenAttack1;
    self.soundAction_weaponDown = [SKAction playSoundFileNamed:@"Sound/chicken_downWeapon_woodenBasin.mp3" waitForCompletion:YES];
    self.soundAction_changeHPA = sa.sound_woodenBasinChangeHP0;
    self.soundAction_changeHPB = sa.sound_woodenBasinChangeHP1;
    self.haveNormalChicken_time = 1;
    
}

-(void)useAttack
{
    if (self.isSkillCDing == NO) {
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
        SKAction *seq1 = [SKAction sequence:@[wait, soundChop, runBlock]];
        SKAction *group = [SKAction group:@[seq1, animate]];
        SKAction *complet = [SKAction runBlock:^{
            [self useMove];
        }];
        self.attackAction = [SKAction sequence:@[group, complet]];
        
    }
    [self runAction:self.attackAction withKey:s_attack];
}

@end
