//
//  FireMagicChicken.m
//  DontEatMe
//
//  Created by ym on 15/5/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "FireMagicChicken.h"
#import "FireMagicBullet.h"

@implementation FireMagicChicken
{
    SKNode *games;
    SKNode *jellys;
    SKSpriteNode *fireMagicBall;
    float loadSkillNumbel;
    int skillLoadingTime;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_fireMagic_move")[0]]) {

    }
    return self;
}

-(void)reloadRect
{
    self.attackRect = CGRectMake(self.position.x+self.defAttackRect.origin.x, self.position.y+self.defAttackRect.origin.y, self.defAttackRect.size.width, self.defAttackRect.size.height);
    self.boxRect = CGRectMake(self.position.x+self.defBoxRect.origin.x, self.position.y+self.defBoxRect.origin.y, self.defBoxRect.size.width, self.defBoxRect.size.height);
    if (self.position.y < ih-96*1.8 && self.snailBuff.isBuffing == 0) {
        self.defAttackRect = CGRectMake(-57, 0, 114, -97*7);
    }
}

-(void)createInit
{
    [super createInit];
    self.myName = @"rifle";
    self.texString_attack = @"chicken_fireMagic_attack";
    self.texString_move = @"chicken_fireMagic_move";
    self.texString_rest = @"chicken_fireMagic_rest";
    self.texString_skill = @"chicken_fireMagic_skill";
    
    self.soundAction_attackA = [SKAction playSoundFileNamed:@"Sound/rife_attack_0.mp3" waitForCompletion:YES];
    self.soundAction_attackB = [SKAction playSoundFileNamed:@"Sound/rife_attack_1.mp3" waitForCompletion:YES];
    
    self.skillCD = 12; //魔法冷却时间
    skillLoadingTime = 3; //魔法施法时间
    if (!games) {
        ViewController *vc = [ViewController single];
        games = vc.gameScene.war.chickenBullets;
    }
    [self sitDefaultHP:self.defaultHP*6];
    jellys = [ViewController single].gameScene.war.jellys;

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
    
    [self createMagicSkill];
    
    
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
        [self boomMagicSkill];
        self.skillBar.hidden = YES;
    }];
    
    SKAction *seqEnd = [SKAction sequence:@[repLoading, endBlock]];
    
    SKAction *anime = [SK_Actions actionAnime:Atlas(self.texString_skill) repeat:0];
    SKAction *group = [SKAction group:@[seqEnd, anime]];
    
    [self runAction:group withKey:s_skill];
    
}

-(void)createMagicSkill
{
    ViewController *vc = [ViewController single];
    fireMagicBall = [SKSpriteNode spriteNodeWithTexture:Atlas(@"chicken_buff_fireBall")[0]];
    fireMagicBall.position = CGPointMake(skRand(135, 634), skRand(ih-785, ih-280));
    fireMagicBall.zPosition = 1999 - fireMagicBall.position.y;
    [vc.gameScene.war addChild:fireMagicBall];
    
    SKAction *fadeOut = [SKAction fadeAlphaTo:0.3 duration:1.5];
    SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:1.5];
    SKAction *seq = [SKAction sequence:@[fadeOut, fadeIn]];
    SKAction *rep = [SKAction repeatAction:seq count:20];
    [fireMagicBall runAction:rep withKey:@"wait"];
}

-(void)boomMagicSkill
{
    [fireMagicBall removeActionForKey:@"wait"];
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"chicken_buff_fireBall") timePerFrame:0.1 resize:YES restore:NO];
    [fireMagicBall runAction:anime];
    
    SKAction *miniWait = [SKAction waitForDuration:0.5];
    [self runAction:miniWait completion:^{
        CGRect magicRect = CGRectMake(-300/2+fireMagicBall.position.x, -240/2+fireMagicBall.position.y-100, 300, 240); //魔法碰撞面积
        for (Jelly *jelly in jellys.children) {
            if (CGRectIntersectsRect(magicRect, jelly.boxRect)) {
                [jelly changeHP:1000 attacker:self];  //魔法伤害
            }
        }
        [self useMove];
    }];
}

-(void)useAttack
{
    if (self.attackBody.nowHP < self.attack) {
        return;
    }
    if ([self changCanStatusRun:s_attack] == NO) {
        return;
    }
    
    [fireMagicBall removeFromParent];
    self.skillBar.hidden = YES;
    SKAction *loadingSkill = [self actionForKey:s_loadingSkill];
    loadingSkill.speed = 1;
    
    self.canNotChangeStatus = @[s_attack];
    [super useAttack];
    SKAction *attack_BeginBlock = [SKAction runBlock:^{
        CGPoint pos = CGPointMake(self.position.x, self.position.y-50);
        FireMagicBullet *bullet = [[FireMagicBullet alloc] initWithPosition:pos zPosition:self.zPosition];
        bullet.zPosition = 1999;
        bullet.damage = self.attack;
        [games addChild:bullet];
    }];
    SKAction *attack_Wait = [SKAction waitForDuration:Atlas(self.texString_attack).count*oneKey/self.speedAttack*0.7];
    SKAction *attack_Wait2 = [SKAction waitForDuration:0.2];
    SKAction *attack_StopAction = [SKAction runBlock:^{
        if (self.attackBody.nowHP < self.attack) {
            [super useMove];
        }
        self.canNotChangeStatus = @[];
    }];
    SKAction *attack_seq = [SKAction sequence:@[attack_Wait,attack_BeginBlock,attack_Wait2,attack_StopAction,]];
    [self runAction:attack_seq withKey:s_attack];
}

-(void)useMove
{
    [super useMove];
    [fireMagicBall removeFromParent];
    self.skillBar.hidden = YES;
}

-(void)useRest
{
    [super useRest];
    [fireMagicBall removeFromParent];
    self.skillBar.hidden = YES;
}

@end
