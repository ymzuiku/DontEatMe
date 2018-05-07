//
//  IceThickJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "IceThickJelly.h"
#import "CDBar.h"

@implementation IceThickJelly
{
    SKEmitterNode *startPartique;
    BOOL isNotDie;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_iceThick_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"iceThick";
    self.gemTexture = Atlas(@"ui_map_bigObj")[7];
    self.texString_rest = @"jelly_iceThick_rest";
    self.breakTexString = @"jelly_iceThick_breakRest";
    [self sitDefaultHP:8000];
    [self changeGem];
    
    //薄葬宝石
    if (self.isGemB == YES) {
        self.skillCD = 30;
        [self addCDBar:CGPointMake(0, -15) name:@"jelly_cd_timing" beginName:@"jelly_cd_beging"];
        startPartique = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"sparkParticle" ofType:@"sks"]];
        startPartique.zPosition = -1;
        startPartique.targetNode = self;
        startPartique.userInteractionEnabled = NO;
        startPartique.position = CGPointMake(0, -20);
        [startPartique setScale:0.7];
        [self addChild:startPartique];
        startPartique.particleLifetime = 0;
    }
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    if (self.isGemA == YES) {
        hurt *= 0.65;
    }
    
    //薄葬
    if (self.isGemB == YES && !self.cdBar.isCding && self.nowHP - hurt <= 0) {
        isNotDie = YES;
        [self.cdBar changeCDBar:nil];
        startPartique.particleLifetime = 0.7;
        SKAction *wait = [SKAction waitForDuration:8];
        [self runAction:wait completion:^{
            startPartique.particleLifetime = 0;
            isNotDie = NO;
        }];
    }
    if (isNotDie) {
        return NO;
    }
    return [super changeHP:hurt attacker:attacker];
}

@end
