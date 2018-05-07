//
//  YodaLightBuff.m
//  DontEatMe
//
//  Created by ym on 15/1/27.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "YodaBuff.h"
#import "HPBar.h"

@implementation YodaBuff
{
    Body *body;
    
}
-(id)initWithBody:(Body *)aBody
{
    if (self = [super initWithBody:aBody]) {
        body = aBody;
    }
    return self;
}

-(void)beginBuff
{
    [super beginBuff];
    self.hidden = NO;
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"chicken_yoda_light") timePerFrame:oneKey resize:YES restore:NO];
    [self runAction:anime withKey:@"anime"];
    self.zPosition = 1;
    
    //持续时间
    SKAction *waitAttack = [SKAction waitForDuration:anime.duration/3];
    SKAction *waitAttackBlock = [SKAction runBlock:^{
        if (!body.hpBar) {
            [body addHpBar:CGPointMake(hpPosX, hpPosY) name:body.texString_hpBar];
        }
        body.nowHP -= self.hurt/3;
        [body.hpBar changeHPBar:body.nowHP];
    }];
    SKAction *seqAttack = [SKAction sequence:@[waitAttack, waitAttackBlock]];
    SKAction *repAttack = [SKAction repeatAction:seqAttack count:3];
    SKAction *comple = [SKAction runBlock:^{
        [body changeHP:1 attacker:nil];
        [self clearBuff];
    }];
    SKAction *seqComple = [SKAction sequence:@[repAttack, comple]];
    [self runAction:seqComple withKey:@"attack"];
    
    SKAction *sound = [SKAction playSoundFileNamed:@"Sound/yoda_laserSword_0.mp3" waitForCompletion:YES];
    [self runAction:sound];
}

-(void)clearBuff
{
    [super clearBuff];
    [self removeActionForKey:@"anime"];
    [self removeActionForKey:@"attack"];
    self.hidden = YES;
    
}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [super removeFromParent];
}

@end
