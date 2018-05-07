//
//  PickNode.m
//  DontEatMe
//
//  Created by ym on 15/1/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "PickNode.h"

@implementation PickNode

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"ui_games_hand")[0]]) {
        [self setScale:0.75];
        self.userInteractionEnabled = NO;
        self.anchorPoint = CGPointMake(0, 1);
        self.zPosition = 1999;
        self.alpha = 0;
        SKAction *wait1 = [SKAction waitForDuration:0.5];
        SKAction *wait2 = [SKAction waitForDuration:1.2];
        SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_hand") timePerFrame:0.042*0.8 resize:YES restore:NO];
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.3/2];
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.3/2];
        
        SKAction *seq = [SKAction sequence:@[wait1, fadeIn, anime, anime, fadeOut, wait2]];
        
        SKAction *waitSound_0 = [SKAction waitForDuration:0.5+anime.duration/2];
        SKAction *waitSound_1 = [SKAction waitForDuration:anime.duration];
        SKAction *block_0 = [SKAction runBlock:^{
            StaticActions *sa = [StaticActions single];
            [self runAction:sa.sound_pickTouch_0];
        }];
        
        SKAction *seq2 = [SKAction sequence:@[waitSound_0, block_0, waitSound_1, block_0]];
        SKAction *group = [SKAction group:@[seq, seq2]];
        [self runAction:[SKAction repeatActionForever:group]];
    }
    return self;
}

@end
