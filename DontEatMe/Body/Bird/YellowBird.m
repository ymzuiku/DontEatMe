//
//  YellowBird.m
//  DontEatMe
//
//  Created by pringlesfox on 8/20/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "YellowBird.h"

static SKAction *birdMove;

@implementation YellowBird
{
    float flyTime;
}

-(id)initWithNumber:(int)number
{
    if (self = [super initWithNumber:number]) {
        self.zPosition = 1999.95;
        self.position = CGPointMake(-250, self.position.y+240);
//        self.speed = 2;
        flyTime = 10;
        [self fly:[self flyPath]];
        [self layEgg];
    }
    return self;
}

-(SKAction *)flyPath
{
    SKAction *move = [SKAction moveByX:1000 y:0 duration:flyTime];
    return move;
}

-(void)fly:(SKAction *)flyPath
{
    SKAction *fly = [SKAction animateWithTextures:Atlas(@"ui_scene_anime_yellowBird") timePerFrame:oneKey resize:YES restore:NO];
    SKAction *repFly = [SKAction repeatActionForever:fly];
    SKAction *group = [SKAction group:@[repFly,flyPath]];
    [self runAction:group];
}

-(void)dealloc
{
    birdMove = nil;
}

-(void)layEgg
{
    SKAction *wait = [SKAction waitForDuration:flyTime/skRand(1.5, 10)];
    SKAction *wait2 = [SKAction waitForDuration:flyTime/skRand(1.5, 10)];
    SKAction *wait3 = [SKAction waitForDuration:flyTime/skRand(1.5, 10)];
    SKAction *block = [SKAction runBlock:^{
        ViewController *vc = [ViewController single];
        [vc.gameScene downObject:@"gold.1" pos:CGPointMake(self.position.x+20, self.position.y-120)];
    }];
    [self runAction:[SKAction sequence:@[wait, block]]];
    [self runAction:[SKAction sequence:@[wait2, block]]];
    [self runAction:[SKAction sequence:@[wait3, block]]];
}

@end
