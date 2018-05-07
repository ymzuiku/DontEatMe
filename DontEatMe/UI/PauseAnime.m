//
//  PauseAnime.m
//  DontEatMe
//
//  Created by ym on 14-5-3.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "PauseAnime.h"

@implementation PauseAnime
{
    SKSpriteNode *flag;
    SKSpriteNode *shadown;
}

-(id)init
{
    if (self = [super init]) {
        self.position = CGPointMake(0, ih/2+ih/8);
        self.anchorPoint = CGPointMake(0, 0.5);
        self.zPosition = 1999 - (self.position.y+60);
        [self createFlag];
    }
    return self;
}

-(void)createFlag
{
    shadown = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_other", 1)];
    shadown.anchorPoint = CGPointMake(0, 0.5);
    [self addChild:shadown];
    
    flag = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_other", 2)];
    flag.anchorPoint = CGPointMake(0, 0.5);
    [self addChild:flag];
    
    [self moveUpFadeIn:flag];
    [self moveUpFadeIn:shadown];
    [self moveFlag];
}

-(void)removeFromParent
{
    float defScale = flag.position.y;
    SKAction *move_0 = [SKAction moveTo:CGPointMake(self.position.x, defScale+20/1.5) duration:oneKey*1.5];
    SKAction *move_1 = [SKAction moveTo:CGPointMake(self.position.x, defScale-16/2) duration:oneKey*2];
    SKAction *move_2 = [SKAction moveTo:CGPointMake(self.position.x, defScale+7/1.5) duration:oneKey*2];
    SKAction *move_3 = [SKAction moveTo:CGPointMake(self.position.x, defScale) duration:oneKey*2.5];
    SKAction *seq = [SKAction sequence:@[move_3, move_2, move_1, move_0]];
    
    [flag runAction:seq completion:^{
        
        [flag removeFromParent];
        flag = nil;
        
        [shadown removeFromParent];
        shadown = nil;
        
        [self removeAllChildren];
        [super removeFromParent];
    }];
}

-(void)moveUpFadeIn:(SKSpriteNode *)sprite
{
    sprite.alpha = 0;
    float value = -0.3;
    SKAction *move_0 = [SKAction moveBy:CGVectorMake(0, -100*value) duration:0.01];
    SKAction *move_1 = [SKAction moveBy:CGVectorMake(0, 120*value) duration:0.3];
    SKAction *move_2 = [SKAction moveBy:CGVectorMake(0, -30*value) duration:0.3*1.2];
    SKAction *move_3 = [SKAction moveBy:CGVectorMake(0, 10*value) duration:0.3*1.6];
    SKAction *seq = [SKAction sequence:@[move_0, move_1, move_2, move_3]];
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.3*1.2];
    SKAction *group = [SKAction group:@[seq, fadeIn]];
    group.timingMode = SKActionTimingEaseInEaseOut;
    [sprite runAction:group];
}

-(void)moveFlag
{
    SKAction *action0 = [self createAction:1];
    SKAction *action1 = [self createAction:1.2];
    SKAction *action2 = [self createAction:1.4];
    SKAction *action3 = [self createAction:1.6];
    
    SKAction *seq0 = [SKAction sequence:@[action0, action1]];
    SKAction *seq1 = [SKAction sequence:@[action2, action3]];
    
    [flag runAction:[SKAction repeatActionForever:seq0]];
    [shadown runAction:[SKAction repeatActionForever:seq1]];
}

-(SKAction *)createAction:(float)value
{
    SKAction *wait = [SKAction waitForDuration:0.3/3*value];
    SKAction *roteUp = [SKAction rotateByAngle:iPI(-0.6) duration:0.3*3*value];
    SKAction *moveUp = [SKAction moveByX:0 y:10 duration:0.3*4*value];
    SKAction *roteDown = [SKAction rotateByAngle:iPI(0.6) duration:0.3*4*value];
    SKAction *moveDown = [SKAction moveByX:0 y:-10 duration:0.3*5*value];
    SKAction *seq = [SKAction sequence:@[wait, roteUp, moveUp, roteDown, moveDown]];
    seq.timingMode = SKActionTimingEaseInEaseOut;
    return seq;
}


@end
