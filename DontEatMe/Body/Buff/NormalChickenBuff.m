//
//  NormalChickenBuff.m
//  DontEatMe
//
//  Created by ym on 15/1/26.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "NormalChickenBuff.h"
#import "Chicken.h"

@implementation NormalChickenBuff
{
    Chicken *body;
}
-(id)initWithBody:(Body *)aBody
{
    if (self = [super initWithBody:aBody]) {
        body = (Chicken *)aBody;
    }
    return self;
}

-(void)beginBuff
{
    if (body.snailBuff.isBuffing == YES) {
        return;
    }
    body.haveNormalChicken_time = 0;
    
    body.texString_move = @"chicken_normal_move";
    body.texString_attack = @"chicken_normal_attack";
    body.texString_rest = @"chicken_normal_move";
    
    StaticActions *sa = [StaticActions single];
    body.soundAction_attackA = sa.sound_chickenAttack0;
    body.soundAction_attackB = sa.sound_chickenAttack0;
    body.soundAction_changeHPA = sa.sound_normalChangeHP0;
    body.soundAction_changeHPB = sa.sound_normalChangeHP1;
    
    body.moveAction = nil;
    body.attackAction = nil;
    body.restAction = nil;
    body.attack = 100;
    
    [super beginBuff];
    self.hidden = NO;
    SKAction *anime;
    if (![self actionForKey:@"anime"]) {
//        [body useRest];
        body.haveNormalChicken_time = 0;
        body.canNotChangeStatus = @[];
        [body useMove];
        anime = [SKAction animateWithTextures:Atlas(body.texString_drop) timePerFrame:oneKey resize:YES restore:NO];
        SKAction *block = [SKAction runBlock:^{

        }];
        SKAction *seq = [SKAction sequence:@[anime, block]];
        [self runAction:seq withKey:@"anime"];
        self.zPosition = 1;
    }
    
    //持续时间
    [self removeActionForKey:@"wait"];
    SKAction *wait = [SKAction waitForDuration:anime.duration];
    SKAction *block = [SKAction runBlock:^{
        self.hidden = YES;
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq withKey:@"wait"];
}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [super removeFromParent];
}

@end
