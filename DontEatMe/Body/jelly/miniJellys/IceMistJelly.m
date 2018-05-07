//
//  IceMistJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "IceMistJelly.h"

@implementation IceMistJelly
{
    SKNode *chickens;
    BOOL isAttacking;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_iceMist_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"iceMist";
    self.gemTexture = Atlas(@"ui_map_bigObj")[7];
    self.isNotAtlas_Static = YES;
    [self sitDefaultHP:6000];
    self.texString_rest = @"jelly_iceMist_rest";
    self.breakTexString = @"jelly_iceMist_breakRest";
    self.defAttackRect = CGRectMake(-20, 0, 40, 96*2-40);
    [self changeGem];
    
    chickens = [ViewController single].gameScene.war.chickens;
}

-(void)startup
{
    [super startup];
    if (self.isGemA == YES) {
        for (Chicken *chicken in chickens.children) {
            if (chicken.position.y < ih-5) {
                SKAction *sound = [SKAction playSoundFileNamed:@"Sound/ice_die_0.mp3" waitForCompletion:YES];
                [self runAction:sound];
                [chicken beBuff_ice:4 * iSpeed attackSpeed:0];
            }
        }
    }
}

-(void)useAttack
{
    if (isAttacking) {
        return;
    }
    isAttacking = YES;
    SKAction *block = [SKAction runBlock:^{
        for (Chicken *chicken in chickens.children) {
            if (CGRectIntersectsRect(self.attackRect, chicken.boxRect) && ![chicken.myName isEqualToString:@"shadow"]) {
                
                [chicken beBuff_slow:2 moveSpeed:0.6 attackSpeed:1];
                
                if (self.isGemB == YES) {
                    int theRandom = arc4random()%100-1;
                    if (theRandom < 20) {
                        [chicken beBuff_ice:3 * iSpeed attackSpeed:0];
                    }
                }
            }
        }
        isAttacking = NO;
    }];
    SKAction *wait = [SKAction waitForDuration:2];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq withKey:s_attack];
}

@end
