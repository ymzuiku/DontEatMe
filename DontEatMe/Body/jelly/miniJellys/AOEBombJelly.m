//
//  AOEBombJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "AOEBombJelly.h"

@implementation AOEBombJelly
{
    SKNode *chickens;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_aoeBoom_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"AOEBoom";
    self.gemTexture = Atlas(@"ui_map_bigObj")[4];
    self.texString_attack = @"jelly_aoeBoom_create";
    self.texString_rest = @"jelly_aoeBoom_create";
    [self changeGem];
    
    self.haveBuffSkill = YES;
    self.haveBoom_time = 1;
    self.haveBoom_hurt = 250;
    [self sitDefaultHP:2000];
    
    if (self.isGemA == YES) {
        self.haveBoom_hurt *= 2;
    }
    
    ViewController *vc = [ViewController single];
    chickens = vc.gameScene.war.chickens;
}

-(void)startup
{
    [super startup];
    self.defAttackRect = CGRectMake(-57, -1136, 114, ih-96-self.position.y+1136);
    [self reloadRect];
}

-(void)useAttack
{
    [self useSkill];
}

-(void)useSkill
{
    if (![self changCanStatusRun:s_skill]) {
        return;
    }
    self.canNotChangeStatus = @[s_skill];
    SKAction *boom = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey resize:YES restore:NO];
    SKAction *wait = [SKAction waitForDuration:boom.duration/2];
    SKAction *block = [SKAction runBlock:^{
        for (Chicken *chicken in chickens.children) {
            if (CGRectIntersectsRect(self.attackRect, chicken.boxRect)) {
                [chicken beBuff_Boom:self.haveBoom_time hurt:self.haveBoom_hurt];
            }
        }
    }];
    SKAction *boomBlock = [SKAction runBlock:^{
        [super useDie];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    SKAction *seq2 = [SKAction sequence:@[boom, boomBlock]];
    SKAction *group = [SKAction group:@[seq, seq2]];
    [self runAction:group withKey:s_skill];
}

-(void)removeFromParent
{
    chickens = nil;
    [self removeAllActions];
    [super removeFromParent];
}

@end
