//
//  YodaChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "YodaChicken.h"
#import "Buff.h"


@implementation YodaChicken
{
    int restOnce;
    SKNode *jellys;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_yoda_move")[0]]) {
        
    }
    return self;
}

-(void)reloadRect
{
    self.attackRect = CGRectMake(self.position.x+self.defAttackRect.origin.x, self.position.y+self.defAttackRect.origin.y, self.defAttackRect.size.width, self.defAttackRect.size.height);
    self.boxRect = CGRectMake(self.position.x+self.defBoxRect.origin.x, self.position.y+self.defBoxRect.origin.y, self.defBoxRect.size.width, self.defBoxRect.size.height);
    if (self.position.y < ih-120 && self.snailBuff.isBuffing == 0) {
        self.defAttackRect = CGRectMake(-640, 97*7, 1280, -97*15);
        if (restOnce == 0) {
            [self useYodaRest];
            self.isSkillCDing = NO;
            restOnce = 1;
        }
    }
}

-(void)createInit
{
    [super createInit];
    [self sitDefaultHP:self.defaultHP*3];
    self.myName = @"yoda";
    self.texString_attack = @"chicken_yoda_attack";
    self.texString_move = @"chicken_yoda_move";
    self.texString_rest = @"chicken_yoda_idle";
    self.texString_rest_B = @"chicken_yoda_rest";
    
    self.soundAction_skillA = [SKAction playSoundFileNamed:@"Sound/yoda_laserSword_0.mp3" waitForCompletion:YES];
    self.attack = 30;
    
    self.haveYoda_hurt = 200*3;
    self.haveYoda_time = 1;
    ViewController *vc = [ViewController single];
    jellys = vc.gameScene.war.jellys;
    
}

-(void)useAttack
{
    if (self.dizzyLoingBuff.isBuffing == YES) {
        return;
    }
    if (self.isSkillCDing == NO && restOnce == 1) {
        [self useSkill];
        return;
    }
   
    if (![self changCanStatusRun:s_attack]) {
        return;
    }
    self.canNotChangeStatus = @[s_attack];
    [super useAttack];
    SKAction *attack_BeginBlock = [SKAction runBlock:^{
        [self.attackBody changeHP:self.attack attacker:self];
    }];
    SKAction *attack_Wait = [SKAction waitForDuration:Atlas(self.texString_attack).count*oneKey/self.speedAttack];
    SKAction *attack_EndBlock = [SKAction runBlock:^{
        [self useMove];
    }];
    SKAction *attack_seq = [SKAction sequence:@[attack_Wait,attack_BeginBlock,attack_EndBlock]];
    [self runAction:attack_seq withKey:s_attack];
}

-(void)useSkill
{
    if (![self changCanStatusRun:s_skill]) {
        return;
    }
    self.canNotChangeStatus = @[s_skill,s_attack];
    [super useAttack];
    SKAction *attack_BeginBlock = [SKAction runBlock:^{
        self.haveBuffSkill = YES;
        [self changeSkillCD];
        self.isSkillCDing = YES;
//        [self.attackBody beSkillWithAttacker:self];
        [self.attackBody beBuff_Yoda:self.haveYoda_time hurt:self.haveYoda_hurt];
        [self.attackBody changeHP:1 attacker:self];
        self.haveBuffSkill = NO;
    }];
    SKAction *attack_Wait = [SKAction waitForDuration:Atlas(self.texString_attack).count*oneKey/self.speedSkill];
    SKAction *attack_Rest = [SKAction repeatAction:[SKAction animateWithTextures:Atlas(self.texString_rest) timePerFrame:oneKey/self.speedSkill resize:YES restore:NO] count:4] ;
    SKAction *attack_EndBlock = [SKAction runBlock:^{
        self.isSkillCDing = NO;
        if (jellys.children.count == 0) {
            [self useMove];
        }else{
            [self useYodaRest];
        }
    }];
    self.skillAction = [SKAction sequence:@[attack_BeginBlock,attack_Wait,attack_Rest,attack_EndBlock]];
    [self runAction:self.skillAction withKey:s_skill];
}

-(void)useRest
{
    if (![self changCanStatusRun:s_rest]) {
        return;
    }
    self.canNotChangeStatus = @[s_rest,s_move];
    if (!self.restAction) {
        SKAction *rest = [SK_Actions animateWithTextures:Atlas(self.texString_rest_B) timePerFrame:oneKey/self.speedRest resize:YES restore:NO];
        self.restAction = [SKAction repeatActionForever:rest];
    }
    [self runAction:self.restAction withKey:s_rest];
}

-(void)useYodaRest
{
    if (![self changCanStatusRun:s_rest]) {
        return;
    }
    self.canNotChangeStatus = @[s_rest];
    if (!self.restAction) {
        SKAction *rest = [SK_Actions animateWithTextures:Atlas(self.texString_rest) timePerFrame:oneKey/self.speedRest resize:YES restore:NO];
        self.restAction = [SKAction repeatActionForever:rest];
    }
    [self runAction:self.restAction withKey:s_rest];
    SKAction *wait = [SKAction waitForDuration:5];
    SKAction *checkAndMove = [SKAction runBlock:^{
        if (jellys.children.count== 0) {
            [self useMove];
        }
    }];
    SKAction *checkAndMoveSeq = [SKAction sequence:@[wait,checkAndMove]];
    [self runAction:checkAndMoveSeq withKey:@"checkAndMove"];
}

-(void)changeSkillCD
{
    SKAction *wait = [SKAction waitForDuration:15];
    SKAction *cdBlock = [SKAction runBlock:^{
        self.isSkillCDing = NO;
    }];
    SKAction *skillCDSeq = [SKAction sequence:@[wait,cdBlock]];
    [self runAction:skillCDSeq withKey:@"skillCD"];
}

@end
