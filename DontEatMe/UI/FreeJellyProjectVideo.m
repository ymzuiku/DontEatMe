//
//  FreeJellyProjectVideo.m
//  DontEatMe
//
//  Created by ym on 14/11/26.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "FreeJellyProjectVideo.h"

@implementation FreeJellyProjectVideo
{
    SK_Button *nextButton;
    NSString *jellyName;
    NSString *jellyTpye;
    SKSpriteNode *background;
    SKVideoNode *video;
}

-(id)initWithNumber:(NSString *)jellyKey;
{
    if (self = [super initWithColor:rgb(0x000000, iGrayFloat) size:CGSizeMake(iw, ih)]) {
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        [self loadData:jellyKey];
        [self createScene];
        [self touchEvent];
        [self moveUpFadeIn:background];
    }
    return self;
}

-(void)loadData:(NSString *)jellyKey;
{
    NSDictionary *dic = [[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:jellyKey];
    jellyName = [dic objectForKey:@"name"];
    jellyTpye = [dic objectForKey:@"myName"];
}

-(void)createVideo
{
    NSString *videoString = [NSString stringWithFormat:@"%@_movie", jellyTpye];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:videoString ofType:@"mp4"]];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    video = [SKVideoNode videoNodeWithAVPlayer:player];
    video.position = CGPointMake(0, -32);
    [video setScale:0.84];
    [background addChild:video];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [video play];
    
    SKSpriteNode *videoMaskNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[12]];
    [background addChild:videoMaskNode];
}


- (void)runLoopTheMovie:(NSNotification *)noti
{
    AVPlayerItem *player = [noti object];
    [player seekToTime:kCMTimeZero]; //设置播放时间到0秒
    [video play];
}

-(void)createScene
{
    background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[11]];
    background.zPosition = self.zPosition +1;
    background.position = CGPointMake(iw/2, ih/2);
    [self addChild:background];
    [self createVideo];
    
    SK_Label *title = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:50 color:rgb(0xa4a60d, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    title.text = [NSString stringWithFormat:@"%@!", jellyName];
    title.position = CGPointMake(0, 190);
    [background addChild:title];
    
    nextButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[2]];
    nextButton.position = CGPointMake(0, -282);
    [background addChild:nextButton];
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
    [sprite runAction:group completion:^{
        SKAction *action0 = [self createAction:1];
        SKAction *action1 = [self createAction:1.2];
        SKAction *seq0 = [SKAction sequence:@[action0, action1]];
        [sprite runAction:[SKAction repeatActionForever:seq0]];
    }];
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



-(void)touchEvent
{
    [nextButton event:^{
        [self removeFromParent];
    }];
}

-(void)removeFromParent
{
    [video pause];
    [video removeFromParent];
    [self removeAllActions];
    [super removeFromParent];
}


@end
