//
//  StaveBuff.m
//  DontEatMe
//
//  Created by ym on 15/1/26.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "StaveBuff.h"

@implementation StaveBuff
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
    if (self.isBuffing) {
        return;
    }
    [super beginBuff];
    self.hidden = NO;
    //持续时间
    [self removeActionForKey:@"wait"];
    SKAction *wait = [SKAction waitForDuration:self.time];
    SKAction *block = [SKAction runBlock:^{
        [body changeHP:self.hurt attacker:nil];
        [self clearBuff];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq withKey:@"wait"];
    
    [self changeColorIn:[UIColor blackColor] blend:0.3 time:0.4 body:body];
    [body removeAllActions];
    
    body.yScale = 0.5;
}

-(void)clearBuff
{
    [super clearBuff];
    self.hidden = YES;
}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [super removeFromParent];
}
@end
