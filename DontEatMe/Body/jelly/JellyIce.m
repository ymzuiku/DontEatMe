//
//  JellyIce.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "JellyIce.h"

@implementation JellyIce


-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    if (self.nowHP < self.defaultHP * 0.4) {
        self.texString_rest = self.breakTexString;
        self.isNotAtlas_Static = YES;
        self.canNotChangeStatus = @[];
        self.restAction = nil;
        [self useRest];
    }
    return [super changeHP:hurt attacker:attacker];
}

@end
