//
//  ShieldBuff.m
//  DontEatMe
//
//  Created by ym on 15/1/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "ShieldBuff.h"

@implementation ShieldBuff
{
    Body *body;
    float defFullHP;
    BOOL isClearing;
}
-(id)initWithBody:(Body *)aBody
{
    if (self = [super initWithBody:aBody]) {
        body = aBody;
        self.shieldHP = -1;
    }
    return self;
}

-(void)beginBuff
{
    [super beginBuff];
    self.hidden = NO;
    if (![self actionForKey:@"anime"]) {
        SKAction *anime = [SKAction animateWithTextures:Atlas(@"jelly_shield_magicCreate") timePerFrame:oneKey resize:YES restore:NO];
        SKAction *animeRest = [SKAction animateWithTextures:Atlas(@"jelly_shield_magicRest") timePerFrame:oneKey resize:YES restore:NO];
        SKAction *repRest = [SKAction repeatActionForever:animeRest];
        SKAction *seq = [SKAction sequence:@[anime, repRest]];
        [self runAction:seq withKey:@"anime"];
        self.zPosition = 1;
    }
    
    //持续时间
    [self removeActionForKey:@"wait"];
    SKAction *wait = [SKAction waitForDuration:self.time];
    SKAction *block = [SKAction runBlock:^{
        [self clearBuffNotAnime];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq withKey:@"wait"];
    
    defFullHP = self.shieldHP;
    self.alpha = 1;
    
    if (self.noDieTime > 0) {
        SKAction *noDie = [SKAction waitForDuration:self.noDieTime];
        SKAction *noDieBlock = [SKAction runBlock:^{
            self.noDieTime = 0;
            SKAction *changeColorBack = [SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:0 duration:1];
            [self runAction:changeColorBack];
        }];
        SKAction *noDieSeq = [SKAction sequence:@[noDie, noDieBlock]];
        [self runAction:noDieSeq];

        SKAction *changeColor = [SKAction colorizeWithColor:[UIColor yellowColor] colorBlendFactor:0.5 duration:1];
        [self runAction:changeColor];
    }
    
    SKAction *sound = [SKAction playSoundFileNamed:@"Sound/shield_attack_0.mp3" waitForCompletion:YES];
    [self runAction:sound];
}

-(void)clearBuff
{
    [super clearBuff];
    [self removeActionForKey:@"anime"];
    
    isClearing = YES;
    self.alpha = 1;
    SKAction *animeRest = [SKAction animateWithTextures:Atlas(@"jelly_shield_magicDie") timePerFrame:oneKey resize:YES restore:NO];
    [self runAction:animeRest completion:^{
        self.hidden = YES;
        self.shieldHP = -1;
        isClearing = NO;
    }];
}

-(void)shieldChangeHP:(int)hurt
{
    if (self.noDieTime > 0) {
        hurt = 0;
    }
    self.shieldHP -= hurt;
    self.alpha = (self.shieldHP / defFullHP)+0.4 > 1 ? 1: (self.shieldHP / defFullHP)+0.4;
    
    if (self.shieldHP <= 0 && !isClearing) {
        SKAction *sound = [SKAction playSoundFileNamed:@"Sound/shield_magic_die_0.mp3" waitForCompletion:YES];
        [self runAction:sound];
        self.shieldHP = 0;
        [self clearBuff];
    }
}

-(void)clearBuffNotAnime
{
    [super clearBuff];
    [self removeActionForKey:@"anime"];
    self.hidden = YES;
    self.shieldHP = -1;
}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [super removeFromParent];
}

@end
