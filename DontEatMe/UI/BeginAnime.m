//
//  BeginAnime.m
//  DontEatMe
//
//  Created by ym on 14-5-3.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "BeginAnime.h"

@implementation BeginAnime
{
    NSString *textString;
    SK_Label *label;
    BOOL isHidden;
}

-(id)init;
{
    if (self = [super initWithTexture:AtlasNum(@"ui_games_begin", 0)]) {
        self.position = CGPointMake(iw/2, ih/2+300);
        ViewController *vc = [ViewController single];
        textString = vc.gameScene.war.c_name;
        self.alpha = 0.85;
        isHidden = NO;
    }
    return self;
}

-(void)removeFromParent
{
    [self removeAllChildren];
    [super removeFromParent];
}

-(void)showtime
{
    NSArray *array = Atlas(@"ui_games_begin");
    float time = array.count*oneKey;
    label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:14 size:36 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    label.text = textString;
    label.position = CGPointMake(0, -4);
    label.alpha = 0;
    [label runAction:[SKAction fadeInWithDuration:time]];
    [self addChild:label];
    
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_begin") timePerFrame:oneKey];
    SKAction *animeBack = [anime reversedAction];
    SKAction *wati = [SKAction waitForDuration:1.5];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:time];
    SKAction *block = [SKAction runBlock:^{
        [label runAction:fadeOut];
        [self runAction:animeBack];
    }];
    SKAction *seq = [SKAction sequence:@[anime, wati, block]];
    [self runAction:seq completion:^{
        [self runAction:fadeOut completion:^{
            self.zPosition = 0; 
            [self removeFromParent];
        }];
    }];
}

-(void)close
{
    NSArray *array = Atlas(@"ui_games_begin");
    float time = array.count*oneKey;
    SKAction *fadeOut = [SKAction fadeOutWithDuration:time];
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_begin") timePerFrame:oneKey];
    SKAction *animeBack = [anime reversedAction];
    [label runAction:fadeOut];
    [self runAction:animeBack completion:^{
        [self removeFromParent];
    }];
}

-(void)show
{
    self.alpha = 0;
    SKAction *fadeIn = [SKAction fadeAlphaTo:0.85 duration:0.2];
    NSArray *array = Atlas(@"ui_games_begin");
    float time = array.count*oneKey;
    label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:14 size:36 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    label.text = textString;
    label.position = CGPointMake(0, -4);
    label.alpha = 0;
    [label runAction:[SKAction fadeInWithDuration:time]];
    [self addChild:label];
    
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_begin") timePerFrame:oneKey];
    SKAction *group = [SKAction group:@[anime, fadeIn]];
    [self runAction:group];
}

-(void)hidden
{
    if (isHidden) {
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.3];
        [self runAction:fadeIn];
        isHidden = NO;
    }
    else if (!isHidden) {
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.3];
        [self runAction:fadeOut];
        isHidden = YES;
    }
}


@end
