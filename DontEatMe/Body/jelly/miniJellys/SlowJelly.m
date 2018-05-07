//
//  SlowJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "SlowJelly.h"
#import "BindingBuff.h"

@implementation SlowJelly
{
    SKNode *chickens;
    float speedMove;
    BOOL isAttacking;
}

-(void)removeFromParent
{
    chickens = nil;
    [super removeFromParent];
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_slow_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    
    self.myName = @"slow";
    self.gemTexture = Atlas(@"ui_map_bigObj")[4];
    self.texString_attack = @"jelly_slow_attack";
    self.texString_rest = @"jelly_slow_rest";
    self.defBoxRect = CGRectMake(9999, 9999, -1, -1);
    self.defAttackRect = CGRectMake(-57, -120, 114, 240);
    speedMove = 0.6;
    [self changeGem];
    
    if (self.isGemA == YES) {
        speedMove = 0.4;
    }
    ViewController *vc = [ViewController single];
    chickens = vc.gameScene.war.chickens;
    self.zPositionAdjust = -60;
}

-(void)useAttack
{
    if (isAttacking) {
        return;
    }
    isAttacking = YES;
    
    SKAction *block = [SKAction runBlock:^{
        for (Chicken *chicken in chickens.children) {
            if (CGRectIntersectsRect(self.attackRect, chicken.boxRect)) {
                [chicken beBuff_slow:2 moveSpeed:speedMove attackSpeed:1];
                if (self.isGemB == YES) {
                    int theRandom = arc4random()%100-1;
                    if (theRandom < 10 && chicken.bindingBuff.isBuffing == NO) {
                        SKAction *anime = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey resize:YES restore:NO];
                        SKAction *rest = [SKAction animateWithTextures:Atlas(self.texString_rest) timePerFrame:oneKey resize:YES restore:NO];
                        SKAction *seq = [SKAction sequence:@[anime, rest]];
                        [self runAction:seq];
                        [chicken beBuff_binding:3 attack:5];
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
