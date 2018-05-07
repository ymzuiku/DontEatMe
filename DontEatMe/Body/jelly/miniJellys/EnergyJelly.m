//
//  EnergyJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "EnergyJelly.h"

@implementation EnergyJelly
{
    NSString *str_bodyRest2;
    GameScene *gameScene;
    int theRandom;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_energy_reat")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"energy";
    self.gemTexture = Atlas(@"ui_map_bigObj")[5];
    self.texString_rest = @"jelly_energy_reat";
    self.isNotAtlas_Static = YES;
    self.downManaNumb = @"mana.2";
    str_bodyRest2 = @"jelly_energy_reat2";
    gameScene = [ViewController single].gameScene;
    [self changeGem];
    
    _mana = [SKSpriteNode spriteNodeWithTexture:Atlas(@"jelly_energy_water_0")[0]];
    [self addChild:_mana];
    
    if (self.isGemA == YES) {
        self.isCallBackMana = 2;
    }
    [self sitDefaultHP:self.defaultHP*2];
    
    [self useSkill];
}

-(void)useAttack{}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    BOOL tempReturn;
    tempReturn = [super changeHP:hurt attacker:attacker];
    NSLog(@"%@.HP=%d",self.myName,self.nowHP);
    return tempReturn;
}

-(void)useSkill
{
    if ([self changCanStatusRun:s_skill] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_skill];
    if (!self.skillAction) {
        SKAction *water_0 = [SKAction animateWithTextures:Atlas(@"jelly_energy_water_0") timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
        SKAction *water_1 = [SKAction animateWithTextures:Atlas(@"jelly_energy_water_1") timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
        SKAction *water_2 = [SKAction animateWithTextures:Atlas(@"jelly_energy_water_2") timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
        SKAction *water_3 = [SKAction animateWithTextures:Atlas(@"jelly_energy_water_3") timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
        SKAction *water_4 = [SKAction animateWithTextures:Atlas(@"jelly_energy_water_4") timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
        SKAction *water_5 = [SKAction animateWithTextures:Atlas(@"jelly_energy_water_5") timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
        SKAction *rest_0 = [SKAction animateWithTextures:Atlas(@"jelly_energy_waterRest_0") timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
        SKAction *rest_1 = [SKAction animateWithTextures:Atlas(@"jelly_energy_waterRest_1") timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
        SKAction *rest_2 = [SKAction animateWithTextures:Atlas(@"jelly_energy_waterRest_2") timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
        SKAction *rest_3 = [SKAction animateWithTextures:Atlas(@"jelly_energy_waterRest_3") timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
        SKAction *rest_4 = [SKAction animateWithTextures:Atlas(@"jelly_energy_waterRest_4") timePerFrame:oneKey*self.speedSkill resize:YES restore:NO];
        SKAction *seq_0 = [SKAction sequence:@[water_0, rest_0, rest_0, rest_0, rest_0]];
        SKAction *seq_1 = [SKAction sequence:@[water_1, rest_1, rest_1, rest_1, rest_1,rest_1]];
        SKAction *seq_2 = [SKAction sequence:@[water_2, rest_2, rest_2, rest_2, rest_2,rest_2]];
        SKAction *seq_3 = [SKAction sequence:@[water_3, rest_3, rest_3, rest_3, rest_3,rest_3]];
        SKAction *seq_4 = [SKAction sequence:@[water_4, rest_4, rest_4, rest_4, rest_4,rest_4]];
        SKAction *block = [SKAction runBlock:^{
            [gameScene downObject:self.downManaNumb pos:self.position];
            if (self.isGemB) {
                theRandom = arc4random()%100-1;
                if (theRandom < 20) {
                    SKAction *wait = [SKAction waitForDuration:0.2];
                    [self runAction:wait completion:^{
                        [gameScene downObject:@"mana.2" pos:CGPointMake(self.position.x+7, self.position.y-5)];
                    }];
                }
            }
        }];
        SKAction *seqEnd = [SKAction sequence:@[seq_0, seq_1, seq_2, seq_3, seq_4, water_5, block]];
        self.skillAction = [SKAction repeatActionForever:seqEnd];
    }
    [_mana runAction:self.skillAction withKey:s_skill];
}



@end
