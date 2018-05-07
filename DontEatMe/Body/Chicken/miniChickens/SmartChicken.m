//
//  SmartChicken.m
//  DontEatMe
//
//  Created by ym on 15/5/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "SmartChicken.h"

@implementation SmartChicken
{
    SKNode *jellys;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_smart_move")[0]]) {
        
    }
    return self;
}


-(void)createInit
{
    [super createInit];
    self.myName = @"smart";
    self.texString_attack = @"chicken_smart_attack";
    self.texString_move = @"chicken_smart_move";
    self.texString_rest = @"chicken_smart_rest";
    self.defAttackRect = CGRectMake(-260/2, -70, 260, 40);
    jellys = [ViewController single].gameScene.war.jellys;
    [self sitDefaultHP:self.defaultHP*8];
    self.attack = self.attack*3;
}

-(void)startup
{
    [super startup];
    self.hpBar.position = CGPointMake(hpPosX, hpPosY+55);
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
        SKAction *wait = [SKAction waitForDuration:oneKey*(atlasCount-4)/self.speedAttack];
        SKAction *runBlock = [SKAction runBlock:^{
            //[self.attackBody changeHP:self.attack attacker:self];
            for (Jelly *jelly in jellys.children) {
                if (CGRectIntersectsRect(self.attackRect, jelly.boxRect)) {
                    [jelly changeHP:self.attack attacker:self];
                }
            }
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

@end
