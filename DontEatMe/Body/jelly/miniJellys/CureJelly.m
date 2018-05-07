//
//  CureJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CureJelly.h"
#import "CDBar.h"

@implementation CureJelly
{
    SKNode *jellys;
    BOOL isCding;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_cure_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"cure";
    self.gemTexture = Atlas(@"ui_map_bigObj")[6];
    self.texString_attack = @"jelly_cure_attack";
    self.texString_rest = @"jelly_cure_rest";
    [self changeGem];
    
    self.skillCD = 15;
    self.haveCure_time = 1;
    self.haveCure_rate = 0.6;
    if (self.isGemA == YES) {
        self.skillCD = 10;
    }
    if (self.isGemB == YES) {
        self.haveRecovery_hurt = -200;
        self.haveRecovery_miniCD = 1;
        self.haveRecovery_time = 8;
    }
    [self addCDBar:CGPointMake(0, -30) name:@"jelly_cd_timing" beginName:@"jelly_cd_beging"];
    self.defAttackRect = CGRectMake(-20, 40, 40, 96*2-40);
    ViewController *vc = [ViewController single];
    jellys = vc.gameScene.war.jellys;
}

-(void)startup
{
    [super startup];
    [self useSkill];
}

-(void)useAttack{};

-(void)useSkill
{
    self.canNotChangeStatus = @[s_skill];
    
    SKAction *wait = [SKAction waitForDuration:2];
    SKAction *shoot = [SKAction runBlock:^{
        for (Jelly *jelly in jellys.children) {
            if (CGRectIntersectsRect(self.attackRect, jelly.boxRect)) {
                if (!isCding && jelly.nowHP < jelly.defaultHP*0.4) {
                    [self.cdBar changeCDBar:^{
                        isCding = NO;
                    }];
                    SKAction *anime = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey resize:YES restore:NO];
                    [self runAction:anime];
                    [jelly beBuff_Cure:self.haveCure_time hp:jelly.defaultHP];
                    if (self.isGemB == YES) {
                        [jelly beBuff_recovery:self.haveRecovery_time miniCD:self.haveRecovery_miniCD hurt:self.haveRecovery_hurt];
                    }
                    isCding = YES;
                    
                }
            }
        }
    }];
    SKAction *seq = [SKAction sequence:@[wait, shoot]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    [self runAction:rep withKey:s_skill];
}



@end
