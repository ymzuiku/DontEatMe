//
//  BlueBird.m
//  DontEatMe
//
//  Created by pringlesfox on 8/20/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "BlueBird.h"
#import "GridArray.h"

@implementation BlueBird
{
    float flyTime;
    SKAction *birdMove;
    NSArray *gridArray;
}

-(id)init
{
    if (self = [super initWithNumber:0]) {
        gridArray = [GridArray getGridArray];
        self.position = CGPointMake(-640, self.position.y+240);
        self.zPosition = 1999.95;
        SKAction *fly = [SKAction animateWithTextures:Atlas(@"ui_scene_anime_blueBird") timePerFrame:oneKey resize:YES restore:NO];
        SKAction *repFly = [SKAction repeatActionForever:fly];
        [self runAction:repFly];
        flyTime = 3.2;
        birdMove = [SKAction moveByX:1100 y:0 duration:flyTime];
        [self setScale:0.85];
    }
    return self;
}

-(void)fly
{
    int soundRand = skRand(0, 7);
    NSString *soundString = [NSString stringWithFormat:@"Sound/bird_say_%d.mp3", soundRand];
    SKAction *sound = [SKAction playSoundFileNamed:soundString waitForCompletion:NO];
    SKAction *soundWait = [SKAction waitForDuration:1.5];
    SKAction *seqSound = [SKAction sequence:@[soundWait, sound]];
    [self runAction:seqSound];
    
    self.position = CGPointMake(-250, ih-skRand(150, 480));
    self.zPosition = 1999.1-self.position.y/2000;
    [self runAction:birdMove];
    [self layEgg];
}

-(void)flyOnes
{
    int soundRand = skRand(0, 7);
    NSString *soundString = [NSString stringWithFormat:@"Sound/bird_say_%d.mp3", soundRand];
    SKAction *sound = [SKAction playSoundFileNamed:soundString waitForCompletion:NO];
    SKAction *soundWait = [SKAction waitForDuration:1.5];
    SKAction *seqSound = [SKAction sequence:@[soundWait, sound]];
    [self runAction:seqSound];
    
    self.position = CGPointMake(-250, ih-skRand(150, 480));
    self.zPosition = 1999.1-self.position.y/2000;
    [self runAction:birdMove completion:^{
        [self useDie];
    }];
    [self layEgg];
}

-(void)layEgg
{
    SKAction *wait = [SKAction waitForDuration:flyTime/skRand(1.5, 2.5)];
    SKAction *block = [SKAction runBlock:^{
        ViewController *vc = [ViewController single];
        [vc.gameScene downObject:@"mana.5" pos:CGPointMake(self.position.x+50, self.position.y-120)];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq];
}


-(void)dealloc
{
    birdMove = nil;
}
@end
