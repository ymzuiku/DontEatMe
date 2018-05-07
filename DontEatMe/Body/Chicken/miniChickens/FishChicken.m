//
//  FishChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "FishChicken.h"

@implementation FishChicken

-(id)init

{
    if (self = [super initWithTexture:Atlas(@"chicken_fish_move")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"fish";
    self.texString_attack = @"chicken_fish_attack";
    self.texString_move = @"chicken_fish_move";
    self.texString_rest = @"chicken_fish_rest";
    self.texString_drop = @"chicken_fish_dropDown";
    
    self.soundAction_skillA = [SKAction playSoundFileNamed:@"Sound/fish_magic_0.mp3" waitForCompletion:YES];
    
    self.haveNormalChicken_time = 1;
    self.isSkillCDing = NO;
    
    [self sitDefaultHP:self.defaultHP*1.5];
}

-(void)useSkill
{
    if (self.haveNormalChicken_time == 0) {
        self.isSkillCDing = YES;
        return;
    }
    if ([self changCanStatusRun:s_skill] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_skill, s_attack];
    self.haveNormalChicken_time = 0;
    self.isSkillCDing = YES;
    
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"chicken_fish_attackB") timePerFrame:oneKey/self.speedSkill resize:YES restore:NO];
    SKAction *skill = [SKAction runBlock:^{
//        [self.attackBody beBuff_Floor:20 hurt:15];
        [self.attackBody beBuff_Floor:20 hurt:200];
        self.texString_attack = self.texString_normalAttack;
        self.texString_move = self.texString_normalMove;
        self.texString_rest = self.texString_normalRest;
        self.moveAction = nil;
        self.attackAction = nil;
        self.restAction = nil;
    }];
    SKAction *group = [SKAction group:@[anime, skill]];
    SKAction *complet = [SKAction runBlock:^{
        [self useMove];
    }];
    SKAction *seq = [SKAction sequence:@[group, complet]];
    [self runAction:seq];
}

@end
