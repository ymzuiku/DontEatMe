//
//  SpoonChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "SpoonChicken.h"

@implementation SpoonChicken

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_spoon_move")[0]]) {
        
    }
    return self;
}


-(void)createInit
{
    [super createInit];
    self.myName = @"spoon";
    self.texString_attack = @"chicken_spoon_attack";
    self.texString_move = @"chicken_spoon_move";
    self.texString_rest = @"chicken_spoon_rest";
    self.texString_drop = @"chicken_spoon_dropDown";
    
    self.haveNormalChicken_time = 1;
    
}

@end
