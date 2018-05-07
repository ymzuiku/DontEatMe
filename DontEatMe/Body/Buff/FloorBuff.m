//
//  FloorBuff.m
//  DontEatMe
//
//  Created by ym on 15/1/27.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "FloorBuff.h"
#import "Grid.h"
#import "Jelly.h"
@implementation FloorBuff
{
    Grid *theGrid;
    SKAction *createAnime;
}
-(id)initWithBody:(Body *)aBody
{
    if (self = [super initWithBody:aBody]) {
        Jelly* theBody = (Jelly *)aBody;
        theGrid = [GridArray getGridArray][theBody.gridNumber];
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
    if (![self actionForKey:@"anime"]) {
        createAnime = [SKAction animateWithTextures:Atlas(@"chicken_buff_floor_create") timePerFrame:oneKey resize:YES restore:NO];
        SKAction *animeRest = [SKAction animateWithTextures:Atlas(@"chicken_buff_floor_rest") timePerFrame:oneKey resize:YES restore:NO];
        SKAction *repRest = [SKAction repeatActionForever:animeRest];
        SKAction *seq = [SKAction sequence:@[createAnime, repRest]];
        [self runAction:seq withKey:@"anime"];
        self.zPosition = 1;
        self.position = CGPointMake(self.position.x, self.position.y+10);
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
        [theGrid.nodeInGrid changeHP:self.hurt attacker:nil];
    }];
    SKAction *attackWait = [SKAction waitForDuration:1];
    SKAction *seqAttack = [SKAction sequence:@[attackWait, attackBlock]];
    SKAction *attackRep = [SKAction repeatActionForever:seqAttack];
    [self runAction:attackRep withKey:@"attack"];
    
    SKAction *sound = [SKAction playSoundFileNamed:@"Sound/buff_floor_1.mp3" waitForCompletion:YES];
    [self runAction:sound];
}

-(void)clearBuff
{
    [super clearBuff];
    [self removeActionForKey:@"anime"];
    [self removeActionForKey:@"attack"];
    SKAction *animeRest = [createAnime reversedAction];
    [self runAction:animeRest completion:^{
        self.hidden = YES;
        theGrid = nil;
        [self removeFromParent];
    }];
}


//-(void)removeFromParent
//{
//    [self clearBuff];
//    theGrid = nil;
//    [super removeFromParent];
//}

@end