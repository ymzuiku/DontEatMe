//
//  SawChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "SawChicken.h"

@implementation SawChicken
{
    NSArray *attackAnimationArray1;
    NSArray *attackAnimationArray2;
    NSArray *attackAnimationArray3;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_saw_move")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    [self sitDefaultHP:self.defaultHP*3];
    self.myName = @"saw";
    self.texString_attack = @"chicken_saw_attack";
    self.texString_move = @"chicken_saw_move";
    self.texString_rest = @"chicken_saw_rest";
    self.texString_rest_B = @"chicken_saw_wait";
    self.texString_drop = @"chicken_saw_dropDown";
    
    self.soundAction_attackA = [SKAction playSoundFileNamed:@"Sound/saw_attack_0.mp3" waitForCompletion:YES];
    self.soundAction_attackB = [SKAction playSoundFileNamed:@"Sound/saw_attack_1.mp3" waitForCompletion:YES];
    
    attackAnimationArray1 = [Atlas(self.texString_attack) subarrayWithRange:NSMakeRange(0,14)];
    attackAnimationArray2 = [Atlas(self.texString_attack) subarrayWithRange:NSMakeRange(15,10)];
    attackAnimationArray3 = [Atlas(self.texString_attack) subarrayWithRange:NSMakeRange(26,5)];
    [self sitDefaultHP:self.defaultHP*1.6];
    self.speedMove *= 0.7;
    self.attack = 100;
    
}

-(void)useAttack
{
    if (self.snailBuff.isBuffing == YES) {
        
        [self snailAttack];
    }else{
        [self normalAttack];
    }
}

-(void)normalAttack
{
    if (![self changCanStatusRun:s_attack]) {
        return;
    }
    self.canNotChangeStatus = @[s_attack];
    if (!self.attackAction) {
        SKAction *attack_animation1 = [SKAction animateWithTextures:attackAnimationArray1 timePerFrame:oneKey/2*self.speedAttack resize:YES restore:NO];
        
        SKAction *attack_animation2 = [SKAction animateWithTextures:attackAnimationArray2 timePerFrame:oneKey/2*self.speedAttack resize:YES restore:NO];
        SKAction *attack_action = [SKAction runBlock:^{
            if (self.attackBody.nowHP < self.attack) {
                [self.attackBody changeHP:self.attack attacker:self];
                [self useAttackEndToMove];
            }else if ([self.attackBody.myName isEqualToString:@"iceThick"]) {
                [self.attackBody changeHP:self.attack*2 attacker:self];
            }else{
                [self.attackBody changeHP:self.attack attacker:self];
            }
        }];
        SKAction *attack_action_seq = [SKAction sequence:@[attack_animation2,attack_action,attack_animation2,attack_action,attack_animation2,attack_action,attack_animation2,attack_action,attack_animation2,attack_action,attack_animation2,attack_action,attack_animation2,attack_action,]];
        
        SKAction *attack_animation3 = [SKAction animateWithTextures:attackAnimationArray3 timePerFrame:oneKey/2*self.speedAttack resize:YES restore:NO];
        SKAction *attack_wait = [SKAction animateWithTextures:Atlas(self.texString_rest_B) timePerFrame:oneKey/2 resize:YES restore:NO];
        SKAction *attack_seq = [SKAction sequence:@[attack_animation1,attack_action_seq,attack_animation3,attack_wait,attack_wait,attack_wait,attack_wait]];
        self.attackAction = [SKAction repeatActionForever:attack_seq];
    }
    [self runAction:self.attackAction withKey:s_attack];
}

-(void)snailAttack
{
    [super useAttack];
}

-(void)useAttackEndToMove
{
    if ([self changCanStatusRun:s_skill] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_attack, s_skill];
    SKAction *attack_animation3 = [SKAction animateWithTextures:attackAnimationArray3 timePerFrame:oneKey/2*self.speedAttack resize:YES restore:NO];
    SKAction *attack_endBlock = [SKAction runBlock:^{
        [self useMove];
    }];
    SKAction *attack_seq = [SKAction sequence:@[attack_animation3,attack_endBlock]];
    [self runAction:attack_seq withKey:s_skill];
}

@end
