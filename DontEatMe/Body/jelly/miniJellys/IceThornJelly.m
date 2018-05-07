//
//  IceThornJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "IceThornJelly.h"

@implementation IceThornJelly
{
    SKSpriteNode *blockNode;
    SKNode *chickens;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_iceThron_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"iceThorn";
    self.gemTexture = Atlas(@"ui_map_bigObj")[7];
    self.texString_rest = @"jelly_iceThron_rest";
    self.breakTexString = @"jelly_iceThron_breakRest";
    [self sitDefaultHP:6000];
    [self changeGem];
    
    if (self.isGemA == YES) {
        blockNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"chicken_buff_block")[0]];
        blockNode.position = CGPointMake(30, 20);
        blockNode.hidden = YES;
        [self addChild:blockNode];
    }
    if (self.isGemB == YES) {
        ViewController *vc = [ViewController single];
        chickens = vc.gameScene.war.chickens;
        self.defAttackRect = CGRectMake(-20, 0, 40, 96*1.5);
    }
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    if (attacker) {
        [attacker changeHP:5 attacker:self];
    }
    if (self.isGemA == YES) {
        int theRandom = arc4random()%100-1;
        if (theRandom < 30) {
            [self blockAnime];
            return NO;
        }
    }
    return [super changeHP:hurt attacker:attacker];
}

-(void)useDie
{
    if ([self changCanStatusRun:s_die] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_die];
    self.nowStatus = s_die;
    if (self.isGemB == YES) {
        SKAction *move = [SKAction moveByX:0 y:96*1.3 duration:0.25];
        move.timingMode = SKActionTimingEaseOut;
        SKAction *dieIce = [SKAction runBlock:^{
            for (Chicken *chicken in chickens.children) {
                if (CGRectIntersectsRect(self.attackRect, chicken.boxRect)) {
                    [chicken changeHP:300 attacker:self];
                }
            }
            [super useDie];
        }];
        SKAction *iceMove = [SKAction sequence:@[move, dieIce]];
        [self runAction:iceMove withKey:s_die];
    }
    else {
        [super useDie];
    }
}

-(void)blockAnime
{
    blockNode.hidden = NO;
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"chicken_buff_block") timePerFrame:oneKey resize:YES restore:NO];
    [blockNode runAction:anime completion:^{
        blockNode.hidden = YES;
    }];
}

-(void)useSkill
{
    


}
@end
