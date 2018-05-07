//
//  BuffOfSpeed.m
//  DontEatMe
//
//  Created by ym on 15/1/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "Buff_speed.h"

@implementation Buff_speed
{
    Body *body;
}

-(id)initWithBody:(Body *)aBody
{
    if (self = [super initWithBody:aBody]) {
        body = aBody;
        self.zPosition = -1;
        self.changeColorTime = 0.2;
        [self createDifferent];
    }
    return self;
}

-(void)createDifferent
{
    
}

-(void)beginBuff
{
    if (body.dizzyLoingBuff.isBuffing || body.dizzyBuff.isBuffing || body.iceBuff.isBuffing) {
        return;
    }

    [super beginBuff];
    self.hidden = NO;
    if (self.animeCreateString) {
        if (![self actionForKey:@"anime"]) {
            SKAction *anime = [SKAction animateWithTextures:Atlas(self.animeCreateString) timePerFrame:oneKey resize:YES restore:NO];
            SKAction *animeRest = [SKAction animateWithTextures:Atlas(self.animeRestString) timePerFrame:oneKey resize:YES restore:NO];
            SKAction *repRest = [SKAction repeatActionForever:animeRest];
            SKAction *seq = [SKAction sequence:@[anime, repRest]];
            [self runAction:seq withKey:@"anime"];
            self.zPosition = 1;
            
            self.position = CGPointMake(0, 10);
            if ([body.myName isEqualToString:@"smart"]) {
                self.position = CGPointMake(0, 60);
            }
        }
    }
    else if (self.animeRestString) {
        if (![self actionForKey:@"anime"]) {
            SKAction *anime = [SKAction animateWithTextures:Atlas(self.animeRestString) timePerFrame:oneKey resize:YES restore:NO];
            SKAction *rep = [SKAction repeatActionForever:anime];
            [self runAction:rep withKey:@"anime"];
        }
    }
    
    if (self.time == 7) {
        [body runAction:[SK_Actions jump:1 timeRate:1]];
    }
    else if (self.time == 10) {
        [body runAction:[SK_Actions jump:1 timeRate:0.5]];
    }
    
    if (self.moveSpeed < 0.1) {
//        [body removeActionForKey:s_skill];
//        [body useMove];
        [body removeActionForKey:@"loadingSkill"];
    }
    
    
    //持续时间
    [self removeActionForKey:@"wait"];
    SKAction *wait = [SKAction waitForDuration:self.time];
    SKAction *block = [SKAction runBlock:^{
        [self clearBuff];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq withKey:@"wait"];
    
    //刷新speed
    [body reloadAllSpeed];
    
    //移动时减速
    [body actionForKey:s_move].speed = body.speedMove;
    [body actionForKey:s_attack].speed = body.speedAttack;
    [body actionForKey:s_skill].speed = body.speedSkill;
}

-(void)clearBuff
{
    [super clearBuff];
    self.hidden = YES;
    [self changeColorOutWithBody:body];
    [self removeActionForKey:@"anime"];
    
    //刷新speed
    self.attackSpeed = 1;
    self.moveSpeed = 1;
    self.skillSpeed = 1;
    [body reloadAllSpeed];
    [body reloadStartSkill];
    
    //移动时减速
    [body actionForKey:s_move].speed = body.speedMove;
    [body actionForKey:s_move].speed = body.speedAttack;
    [body actionForKey:s_skill].speed = body.speedSkill;
    [self removeActionForKey:@"wait"];
    
    if (![body.nowStatus isEqualToString:s_skill]) {
        [body removeActionForKey:s_move];
        body.canNotChangeStatus = @[s_attack];
        [body useMove];
    }
}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [super removeFromParent];
}



@end
