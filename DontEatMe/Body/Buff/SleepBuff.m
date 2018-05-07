//
//  SleepBuff.m
//  DontEatMe
//
//  Created by ym on 15/1/20.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "SleepBuff.h"
#import "EnergyJelly.h"

@implementation SleepBuff
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
    self.skillSpeed = 0;
    if (![self actionForKey:@"anime"]) {
        SKAction *animeRest = [SKAction animateWithTextures:Atlas(@"chicken_buff_sleep") timePerFrame:oneKey resize:YES restore:NO];
        SKAction *repRest = [SKAction repeatActionForever:animeRest];
        [self runAction:repRest withKey:@"anime"];
        self.zPosition = 1;
        
        body.paceRate = 0;
        [body removeActionForKey:s_move];
        body.canNotChangeStatus = @[];
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
    
    
    //能量果冻不产生能量
    [body reloadAllSpeed];
    if ([body.myName isEqualToString:@"energy"] || [body.myName isEqualToString:@"highEnergy"]) {
        EnergyJelly *energy = (EnergyJelly *)body;
        energy.mana.speed = 0;
    }
    else {
        [body actionForKey:s_skill].speed = body.speedSkill;
    }
    
}

-(void)clearBuff
{
    [super clearBuff];
    [self removeActionForKey:@"anime"];
    self.hidden = YES;
    
    //能量果冻继续产生能量
    body.paceRate = 1;
    self.skillSpeed = 1;
    [body reloadAllSpeed];
    if ([body.myName isEqualToString:@"energy"] || [body.myName isEqualToString:@"highEnergy"]) {
        EnergyJelly *energy = (EnergyJelly *)body;
        energy.mana.speed = 1;
    }
    else {
        [body actionForKey:s_skill].speed = body.speedSkill;
    }
}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [super removeFromParent];
}


@end
