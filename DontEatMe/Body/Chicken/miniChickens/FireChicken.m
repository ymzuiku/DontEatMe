//
//  FireChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "FireChicken.h"

@implementation FireChicken
{
    float attackInterval;
    NSMutableArray *attackBodys;
}

-(id)init

{
    if (self = [super initWithTexture:Atlas(@"chicken_fire_move")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"fire";
    self.texString_attack = @"chicken_fire_attack";
    self.texString_move = @"chicken_fire_move";
    self.texString_rest = @"chicken_fire_rest";
    self.soundAction_attackA = [SKAction playSoundFileNamed:@"Sound/fire_chicken_attack.mp3" waitForCompletion:YES];
    self.isSkillCDing = NO;
    self.attack = 57;
    attackInterval = 1.0;
    attackBodys = [[NSMutableArray alloc] init];
    [self sitDefaultHP:350];
}

-(void)useSkill
{
    [self addJellyArray:self.attackBody];
    if (![self changCanStatusRun:s_skill]) {
        return;
    }
    self.canNotChangeStatus = @[s_skill];
    self.defAttackRect = CGRectMake(-25, 0, 50, -97*3);
    if (self.FireEmitter == nil) {
        self.FireEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]
                                                                       pathForResource:@"FireChickenParticle" ofType:@"sks"]];
        self.FireEmitter.position = CGPointMake(15,-20);
        self.FireEmitter.zPosition = 94*3;
        self.FireEmitter.name = @"jetEmitter";
        [self addChild:self.FireEmitter];
    }else{
        self.FireEmitter.hidden = NO;
    }
    //fireAttack 攻击动画
    SKAction *fireAttack_animation = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey*1.2/self.speedAttack resize:YES restore:NO];
    SKAction *fireAttack_repAnimation = [SKAction repeatActionForever:fireAttack_animation];
    
    //fireAttack 减血动作
    SKAction *fireAttack_beginBlock = [SKAction runBlock:^{
        Body *maxY_Jelly;
        for (Body *tempJelly in attackBodys) {
            if (maxY_Jelly == nil || tempJelly.position.y > maxY_Jelly.position.y) {
                maxY_Jelly = tempJelly;
            }
            if (maxY_Jelly.nowHP <= self.attack) {
                [tempJelly changeHP:self.attack attacker:self];
                self.FireEmitter.hidden = YES;
                [attackBodys removeAllObjects];
                [self useMove];
                self.defAttackRect = CGRectMake(-25, 0, 50, -97/2);
                break;
                return;
            }else{
                [tempJelly changeHP:self.attack attacker:self];
            }
        }
    }];

    SKAction *fireAttack_wait = [SKAction waitForDuration:attackInterval];
    SKAction *fireAttack_seq = [SKAction sequence:@[fireAttack_beginBlock,fireAttack_wait]];
    SKAction *fireAttack_repBeginBlock = [SKAction repeatActionForever:fireAttack_seq];
    
    //fireAttack 合成
    SKAction *fireAttack_group = [SKAction group:@[fireAttack_repAnimation,fireAttack_repBeginBlock]];
    [self runAction:fireAttack_group withKey:s_skill];
}

-(void)addJellyArray:(Body *)jelly
{
    if (![attackBodys containsObject:jelly]) {
        [attackBodys addObject:jelly];
    }
}

@end
