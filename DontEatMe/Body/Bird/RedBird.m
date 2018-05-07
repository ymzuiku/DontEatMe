//
//  RedBird.m
//  DontEatMe
//
//  Created by pringlesfox on 8/20/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "RedBird.h"

static SKAction *birdMove;

@implementation RedBird
{
    float flyTime;
}

-(id)initWithNumber:(int)number
{
    if (self = [super initWithNumber:number]) {
        self.zPosition = 1999.95;
        self.position = CGPointMake(-250, self.position.y+240);
        flyTime = 5;
        [self fly];
        [self layEgg];
        [self setScale:1.3];
    }
    return self;
}

-(void)fly
{
    if (birdMove == nil) {
        int soundRand = skRand(0, 7);
        NSString *soundString = [NSString stringWithFormat:@"Sound/bird_say_%d.mp3", soundRand];
        SKAction *sound = [SKAction playSoundFileNamed:soundString waitForCompletion:NO];
        SKAction *soundWait = [SKAction waitForDuration:1.5];
        SKAction *seqSound = [SKAction sequence:@[soundWait, sound]];
        [self runAction:seqSound];
        
        SKAction *move = [SKAction moveByX:1100 y:0 duration:flyTime];
        SKAction *fly = [SKAction animateWithTextures:Atlas(@"ui_scene_anime_redBird") timePerFrame:oneKey resize:YES restore:NO];
        SKAction *repFly = [SKAction repeatAction:fly count:5];
        birdMove = [SKAction group:@[repFly,move]];
    }
    [self runAction:birdMove completion:^{
        [self useDie];
    }];
}

-(void)layEgg
{
    SKAction *wait = [SKAction waitForDuration:flyTime/skRand(1.5, 2.5)];
    SKAction *block = [SKAction runBlock:^{
        ViewController *vc = [ViewController single];
        [vc.gameScene downObject:@"mana.100" pos:CGPointMake(self.position.x+50, self.position.y-120)];
    }];
    [self runAction:[SKAction sequence:@[wait, block]]];
}


-(void)dealloc
{
    birdMove = nil;
}
@end
