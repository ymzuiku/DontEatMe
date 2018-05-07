//
//  BoxerJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "BoxerJelly.h"

@implementation BoxerJelly
{
    SKNode *chickens;
//    int killNumbers;
    SKSpriteNode *critNode;
}

-(void)removeFromParent
{
    chickens = nil;
    [super removeFromParent];
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_boxer_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    
    self.myName = @"boxer";
    self.gemTexture = Atlas(@"ui_map_bigObj")[3];
    self.texString_attack = @"jelly_boxer_attack";
    self.texString_rest = @"jelly_boxer_rest";
    [self changeGem];
    
    self.attack = 10;
    [self sitDefaultHP:2500];
    self.defAttackRect = CGRectMake(-20, -20, 40, 110);
    
    if (self.isGemA == YES) {
        [self sitDefaultHP:5000];
    }
    if (self.isGemB == YES) {
        critNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"chicken_buff_doom")[0]];
        critNode.position = CGPointMake(30, 20);
        critNode.hidden = YES;
        [self addChild:critNode];
    }
    
    ViewController *vc = [ViewController single];
    chickens = vc.gameScene.war.chickens;
}

-(void)useAttack
{
    if ([self changCanStatusRun:s_attack] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_attack];
    
    if (!self.attackAction) {
        SKAction *completion = [SKAction runBlock:^{
            self.canNotChangeStatus = @[];
            [self useRest];
        }];
        SKAction *restAnimate = [SKAction animateWithTextures:Atlas(self.texString_rest) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
        SKAction *animateRest = [SKAction repeatAction:restAnimate count:2];
        SKAction *attackAnima = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
        
        SKAction *shoot = [SKAction runBlock:^{
            for (Chicken *chicken in chickens.children) {
                if (CGRectIntersectsRect(self.attackRect, chicken.boxRect)) {
                    SKAction *wait = [SKAction waitForDuration:0.1];
                    SKAction *block = [SKAction runBlock:^{
                        [self shoot:chicken];
                    }];
                    SKAction *seq = [SKAction sequence:@[block,wait]];
                    [self runAction:[SKAction repeatAction:seq count:3]];
                }
            }
        }];
        SKAction *waitShoot = [SKAction waitForDuration:0.2/self.speedAttack];
        SKAction *seqShoot = [SKAction sequence:@[waitShoot, shoot]];
        SKAction *shootBullet = [SKAction sequence:@[attackAnima,animateRest, completion]];
        self.attackAction = [SKAction group:@[shootBullet,seqShoot]];
    }
    float tempTime = skRand(0, 5)/10;
    SKAction *randomWait = [SKAction waitForDuration:tempTime];
    SKAction *seq = [SKAction sequence:@[randomWait, self.attackAction]];
    [self runAction:seq withKey:s_attack];
}

-(void)shoot:(Chicken *)chicken
{
    float tempAttack = self.attack;
    if (self.isGemB == YES && skRand(0, 100) < 25) {
        tempAttack *=4;
        [self critAnime];
    }
    
    [chicken changeHP:tempAttack attacker:self];
//    BOOL isKilled = [chicken changeHP:tempAttack attacker:self];
//    if (self.isGemA == 1) {
//        if (killNumbers < 30 && isKilled) {
//            killNumbers++;
//            self.attack++;
//        }
//    }
}

-(void)critAnime
{
    critNode.hidden = NO;
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"chicken_buff_doom") timePerFrame:oneKey resize:YES restore:NO];
    [critNode runAction:anime completion:^{
        critNode.hidden = YES;
    }];
}

@end
