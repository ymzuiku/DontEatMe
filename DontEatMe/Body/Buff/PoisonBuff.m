//
//  PoisonBuff.m
//  DontEatMe
//
//  Created by ym on 15/1/20.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "PoisonBuff.h"

@implementation PoisonBuff
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
        SKAction *animeRest = [SKAction animateWithTextures:Atlas(@"chicken_buff_poison") timePerFrame:oneKey resize:YES restore:NO];
        SKAction *repRest = [SKAction repeatActionForever:animeRest];
        [self runAction:repRest withKey:@"anime"];
        self.zPosition = 1;
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
    [self removeActionForKey:@"attack"];  //防止伤害叠加
    SKAction *attackBlock = [SKAction runBlock:^{
        [body changeHP:self.hurt attacker:nil];
    }];
    SKAction *attackWait = [SKAction waitForDuration:1];
    SKAction *seqAttack = [SKAction sequence:@[attackWait, attackBlock]];
    SKAction *attackRep = [SKAction repeatActionForever:seqAttack];
    [self runAction:attackRep withKey:@"attack"];
    
    [self changeColorIn:[UIColor greenColor] blend:0.4 time:0.2 body:body];
}

-(void)clearBuff
{
    [super clearBuff];
    [self removeActionForKey:@"anime"];
    [self removeActionForKey:@"attack"];
    [self changeColorOutWithBody:body];
    self.hidden = YES;

}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [super removeFromParent];
}


@end
