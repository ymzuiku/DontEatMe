//
//  WelcomScene.m
//  DontEatMe
//
//  Created by ym on 14/9/5.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "WelcomScene.h"
#import "AtlasController.h"

@implementation WelcomScene
{
    SKSpriteNode *water;
    SKVideoNode *video;
    SK_Sound *soundWelcome;
}

-(void)removeFromParent
{
    [water removeFromParent];
    water = nil;
    
    [video removeFromParent];
    video = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}

-(void)didMoveToView:(SKView *)view
{
    self.scaleMode = SKSceneScaleModeAspectFit;
    self.anchorPoint = CGPointMake(0, 0);
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"LaunchImage.png"];
    background.position = CGPointMake(iw/2, ih/2);
    background.zPosition = 1;
    [self addChild:background];
    
    ClassCenter *cc = [ClassCenter singleton];
    cc.isCanPlayMusic = [[[UserCenter dic] objectForKey:@"music"] boolValue];
    
    StaticActions *sa = [StaticActions single];
    AtlasController *ac = [AtlasController single];
    [ac loadAtlas:[sa preload_home] completion:^{
//        [sa loadAtlas:^{
//            
//        }];
        
        [self createVideo];
        soundWelcome = [SK_Sound createNewSound:music_welcome repeat:0];
        [soundWelcome play];
    }];
}

-(void)createVideo
{
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"loadingPage" ofType:@"mov"]];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    video = [SKVideoNode videoNodeWithAVPlayer:player];
    video.position = CGPointMake(iw/2, ih/2);
    video.zPosition = 0;
    [self addChild:video];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [video play];
    SKAction *wait = [SKAction waitForDuration:0.5];
    [self runAction:wait completion:^{
        video.zPosition = 2;
    }];
}

- (void)runLoopTheMovie:(NSNotification *)noti
{
    [video pause];
    [video removeFromParent];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeAllActions];
    ViewController *vc = [ViewController single];
    [vc firstGotoHomeScene];
}


@end
