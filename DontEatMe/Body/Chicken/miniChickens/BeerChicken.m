//
//  BeerChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "BeerChicken.h"

@implementation BeerChicken
{
    int beAttackNumber;
    int deflutBeAttackNumber;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_beer_move")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"beer";
    self.texString_attack = @"chicken_beer_attack";
    self.texString_move = @"chicken_beer_move";
    self.texString_move_B  = @"chicken_beer_fastMove";
    self.texString_rest = @"chicken_beer_move";
	self.fastPace = -60;
    self.attack = 200;
    deflutBeAttackNumber = 2;
    beAttackNumber = deflutBeAttackNumber;
    self.soundAction_attackA = self.soundAction_normalAttack;
    self.soundAction_skillA = [SKAction playSoundFileNamed:@"Sound/chicken_say_7.mp3" waitForCompletion:YES];
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    if (beAttackNumber > 0) {
        beAttackNumber -= 1;
    }else {
        beAttackNumber = deflutBeAttackNumber;
        [self fastMove];
    }
    return [super changeHP:hurt attacker:attacker];
}

-(void)fastMove
{
    if ([self changCanStatusRun:s_fastMove] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_fastMove,s_move];
    
    SKAction *fastMove_animatione = [SKAction animateWithTextures:Atlas(self.texString_move_B) timePerFrame:oneKey/self.speedMove resize:YES restore:NO];
    SKAction *fastMove_action = [SKAction moveByX:0 y:self.fastPace duration:(47/2-6)*oneKey*0.6/self.speedMove];
    SKAction *fastMove_group = [SKAction group:@[fastMove_animatione,fastMove_action]];
    [self runAction:[SKAction repeatActionForever:fastMove_group] withKey:s_fastMove];
}

@end
