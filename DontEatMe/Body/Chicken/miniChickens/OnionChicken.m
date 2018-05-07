//
//  OnionChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "OnionChicken.h"

@implementation OnionChicken

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_onion_move")[0]]) {
        
    }
    return self;
}


-(void)createInit
{
    [super createInit];
    [self sitDefaultHP:self.defaultHP*1.5];
    self.pace *= 1.4;
    self.myName = @"onion";
    self.texString_attack = @"chicken_onion_attack";
    self.texString_move = @"chicken_onion_move";
    self.texString_rest = @"chicken_onion_move";
    self.texString_drop = @"chicken_onion_dropDown";
    self.isSkillCDing = NO;
    self.haveNormalChicken_time = 1;
}

-(void)startup
{
    [super startup];
}

-(void)useSkill
{
    if (self.dizzyLoingBuff.isBuffing == YES) {
        return;
    }
    if (![self changCanStatusRun:s_skill]) {
        return;
    }
    self.isSkillCDing = YES;
    self.canNotChangeStatus = @[s_skill];
    int randomSay = skRand(0, 2);
    SKAction *soundSay;
    if (randomSay == 0) {
        soundSay = [SKAction playSoundFileNamed:@"Sound/chicken_say_5.mp3" waitForCompletion:0];
    }
    else if (randomSay == 1) {
        soundSay = [SKAction playSoundFileNamed:@"Sound/chicken_say_6.mp3" waitForCompletion:0];
    }
    else if (randomSay == 2) {
        soundSay = [SKAction playSoundFileNamed:@"Sound/chicken_say_7.mp3" waitForCompletion:0];
    }
    
    SKSpriteNode *sayNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"chicken_buff_say")[0]];
    sayNode.position = CGPointMake(50, 90);
    [self addChild:sayNode];
    
    SKAction *sayAction = [SK_Actions actionAnime:Atlas(@"chicken_buff_say") repeat:1];
    [sayNode runAction:sayAction completion:^{
        [sayNode removeFromParent];
    }];
    [self runAction:soundSay withKey:@"soundSay"];
    
    ViewController *vc = [ViewController single];
    SKAction *speedFastAction = [SKAction runBlock:^{
        for (Chicken *chicken in vc.gameScene.war.chickens.children) {
            if (chicken.isStartup == 1) {
                [chicken beBuff_Amok:10 * iSpeed speed:1.4];
            }
        }
    }];
    [self runAction:speedFastAction];
}

//-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
//{
//    if (self.nowHP < self.defaultHP*0.8 && self.isSkillCDing != YES) {              //useSkill在两处启动。
//        [self useSkill];
//        return [super changeHP:hurt attacker:attacker];
//    }else{
//        return [super changeHP:hurt attacker:attacker];
//    }
//}

@end
