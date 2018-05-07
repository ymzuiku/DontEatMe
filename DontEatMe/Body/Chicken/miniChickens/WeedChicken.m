//
//  WeedChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "WeedChicken.h"

@implementation WeedChicken

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_weed_move")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    [self sitDefaultHP:self.defaultHP*5];
    self.myName = @"weed";
    self.texString_attack = @"chicken_weed_move";
    self.texString_move = @"chicken_weed_move";
    self.texString_rest = @"chicken_weed_rest";
    self.texString_drop = @"chicken_weed_dropDwon";
    
    self.soundAction_skillA = [SKAction playSoundFileNamed:@"Sound/weed_create.mp3" waitForCompletion:YES];
    self.soundAction_attackA = [SKAction playSoundFileNamed:@"Sound/weed_attack_0.mp3" waitForCompletion:YES];
    self.soundAction_attackB = self.soundAction_attackA;
    self.soundAction_weaponDown = [SKAction playSoundFileNamed:@"Sound/weed_die_0.mp3" waitForCompletion:YES];
    self.haveNormalChicken_time = 1;
    [self sitDefaultHP:self.defaultHP*2.5];
    self.attack = 800;
    self.speedMove *= 0.5;
}

-(void)useMove
{
    if (self.snailBuff.isBuffing == YES) {
        self.defAttackRect = CGRectMake(-57, 0, 114, -55*1);
    }else{
        self.defAttackRect = CGRectMake(-57, 0, 114, -75*1);
    }
    [super useMove];
}

//-(void)useAttack
//{
//    if (![self actionForKey:@"goBack"]) {
//        SKAction *goBack = [SKAction moveByX:0 y:10 duration:0.5];
//        SKAction *goBackBlock = [SKAction runBlock:^{
//            [super useAttack];
//        }];
//        SKAction *seq = [SKAction sequence:@[goBack,goBackBlock]];
//        [self runAction:seq withKey:@"goBack"];
//    }else{
//        return;
//    }
//}

@end
