//
//  RifleChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "RifleChicken.h"
#import "RifleBullet.h"

@implementation RifleChicken
{
    SKNode *games;
}
-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_rifle_move")[0]]) {
        
    }
    return self;
}

-(void)reloadRect
{
    self.attackRect = CGRectMake(self.position.x+self.defAttackRect.origin.x, self.position.y+self.defAttackRect.origin.y, self.defAttackRect.size.width, self.defAttackRect.size.height);
    self.boxRect = CGRectMake(self.position.x+self.defBoxRect.origin.x, self.position.y+self.defBoxRect.origin.y, self.defBoxRect.size.width, self.defBoxRect.size.height);
    if (self.position.y < ih-96 && self.snailBuff.isBuffing == 0) {
        self.defAttackRect = CGRectMake(-57, 0, 114, -97*7);
    }
}

-(void)createInit
{
    [super createInit];
    self.myName = @"rifle";
    self.texString_attack = @"chicken_rifle_attack";
    self.texString_move = @"chicken_rifle_move";
    self.texString_rest = @"chicken_rifle_rest";
    self.texString_drop = @"chicken_rifle_dropDown";
    
    self.soundAction_attackA = [SKAction playSoundFileNamed:@"Sound/rife_attack_0.mp3" waitForCompletion:YES];
    self.soundAction_attackB = [SKAction playSoundFileNamed:@"Sound/rife_attack_1.mp3" waitForCompletion:YES];
    [self sitDefaultHP:self.defaultHP*2.5];
    self.speedMove *= 0.8;
    if (!games) {
        ViewController *vc = [ViewController single];
        games = vc.gameScene.war.chickenBullets;
    }
    
}

-(void)useAttack
{
    if (self.attackBody.nowHP < self.attack) {
        if ([self.attackBody.myName isEqualToString:@"xiaowei"] && ((self.position.y - self.attackBody.position.y) < 140)) {
            
        }else{
             return;
        }
    }
    if ([self changCanStatusRun:s_attack] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_attack];
    [super useAttack];
    SKAction *attack_BeginBlock = [SKAction runBlock:^{
        
        CGPoint pos = CGPointMake(self.position.x, self.position.y-50);
        RifleBullet *bullet = [[RifleBullet alloc] initWithPosition:pos zPosition:self.zPosition];
        bullet.zPosition = 1999;
        bullet.damage = self.attack;
        [games addChild:bullet];
    }];
    SKAction *attack_Wait = [SKAction waitForDuration:Atlas(self.texString_attack).count*oneKey/self.speedAttack];
    SKAction *attack_Wait2 = [SKAction waitForDuration:2.0];
    SKAction *attack_StopAction = [SKAction runBlock:^{
        if (self.attackBody.nowHP < self.attack) {
            [super useMove];
        }
        self.canNotChangeStatus = @[];
    }];
    SKAction *attack_seq = [SKAction sequence:@[attack_Wait,attack_BeginBlock,attack_Wait2,attack_StopAction,]];
    [self runAction:attack_seq withKey:s_attack];
}
@end
