//
//  BindingBuff.m
//  DontEatMe
//
//  Created by ym on 15/1/20.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "BindingBuff.h"

@implementation BindingBuff
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
    if (![self actionForKey:@"anime"]) {
        SKAction *anime = [SKAction animateWithTextures:Atlas(@"jelly_slow_magicCreate") timePerFrame:oneKey resize:YES restore:NO];
        SKAction *animeRest = [SKAction animateWithTextures:Atlas(@"jelly_slow_magicRest") timePerFrame:oneKey resize:YES restore:NO];
        SKAction *repRest = [SKAction repeatActionForever:animeRest];
        SKAction *seq = [SKAction sequence:@[anime, repRest]];
        [self runAction:seq withKey:@"anime"];
        self.zPosition = 1;
        
        body.paceRate = 0;
        [body removeActionForKey:s_move];
        body.canNotChangeStatus = @[s_fastMove];
        body.moveAction = nil;
        [body useMove];
    }
    
    //持续时间
    [self removeActionForKey:@"wait"];
    SKAction *wait = [SKAction waitForDuration:self.time];
    SKAction *block = [SKAction runBlock:^{
        [self clearBuff];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq withKey:@"wait"];
    
    
    //每秒伤害
    [self removeActionForKey:@"attack"];
    SKAction *attackBlock = [SKAction runBlock:^{
        [body changeHP:10 attacker:nil];
    }];
    SKAction *attackWait = [SKAction waitForDuration:1];
    SKAction *seqAttack = [SKAction sequence:@[attackWait, attackBlock]];
    SKAction *attackRep = [SKAction repeatAction:seqAttack count:20];
    [self runAction:attackRep withKey:@"attack"];
}

-(void)clearBuff
{
    [super clearBuff];
    SKAction *animeDie = [SKAction animateWithTextures:Atlas(@"jelly_slow_magicDie") timePerFrame:oneKey resize:YES restore:NO];
    [self runAction:animeDie completion:^{
        self.hidden = YES;
//        [self removeFromParent];
    }];
    
    [body removeActionForKey:s_move];
    body.canNotChangeStatus = @[];
    body.moveAction = nil;
    body.paceRate = 1;
    [body useMove];
    [self removeActionForKey:@"anime"];
    [self removeActionForKey:@"attack"];
}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [self removeAllChildren];
    [super removeFromParent];
}


@end
