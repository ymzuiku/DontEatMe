//
//  ChickenRemote.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "ChickenRemote.h"

@implementation ChickenRemote

//-(void)startup
//{
//    [self useMove];
//}

-(void)useMove
{
    if (![self changCanStatusRun:s_move]) {
        return;
    }
    self.canNotChangeStatus = @[s_move];
    
    if (!self.moveAction) {
        SKAction *move_Animation = [SKAction animateWithTextures:Atlas(self.texString_move) timePerFrame:oneKey*0.6/self.speedMove resize:YES restore:NO];
        SKAction *move_Action = [SKAction moveByX:0 y:self.pace duration:(47/2-6)*oneKey*0.6/self.speedMove];
        SKAction *move_Wait = [SKAction waitForDuration:oneKey*0.6*12/self.speedMove];
        SKAction *move_Seq = [SKAction sequence:@[move_Action, move_Wait, move_Action]];  //必须让anima的总时间和sequence的总时间相等
        SKAction *move = [SKAction group:@[move_Animation, move_Seq]];
        self.moveAction = [SKAction repeatActionForever:move];
    }
    [self runAction:self.moveAction withKey:s_move];
}

-(void)useAttack
{
    SKAction *attack_Animation = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
    [self runAction:attack_Animation];
}

@end
