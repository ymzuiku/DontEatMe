//
//  DizzyJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "DizzyJelly.h"

@implementation DizzyJelly
{
    SKNode *chickens;
    float dizzyTime;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_dizzy_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    
    self.myName = @"dizzy";
    self.gemTexture = Atlas(@"ui_map_bigObj")[4];
    self.texString_attack = @"jelly_dizzy_create";
    self.texString_rest = @"jelly_dizzy_rest";
    [self changeGem];
    [self sitDefaultHP:2000];
    
    dizzyTime = 7 * iSpeed;
    
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
        [self shoot];
    }];
    SKAction *boomBlock = [SKAction runBlock:^{
        [super useDie];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    SKAction *seq2 = [SKAction sequence:@[boom, boomBlock]];
    SKAction *wait2 = [SKAction waitForDuration:0.4];
    SKAction *seq3 = [SKAction sequence:@[wait2, [SK_Actions jump:1.7 timeRate:1]]];
    SKAction *group = [SKAction group:@[seq, seq2, seq3]];
    [self runAction:group withKey:s_skill];
}

-(void)shoot
{
    if (self.isGemA == NO) {
        for (Chicken *chicken in chickens.children) {
            if (CGRectIntersectsRect(self.attackRect, chicken.boxRect)) {
                [chicken beBuff_dizzy:dizzyTime random:110];
            }
            if (self.isGemB == YES) {
                CGRect lineRect = CGRectMake(-640, -96/2, 640*2, 96);
                if (CGRectIntersectsRect(lineRect, chicken.boxRect)) {
                    [chicken beBuff_dizzy:dizzyTime random:110];
                }
            }
        }
    }
    else {
        int allHurt = 0;
        for (Chicken *chicken in chickens.children) {
            if (CGRectIntersectsRect(self.attackRect, chicken.boxRect)) {
                [chicken beBuff_dizzy:dizzyTime random:110];
                allHurt += 25;
            }
            if (self.isGemB == YES) {
                CGRect lineRect = CGRectMake(-640, -96/2, 640*2, 96);
                if (CGRectIntersectsRect(lineRect, chicken.boxRect)) {
                    [chicken beBuff_dizzy:dizzyTime random:110];
                    allHurt+= 25;
                }
            }
        }
        for (Chicken *chicken in chickens.children) {
            if (CGRectIntersectsRect(self.attackRect, chicken.boxRect)) {
                [chicken changeHP:allHurt attacker:self];
            }
            if (self.isGemB == YES) {
                CGRect lineRect = CGRectMake(-640, -96/2, 640*2, 96);
                if (CGRectIntersectsRect(lineRect, chicken.boxRect)) {
                    [chicken changeHP:allHurt attacker:self];
                }
            }
        }
    }
}

-(void)removeFromParent
{
    chickens = nil;
    [self removeAllChildren];
    [super removeFromParent];
}


@end
