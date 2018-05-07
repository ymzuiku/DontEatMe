//
//  StromJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "StromJelly.h"
#import "CDBar.h"

@implementation StromJelly
{
    SKNode *chickens;
    int reptNumber;
    BOOL isCanChangeHP;
    SKSpriteNode *magicNode;
    Grid *grid;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_strom_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    
    self.myName = @"strom";
    self.gemTexture = Atlas(@"ui_map_bigObj")[3];
    self.texString_attack = @"jelly_strom_attack";
    self.texString_rest = @"jelly_strom_rest";
    [self changeGem];
    [self sitDefaultHP:2500];
    
    reptNumber = 8;
    isCanChangeHP = YES;
    self.attack = 5;
    
    if (self.isGemA == YES) {
        reptNumber *= 1.5;
    }
    if (self.isGemB == YES) {
        [self sitDefaultHP:5000];
    }
    self.defAttackRect = CGRectMake(-174,-164+10, 342, 93*3);
    
    ViewController *vc = [ViewController single];
    chickens = vc.gameScene.war.chickens;
    
    self.skillCD = 12;
    [self addCDBar:CGPointMake(0, -30) name:@"jelly_cd_timing" beginName:@"jelly_cd_beging"];
    
    magicNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"jelly_strom_particle")[0]];
    [self addChild:magicNode];
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"jelly_strom_particle") timePerFrame:oneKey/3 resize:YES restore:NO];
    [magicNode runAction:[SKAction repeatActionForever:anime]];
    magicNode.alpha = 0;
}

-(void)startup
{
    [super startup];
    grid = [GridArray getGridArray][self.gridNumber];
    grid.hasNode = 4;
}

-(void)useAttack{}

-(void)useSkill
{
    if (![self changCanStatusRun:s_skill]) {
        return;
    }
    self.canNotChangeStatus = @[s_skill];
    grid.hasNode = 1;
    SKAction *anime1 = [SKAction animateWithTextures:Atlas(@"jelly_strom_attackStar") timePerFrame:oneKey resize:YES restore:NO];
    SKAction *anime2_mini = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey resize:YES restore:NO];
    SKAction *anime2_attack = [SKAction runBlock:^{
        for (Chicken *chicken in chickens.children) {
            if (CGRectIntersectsRect(self.attackRect, chicken.boxRect)) {
                [chicken changeHP:self.attack attacker:self];
            }
        }
    }];
    SKAction *anime2_group = [SKAction sequence:@[anime2_mini, anime2_attack,anime2_attack,anime2_attack,anime2_attack,anime2_attack]];
    SKAction *anime2 = [SKAction repeatAction:anime2_group count:reptNumber];
    SKAction *anime3 = [anime1 reversedAction];
    SKAction *anime4 = [SKAction runBlock:^{
        isCanChangeHP = YES;
        [self waitSkill];
    }];
    SKAction *animeAll = [SKAction sequence:@[anime1, anime2, anime3, anime4]];

    [self runAction:animeAll withKey:s_skill];
    
    SKAction *magicWait1 = [SKAction waitForDuration:anime1.duration];
    SKAction *magicWait2 = [SKAction waitForDuration:anime2.duration];
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.3];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.3];
    SKAction *sound = [SKAction playSoundFileNamed:@"Sound/Stron.mp3" waitForCompletion:YES];
    [self runAction:sound];
    SKAction *seqMagicNode = [SKAction sequence:@[magicWait1, fadeIn, magicWait2, fadeOut]];
    [magicNode runAction:seqMagicNode withKey:@""];
}

-(void)waitSkill
{
    SKAction *cdStart = [SKAction animateWithTextures:Atlas(@"jelly_strom_CDStar") timePerFrame:oneKey resize:YES restore:NO];
    SKAction *cding = [SKAction animateWithTextures:Atlas(@"jelly_strom_CDing") timePerFrame:oneKey resize:YES restore:NO];
    SKAction *cdEnd = [cdStart reversedAction];
    SKAction *cding_repeat = [SKAction repeatActionForever:cding];
    SKAction *seq = [SKAction sequence:@[cdStart, cding_repeat]];
    [self runAction:seq withKey:@"cding"];
    [self.cdBar changeCDBar:^{
        self.canNotChangeStatus = @[];
        [self removeActionForKey:@"cding"];
        [self runAction:cdEnd completion:^{
            grid.hasNode = 4;
            [self useRest];
        }];
    }];
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker;
{
    if (isCanChangeHP == NO) {
        hurt = 1;
    }
    return [super changeHP:hurt attacker:attacker];
}


-(void)removeFromParent
{
    chickens = nil;
    [super removeFromParent];
}



@end
