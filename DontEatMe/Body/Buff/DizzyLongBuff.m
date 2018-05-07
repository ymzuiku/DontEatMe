//
//  DizzyLongBuff.m
//  DontEatMe
//
//  Created by ym　 on 15/2/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "DizzyLongBuff.h"

@implementation DizzyLongBuff
{
    Body *body;
}

-(id)initWithBody:(Body *)aBody
{
    if (self = [super initWithBody:aBody]) {
        body = aBody;
        self.zPosition = -1;
    }
    return self;
}

-(void)beginBuff
{
    if (![body changCanStatusRun:s_buff]) {
        return;
    }
    
    body.canNotChangeStatus = @[s_skill,s_attack];
    [super beginBuff];
    self.hidden = NO;
    if (![self actionForKey:@"anime"]) {
        SKAction *create = [SKAction animateWithTextures:Atlas(@"jelly_dizzy_magicCreate") timePerFrame:oneKey*1.5 resize:YES restore:NO];
        SKAction *rest = [SKAction animateWithTextures:Atlas(@"jelly_dizzy_magicRest") timePerFrame:oneKey resize:YES restore:NO];
        SKAction *rep = [SKAction repeatActionForever:rest];
        SKAction *seq = [SKAction sequence:@[create, rep]];
        [self runAction:seq withKey:@"anime"];
        self.zPosition = 1;
    }
    
    [body runAction:[SK_Actions jump:1 timeRate:1]];
    [body removeActionForKey:body.nowStatus];
    body.canNotChangeStatus = @[];
    [body useRest];
    
    
    if ([body.nowStatus isEqualToString:s_skill]) {
        [body removeActionForKey:s_skill];
        [body useMove];
    }
    [body removeActionForKey:@"loadingSkill"];
    
    //持续时间
    [self removeActionForKey:@"wait"];
    SKAction *wait = [SKAction waitForDuration:self.time];
    SKAction *block = [SKAction runBlock:^{
        [self clearBuff];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq withKey:@"wait"];
    
    SKAction *sound = [SKAction playSoundFileNamed:@"Sound/dizzy_attack_0.mp3" waitForCompletion:YES];
    [self runAction:sound];
}

-(void)clearBuff
{
    [super clearBuff];
    self.hidden = YES;
    [self removeActionForKey:@"anime"];
    [body reloadAllSpeed];
    [body reloadStartSkill];
    body.canNotChangeStatus = @[];
    [body useMove];
}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [self removeAllChildren];
    [super removeFromParent];
}


@end
