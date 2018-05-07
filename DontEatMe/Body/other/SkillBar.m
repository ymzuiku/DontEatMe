//
//  SkillBar.m
//  DontEatMe
//
//  Created by ym on 15-5-21.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "SkillBar.h"

@implementation SkillBar
{
    NSString *atlasName;
}

-(id)initWithName:(NSString *)name
{
    if (self = [super initWithTexture:AtlasNum(name, 48)]){
        atlasName = name;
    }
    return self;
}

-(void)changeBar:(float)currentHP
{
    if (currentHP < 0) {
        currentHP = 1;
    }
    self.texture = AtlasNum(atlasName, 48-(int)(currentHP/(_defaultSkillCD_skillBar)*48));
}

@end
