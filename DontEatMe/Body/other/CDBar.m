//
//  CDBar.m
//  DontEatMe
//
//  Created by ym on 14/10/16.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "CDBar.h"

@implementation CDBar
{
    NSString *cdName;
    NSString *beginName;
}

-(id)initWithName:(NSString *)name beginName:(NSString *)beginName_;
{
    if (self = [super initWithTexture:AtlasNum(beginName_,0)]){
        cdName = name;
        beginName = beginName_;
        [self setScale:0.6];
    }
    return self;
}

-(void)changeCDBar:(void (^)())block;
{
    [self removeAllActions];
    self.isCding = YES;
    float codingTime = (_defaultAllTime-0.9)*0.01;
    SKAction *anime_0 = [SKAction animateWithTextures:Atlas(beginName) timePerFrame:0.042 resize:YES restore:NO];
    SKAction *anime_1 = [SKAction animateWithTextures:Atlas(cdName) timePerFrame:codingTime resize:YES restore:NO];
    SKAction *cdingAnime = [SKAction sequence:@[anime_0, anime_1]];
    [self runAction:cdingAnime completion:^{
        self.isCding = NO;
        if (block) {
            block();
        }
    }];
}

@end
