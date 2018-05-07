//
//  MaidChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "MaidChicken.h"

@implementation MaidChicken
{
    BOOL firstCreate;
    SKNode *jellys;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_maid_jump")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"maid";
    firstCreate = YES;
    self.texString_skill = @"chicken_maid_music";
    self.texString_move = @"chicken_maid_move";
    self.texString_move_B = @"chicken_maid_jump";
    self.texString_rest = @"chicken_maid_rest";
    self.texString_rest_B = @"chicken_maid_lovely";
    
    StaticActions *sa = [StaticActions single];
    self.soundAction_skillA = sa.sound_ironBasinChangeHP1;
    self.soundAction_restA = [SKAction playSoundFileNamed:@"Sound/maid_rest_0.mp3" waitForCompletion:YES];
    self.soundAction_restB = [SKAction playSoundFileNamed:@"Sound/maid_rest_0.mp3" waitForCompletion:YES];
    self.soundAction_changeHPA = sa.sound_normalChangeHP1;
    self.soundAction_changeHPB = sa.sound_normalChangeHP2;
    
    jellys = [ViewController single].gameScene.war.jellys;
    self.defAttackRect = CGRectMake(-570/2, 0, 570, -600);
}

-(void)startup
{
    [super startup];
    
    self.isCanNotCoill = YES;
    self.position = CGPointMake(self.position.x, self.position.y-193);
    SKAction *popUp = [SKAction animateWithTextures:Atlas(self.texString_move_B) timePerFrame:oneKey resize:YES restore:NO];
    [self runAction:popUp completion:^{
        self.isCanNotCoill = NO;
        [self useRest];
    }];
    
    [self firstIn];
}

-(void)firstIn
{
    [self reloadRect];
    for (Jelly *jelly in jellys.children) {
        if (CGRectIntersectsRect(jelly.boxRect, self.boxRect)) {
            [jelly useDie];
        }
    }
}

-(void)useRest
{
    if ([self changCanStatusRun:@"loveRest"] == NO) {
        return;
    }
    self.canNotChangeStatus = @[@"loveRest"];
    
    SKAction *lovelyRest = [SKAction animateWithTextures:Atlas(self.texString_rest_B) timePerFrame:oneKey resize:YES restore:NO];
    SKAction *repLovely = [SKAction repeatAction:lovelyRest count:5];
    SKAction *complition = [SKAction runBlock:^{
        [self useMove];
    }];
    SKAction *runSeq = [SKAction sequence:@[repLovely,complition]];
    [self runAction:runSeq withKey:@"lovelyRest"];
}

-(void)useAttack
{
    [self useSkill];
}

-(void)useSkill
{
    if ([self changCanStatusRun:s_skill] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_skill];
    
    CGRect magicRect = CGRectMake(50, ih-820, 550, 820); //魔法碰撞面积 highEnergy
    for (Jelly *jelly in jellys.children) {
        if (CGRectIntersectsRect(magicRect, jelly.boxRect) && ([jelly.myName isEqualToString:@"energy"] || [jelly.myName isEqualToString:@"highEnergy"])) {
            [jelly beBuff_sleep:3];
        }
    }
    SKAction *maidSkill = [SKAction animateWithTextures:Atlas(self.texString_skill) timePerFrame:oneKey resize:YES restore:NO];
    SKAction *maidSkillEndCheck = [SKAction runBlock:^{
        self.canNotChangeStatus = @[];
        [self useAttack];
    }];
    SKAction *allInOne = [SKAction sequence:@[maidSkill,maidSkillEndCheck]];
    [self runAction:allInOne withKey:s_skill];
}

@end
