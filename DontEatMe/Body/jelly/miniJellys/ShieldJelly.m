//
//  ShieldJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "ShieldJelly.h"
#import "CDBar.h"
@implementation ShieldJelly
{
    SKNode *jellys;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_shield_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"shield";
    self.gemTexture = Atlas(@"ui_map_bigObj")[6];
    self.texString_attack = @"jelly_shield_attack";
    self.texString_rest = @"jelly_shield_rest";
    [self changeGem];
    
    self.skillCD = 15*iSpeed;
    self.haveShield_time = 15*iSpeed;
    self.haveShield_hp = 800*iSpeed;
    self.haveShield_noDieTime = 0;
    if (self.isGemA == YES) {
        self.haveShield_hp *= 2;
    }
    if (self.isGemB == YES) {
        self.haveShield_noDieTime = 5;
    }
    [self addCDBar:CGPointMake(0, -30) name:@"jelly_cd_timing" beginName:@"jelly_cd_beging"];
    self.defAttackRect = CGRectMake(-20, 40, 40, 96-40);
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
//    if ([self changCanStatusRun:s_skill] == NO) {                 //观察效果
//        return;
//    }
    self.canNotChangeStatus = @[s_skill];
    
    SKAction *wait = [SKAction waitForDuration:0.5*iSpeed];
    SKAction *shoot = [SKAction runBlock:^{
        for (Jelly *jelly in jellys.children) {
            if (CGRectIntersectsRect(self.attackRect, jelly.boxRect)) {
//                if (!self.isCding && jelly.nowHP < jelly.defaultHP) {
                if (!self.isCding) {                             //test  加血方式变化
                    [self.cdBar changeCDBar:^{
                        self.isCding = NO;
                    }];
                    SKAction *anime = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey resize:YES restore:NO];
                    [self runAction:anime];
                    [jelly beBuff_Shield:self.haveShield_time shieldHP:self.haveShield_hp noDieTime:self.haveShield_noDieTime];
                    self.isCding = YES;
                }
            }
        }
    }];
    SKAction *seq = [SKAction sequence:@[wait, shoot]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    [self runAction:rep withKey:s_skill];
}


@end
