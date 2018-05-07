//
//  BoomBuff.m
//  DontEatMe
//
//  Created by ym on 15/1/26.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "BoomBuff.h"

@implementation BoomBuff
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
        anime = [SKAction animateWithTextures:Atlas(@"jelly_boom_die") timePerFrame:oneKey resize:YES restore:NO];
        [self runAction:anime withKey:@"anime"];
        self.zPosition = 1;
    }
    
    //持续时间
    [self removeActionForKey:@"wait"];
    SKAction *wait = [SKAction waitForDuration:anime.duration/2];
    SKAction *block = [SKAction runBlock:^{
        [body changeHP:self.hurt attacker:nil];
        [self clearBuff];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq withKey:@"wait"];
    
    [self changeColorIn:[UIColor redColor] blend:0.55 time:0.4 body:body];
    
    
    SKAction *move = [body actionForKey:s_move];
    move.speed = 0;
    
    SKAction *sound = [SKAction playSoundFileNamed:@"Sound/boom_attack_0.mp3" waitForCompletion:YES];
    [self runAction:sound];
}

-(void)clearBuff
{
    [super clearBuff];
    [self removeActionForKey:@"anime"];
    self.hidden = YES;
    [self changeColorOutWithBody:body];
    SKAction *move = [body actionForKey:s_move];
    move.speed = body.speedMove;
}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [self removeAllChildren];
    [super removeFromParent];
}


@end
