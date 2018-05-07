//
//  HighEnergyJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//
// 消耗和普通能量一样,但是产能提高1点.

#import "HighEnergyJelly.h"

@implementation HighEnergyJelly

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_highEnergy_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"highEnergy";
    self.downManaNumb = @"mana.4";
    self.gemTexture = Atlas(@"ui_map_bigObj")[5];
    self.isNotAtlas_Static = YES;
    self.texString_attack = @"jelly_highEnergy_create";
    self.texString_rest = @"jelly_highEnergy_rest";
    [self changeGem];
    
    if (self.isGemB == YES) {
        self.mana.speed = 1.25;
    }
    
    if (self.isGemA == YES) {
        self.isCallBackMana = 4;
    }
}


@end
