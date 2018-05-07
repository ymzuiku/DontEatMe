//
//  IceThinJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "IceThinJelly.h"

@implementation IceThinJelly
{
    SKEmitterNode *startPartique;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_iceThin_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"iceThin";
    self.gemTexture = Atlas(@"ui_map_bigObj")[7];
    self.texString_rest = @"jelly_iceThin_rest";
    self.breakTexString = @"jelly_iceThin_breakRest";
    [self sitDefaultHP:3500];
    [self changeGem];
    
    if (self.isGemA == YES) {
        startPartique = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"noDieParticle" ofType:@"sks"]];
        startPartique.zPosition = -1;
        startPartique.targetNode = self;
        startPartique.userInteractionEnabled = NO;
        startPartique.position = CGPointMake(0, -25);
        [startPartique setScale:0.05];
        [self addChild:startPartique];
        startPartique.particleLifetime = 0;
        startPartique.particleLifetimeRange = 0;
    }
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    if (self.isGemA == YES) {
        if (self.nowHP + hurt < self.defaultHP && startPartique.particleLifetime == 0) {
            startPartique.particleLifetime = 0.7;
            startPartique.particleLifetimeRange = 1.2;
            SKAction *wait = [SKAction waitForDuration:5];
            SKAction *block = [SKAction runBlock:^{
                [self changeHP:-300 attacker:nil];
            }];
            SKAction *seq = [SKAction sequence:@[wait, block]];
            SKAction *rep = [SKAction repeatActionForever:seq];
            [self runAction:rep withKey:@"gemA"];
        }
        else if (self.nowHP + hurt >= self.defaultHP && startPartique.particleLifetime != 0) {
            startPartique.particleLifetime = 0;
            startPartique.particleLifetimeRange = 0;
            [self removeActionForKey:@"gemA"];
        }
    }
    if (self.isGemB == YES && hurt > 1800) {
        hurt = 1800;
    }
    return [super changeHP:hurt attacker:attacker];
}

@end
