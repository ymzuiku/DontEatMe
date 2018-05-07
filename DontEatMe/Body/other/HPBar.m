//
//  HPBar.m
//  DontEatMe
//
//  Created by pringlesfox on 9/11/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "HPBar.h"

@implementation HPBar
{
    NSString *atlasName;
}

-(id)initWithName:(NSString *)name
{
    if (self = [super initWithTexture:AtlasNum(name,0)]){
        atlasName = name;
    }
    return self;
}

-(void)changeHPBar:(float)currentHP
{
    if (currentHP < 0) {
        currentHP = 1;
    }
    self.texture = AtlasNum(atlasName, 120-(int)(currentHP/(_defaultHP_HPBar/120)));
}

@end
