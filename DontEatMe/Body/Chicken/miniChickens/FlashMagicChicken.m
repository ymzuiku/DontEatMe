//
//  FlashMagicChicken.m
//  DontEatMe
//
//  Created by ym on 15/5/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "FlashMagicChicken.h"

@implementation FlashMagicChicken
{
    SKNode *jellys;
    float loadSkillNumbel;
    int skillLoadingTime;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_flashMagic_move")[0]]) {
        
    }
    return self;
}


-(void)createInit
{
    [super createInit];
    self.myName = @"flashMagic";
    self.texString_attack = @"chicken_flashMagic_attack";
    self.texString_skill = @"chicken_flashMagic_skill";
    self.texString_move = @"chicken_flashMagic_move";
    self.texString_rest = @"chicken_flashMagic_rest";
    
    jellys = [ViewController single].gameScene.war.jellys;
    [self sitDefaultHP:self.defaultHP*5];
    self.skillCD = 10; //魔法冷却时间
    skillLoadingTime = 3; //魔法施法时间
}


-(void)startup
{
    [super startup];
    [self addSkillBar:CGPointMake(hpPosX, hpPosY+20) name:@"chicken_skillBar_mini" skillTime:skillLoadingTime];
    self.skillBar.hidden = YES;
    [self reloadStartSkill];
}

-(void)reloadStartSkill
{
    SKAction *wait = [SKAction waitForDuration:self.skillCD+skillLoadingTime];
    SKAction *block = [SKAction runBlock:^{
        [self removeActionForKey:self.nowStatus];
        [self useMove];
        [self useSkill];
    }];
    SKAction *waitFirst = [SKAction waitForDuration:self.skillCD];
    SKAction *seqFirst = [SKAction sequence:@[waitFirst, block]];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    SKAction *endSeq = [SKAction sequence:@[seqFirst, rep]];
    [self runAction:[SKAction repeatActionForever:endSeq] withKey:s_loadingSkill];
}

-(void)useSkill
{
    if ([self changCanStatusRun:s_skill] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_skill, s_attack];
    [super useSkill];
    
    CGRect magicRect = CGRectMake(50, ih-820, 550, 820); //魔法碰撞面积
    
    loadSkillNumbel = 0;
    self.skillBar.hidden = NO;
    SKAction *wait = [SKAction waitForDuration:0.1];
    SKAction *block = [SKAction runBlock:^{
        loadSkillNumbel += 0.1;
        [self.skillBar changeBar:loadSkillNumbel];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    SKAction *repLoading = [SKAction repeatAction:seq count:skillLoadingTime/0.1];
    SKAction *endBlock = [SKAction runBlock:^{
        for (Jelly *jelly in jellys.children) {
            if (CGRectIntersectsRect(magicRect, jelly.boxRect)) {
//                [jelly changeHP:1000 attacker:self];  //魔法伤害
                [jelly beBuff_Flash:1 hurt:jelly.defaultHP/4];   //魔法伤害
            }
        }
        
        SKAction *sound = [SKAction playSoundFileNamed:@"Sound/boom_attack_0.mp3" waitForCompletion:YES];
        [self runAction:sound];
        [self runAction:sound];
        [self runAction:sound];
        [self runAction:sound]; //多重声音模拟雷声
        [self useMove];
        self.skillBar.hidden = YES;
    }];
    
    SKAction *seqEnd = [SKAction sequence:@[repLoading, endBlock]];
    
    SKAction *anime = [SK_Actions actionAnime:Atlas(self.texString_skill) repeat:0];
    SKAction *group = [SKAction group:@[seqEnd, anime]];
    [self runAction:group withKey:s_skill];
    
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    if ([attacker.myName isEqualToString:@"laserBullet"]) {
        return NO;
    }else{
        return [super changeHP:hurt attacker:attacker];
    }
}

-(void)useAttack
{
    [super useAttack];
    self.skillBar.hidden = YES;
}

-(void)useMove
{
    [super useMove];
    self.skillBar.hidden = YES;
}

-(void)useRest
{
    [super useRest];
    self.skillBar.hidden = YES;
}



@end
