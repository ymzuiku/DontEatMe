//
//  GuageBar.m
//  DontEatMe
//
//  Created by ym on 14/12/9.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "GuageBar.h"

@implementation GuageBar
{
    SKSpriteNode *guage;
    SKEmitterNode *partique;
}

-(id)init
{
    if (self = [super initWithColor:[UIColor clearColor] size:CGSizeMake(20, 20)]) {
        self.position = CGPointMake(iw-25, ih-435);
        self.zPosition = 1999;
    }
    return self;
}

-(void)beginGame:(float)allTime
{
    guage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_guageBar")[0]];
    guage.alpha = 0;
    SKAction *fadeIn = [SKAction fadeInWithDuration:1.5];
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_guageBar") timePerFrame:1.0/(100.0/allTime) resize:YES restore:NO];
    SKAction *seq = [SKAction sequence:@[fadeIn, anime]];
    [guage runAction:seq completion:^{
//        [self createPartique];
    }];
    guage.position = CGPointMake(0, 0);
    guage.zPosition = 0;
    [self addChild:guage];
}

-(void)createPartique
{
    partique = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Par_lastBo" ofType:@"sks"]];
    partique.zPosition = 1;
    partique.targetNode = self;
    partique.userInteractionEnabled = NO;
    partique.position = CGPointMake(10, -self.size.width/2-40);
    [self addChild:partique];
//    partique.particleLifetime = 0;
}



@end
