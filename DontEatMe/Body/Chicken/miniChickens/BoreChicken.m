//
//  BoreChicken.m
//  DontEatMe
//
//  Created by ym on 15/5/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "BoreChicken.h"

@implementation BoreChicken
{
    BOOL isBoreMoveOnes;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_bore_move")[0]]) {
        
    }
    return self;
}


-(void)createInit
{
    [super createInit];
    self.myName = @"bore";
    self.texString_attack = @"chicken_bore_attack";
    self.texString_skill = @"chicken_bore_floorMove";
    self.texstring_skill_B = @"chicken_bore_jump";
    self.texString_move = @"chicken_bore_move";
    self.texString_rest = @"chicken_bore_move";
    [self sitDefaultHP:350];
    
    isBoreMoveOnes = NO;
}

-(void)startup
{
    [self addHpBar:CGPointMake(hpPosX, hpPosY) name:self.texString_hpBar];
    self.hpBar.hidden = YES;
    self.hidden = NO;
    self.isStartup = 1;
    [self useBoreMove];
}

-(void)useBoreMove
{
    if (isBoreMoveOnes == YES) {
        return;
    }
    isBoreMoveOnes = YES;
    self.isCanNotCoill = YES;
    SKAction *moveAnime = [SK_Actions actionAnime:Atlas(self.texString_skill) repeat:0];
    SKAction *move = [SKAction moveByX:0 y:-50 duration:0.6];
    int randomMove = skRand(6, 11);
    SKAction *repMove = [SKAction repeatAction:move count:randomMove];
    
    SKAction *jumpUp = [SK_Actions actionAnime:Atlas(self.texstring_skill_B) repeat:1];
    SKAction *block = [SKAction runBlock:^{
        self.texture = Atlas(self.texString_move)[0];
        [self removeActionForKey:@"boreMove"];
        self.isCanNotCoill = NO;
        [self useMove];
    }];
    
    [self runAction:moveAnime withKey:@"boreMove"];
    SKAction *moveSeq = [SKAction sequence:@[repMove, jumpUp, block]];
    [self runAction:moveSeq withKey:@"moveJump"];
}



@end
