//
//  MiniChickenFlay.m
//  DontEatMe
//
//  Created by ym on 15/5/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "MiniChickenFlay.h"
#import "MiniChicken.h"

@implementation MiniChickenFlay


-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_miniChicken_fly")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"miniFly";
    self.texString_attack = @"chicken_miniChicken_fly";
    self.texString_move = @"chicken_miniChicken_fly";
    self.texString_rest = @"chicken_miniChicken_fly";
    self.isCanNotCoill = YES;
    self.speedMove *= 1.2;
}

-(void)useMove
{
    ViewController *vc = [ViewController single];
    if (![self changCanStatusRun:s_move]) {
        return;
    }
    self.canNotChangeStatus = @[s_move];
    if (!self.moveAction) {
        SKAction *move = [SKAction moveByX:0 y:-2700 duration:10];
        move.timingMode = SKActionTimingEaseIn;
        
        float randomTime[] = {skRand(1.5, 2), skRand(0.1, 0.35), skRand(0.1, 0.35), skRand(0.1, 0.35), skRand(0.1, 0.35),
                    skRand(0.1, 0.25), skRand(0.1, 0.25)};
        
        SKAction *wait0 = [SKAction waitForDuration:randomTime[0]];
        SKAction *wait1 = [SKAction waitForDuration:randomTime[1]];
        SKAction *wait2 = [SKAction waitForDuration:randomTime[2]];
        SKAction *wait3 = [SKAction waitForDuration:randomTime[3]];
        SKAction *wait4 = [SKAction waitForDuration:randomTime[4]];
        SKAction *wait5 = [SKAction waitForDuration:randomTime[5]];
        SKAction *wait6 = [SKAction waitForDuration:randomTime[6]];
        
        SKAction *downChicken = [SKAction runBlock:^{
            if (self.position.y > ih - 600) {
                MiniChicken *mini = [[MiniChicken alloc] init];
                mini.position = self.position;
                [mini resetZPostion];
                [mini flyDown];
                [vc.gameScene.war.chickens addChild:mini];
            }
        }];
        SKAction *downSeq = [SKAction sequence:@[wait0, downChicken, wait1, downChicken, wait2, downChicken, wait3, downChicken, wait4, downChicken, wait5, downChicken, wait6, downChicken,]];
        self.moveAction = [SKAction group:@[downSeq, move]];
    }
    [self runAction:self.moveAction withKey:s_move];
}

-(void)resetZPostion
{
    self.zPosition = 1999.5;
    if (self.position.y < 0) {
        [self useDie];
    }
}


@end
