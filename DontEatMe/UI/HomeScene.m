//
//  HomeScene.m
//  DontEatMe
//
//  Created by ym on 14/9/5.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "HomeScene.h"
#import "AboutUs.h"

@implementation HomeScene
{
    SK_BackgroundSound *music_BG;
    SK_Button *playButton;
    SK_Button *leftButton;
    SK_Button *optionButton;
    SK_Button *logoButton;
    SKSpriteNode *bar;
}

-(void)removeFromParent
{
    [playButton removeAllChildren];
    [playButton removeFromParent];
    playButton = nil;
    
    [leftButton removeAllChildren];
    [leftButton removeFromParent];
    leftButton = nil;
    
    [optionButton removeAllChildren];
    [optionButton removeFromParent];
    optionButton = nil;
    
    [logoButton removeAllChildren];
    [logoButton removeFromParent];
    logoButton = nil;
    
    [bar removeAllChildren];
    [bar removeFromParent];
    bar = nil;

    [self removeAllActions];
    [self removeAllChildren];
    [super removeFromParent];
}

-(void)didMoveToView:(SKView *)view
{
    ClassCenter *cc = [ClassCenter singleton];
    cc.sceneNumber = 0;
    self.scaleMode = SKSceneScaleModeAspectFit;
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_main_scenes", 0)];
    background.anchorPoint = CGPointMake(0, 0);
    background.position = CGPointMake(0, 0);
    [self addChild:background];
    
    music_BG = [SK_BackgroundSound singleton];
    if (![music_BG.musicName isEqualToString:music_map]) {
        [music_BG stopSound];
        
        if (!music_BG.playing) {
            [music_BG createSound:music_home repeat:-1];
        }
        if (cc.isCanPlayMusic == YES && !music_BG.playing) {
            [music_BG playSound];
        }
    }
    
    [self createJellys];
    [self createOther];
    [self buttonsEvent];
    
    ViewController *vc = [ViewController single];
    vc.isInTheScene = NO;
}

-(void)createJellys
{
    SKSpriteNode *chickens = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_main_anime", 0)];
    chickens.position = cciPhone5Pos(iw/2+43, ih/2-120,
                                     iw/2+43, ih/2-80);
    chickens.speed = 0.7;
    SKAction *anime = [SK_Actions actionAnime:Atlas(@"ui_main_anime") repeat:-1];
    [chickens runAction:[SKAction repeatAction:anime count:10]];
    [self addChild:chickens];
}

-(void)createOther
{
    StaticActions *sa = [StaticActions single];
    SKSpriteNode *clouds = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_main_scenes", 1)];
    [clouds setScale:1.01];
    clouds.position = CGPointMake(0, 0);
    clouds.anchorPoint = CGPointMake(0, 0);
    [self addChild:clouds];
    
    SKSpriteNode *downRound = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_main_round", 0)];
    downRound.position = CGPointMake(0, 0);
    downRound.anchorPoint = CGPointMake(0, 0);
    [self addChild:downRound];
    
    SKSpriteNode *upRound = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_main_round", 1)];
    upRound.position = CGPointMake(0, ih);
    upRound.anchorPoint = CGPointMake(0, 1);
    [self addChild:upRound];
    
    logoButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_main_scenes", 2)];
    logoButton.userInteractionEnabled = NO;
    [logoButton setScale:0.95];
    logoButton.position = cciPhone5Pos(iw/2, ih/2+350,
                                       iw/2, ih/2+300);
    
    [self addChild:logoButton];
    
    bar = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_main_button", 0)];
    bar.position = cciPhone5Pos(iw/2, 60,
                                iw/2, 50);
    [self addChild:bar];
    
    playButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_main_button", 1)];
    playButton.position = CGPointMake(10, 40);
    [playButton runAction:sa.actionWait];
    [bar addChild:playButton];
    
    
    leftButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_main_button", 5)];
    leftButton.position = CGPointMake(-224, 40);
    [leftButton setScale:1.1];
    [bar addChild:leftButton];
    if ([[[UserCenter dic] objectForKey:@"music"] boolValue] == NO) {
        leftButton.texture = Atlas(@"ui_main_button")[9];
    }
    else {
        leftButton.texture = Atlas(@"ui_main_button")[5];
    }
    
    optionButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_main_button", 7)];
    optionButton.position = CGPointMake(224, 40);
    [optionButton setScale:0.9];
    [bar addChild:optionButton];
}

-(void)moveBar
{
    if (!_isBottomMove) {
        SKAction *move = [SKAction moveByX:0 y:-300 duration:0.3];
        move.timingMode = SKActionTimingEaseInEaseOut;
        [bar runAction:move];
        _isBottomMove = YES;
    }
    else {
        SKAction *move = [SKAction moveByX:0 y:300 duration:0.3];
        move.timingMode = SKActionTimingEaseInEaseOut;
        [bar runAction:move];
        _isBottomMove = NO;
    }
}

-(void)buttonsEvent
{
    ViewController *vc = [ViewController single];
    StaticActions *sa = [StaticActions single];
    [logoButton playSound:sa.sound_buttonA];
    [logoButton event:^{
        [vc gotoMapScene:9];
        [self removeFromParent];
    }];
    
    [playButton playSound:sa.sound_buttonA];
    [playButton event:^{
        [vc gotoMapScene:9];
//        [self removeFromParent];
    }];
    ClassCenter *cc = [ClassCenter singleton];
    [leftButton playSound:sa.sound_buttonA];
    [leftButton event:^{
        if ([[[UserCenter dic] objectForKey:@"music"] boolValue] == YES) {
            [music_BG pauseSound];
            [[UserCenter dic] setValue:@NO forKey:@"music"];
            cc.isCanPlayMusic = NO;
            leftButton.texture = Atlas(@"ui_main_button")[9];
        }
        else {
            [music_BG playSound];
            [[UserCenter dic] setValue:@YES forKey:@"music"];
            cc.isCanPlayMusic = YES;
            leftButton.texture = Atlas(@"ui_main_button")[5];
        }
    }];
    
    [optionButton playSound:sa.sound_buttonA];
    [optionButton event:^{
        AboutUs *about = [[AboutUs alloc] init];
        [self addChild:about];
        [self moveBar];
    }];
}


@end
