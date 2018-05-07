//
//  CureBuff.m
//  DontEatMe
//
//  Created by ym on 15/1/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CureBuff.h"

@implementation CureBuff
{
    Body *body;
}
-(id)initWithBody:(Body *)aBody
{
    if (self = [super initWithBody:aBody]) {
        body = aBody;
    }
    return self;
}

-(void)beginBuff
{
    [super beginBuff];
    self.hidden = NO;
    SKAction *anime;
    if (![self actionForKey:@"anime"]) {
        anime = [SKAction animateWithTextures:Atlas(@"jelly_cure_magicCreateDie") timePerFrame:oneKey resize:YES restore:NO];
        [self runAction:anime withKey:@"anime"];
        self.zPosition = 1;
    }
    
    //持续时间
    [self removeActionForKey:@"wait"];
    SKAction *wait = [SKAction waitForDuration:anime.duration];
    SKAction *block = [SKAction runBlock:^{
        [self clearBuff];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq withKey:@"wait"];
    
    [body changeHP:-(body.defaultHP * self.addHPRate) attacker:nil];
    
    SKAction *sound = [SKAction playSoundFileNamed:@"Sound/cure_attack_0.mp3" waitForCompletion:YES];
    [self runAction:sound];
}

-(void)clearBuff
{
    [super clearBuff];
    [self removeActionForKey:@"anime"];
    self.hidden = YES;
}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [super removeFromParent];
}

@end
