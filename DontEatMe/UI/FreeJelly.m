//
//  FreeJelly.m
//  DontEatMe
//
//  Created by ym on 6/20/14.
//  Copyright (c) 2014 ym. All rights reserved.
//

#import "FreeJelly.h"
#import "FreeHighEnergy.h"
#import "ShowAddCookGoldView.h"

@implementation FreeJelly
{
    AVAudioPlayer *winnerSound;
    AVAudioPlayer *winnerSound1;
    SK_Button *nextButton;
    SK_Button *shareButton;
    SK_Button *playMovieButton;
    NSString *jellyName;
    NSString *jellyTpye;
    SKSpriteNode *background;
    SKVideoNode *video;
}

-(void)removeFromParent
{
    [nextButton removeFromParent];
    nextButton = nil;
    
    [shareButton removeFromParent];
    shareButton = nil;
    
    [playMovieButton removeFromParent];
    playMovieButton = nil;
    
    [background removeAllChildren];
    [background removeFromParent];
    background = nil;
    
    [winnerSound stop]; winnerSound = nil;
    [winnerSound1 stop]; winnerSound1 = nil;
    [video pause];
    [video removeFromParent];
    video = nil;
    
    ViewController *vc = [ViewController single];
    ClassCenter *cc = [ClassCenter singleton];
    [vc.gameScene gotoMap:cc.startNumber];
    [self removeAllActions];
    [super removeFromParent];
}


-(id)initWith:(NSString *)string;
{
    if (self = [super initWithColor:rgb(0x000000, iGrayFloat) size:CGSizeMake(iw, ih)]) {
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        [self loadData:string];
        [self createScene];
        [self touchEvent];
        [self moveUpFadeIn:background];
        [self createStartAnime];
    }
    return self;
}

-(void)loadData:(NSString *)string;
{
    NSArray *array = [string componentsSeparatedByString:@"."];
//    int num = [array[1] intValue];
    NSDictionary *dic = [[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:array[1]];
    jellyName = [dic objectForKey:@"name"];
    jellyTpye = [dic objectForKey:@"myName"];
}

-(void)createStartAnime
{
    SKSpriteNode *startImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_free")[32]];
    startImage.position = CGPointMake(0, 309);
    [background addChild:startImage];
    
    SKAction *boomStart = [SKAction animateWithTextures:Atlas(@"jelly_xiaowei_startBoom") timePerFrame:0.030 resize:YES restore:NO];
    
    ClassCenter *cc = [ClassCenter singleton];
    if (cc.startNumber > 0) {
        SKAction *wait = [SKAction waitForDuration:0.50];
        SKAction *block1 = [SKAction runBlock:^{
            SKSpriteNode *startAimaeNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"jelly_xiaowei_startBoom")[0]];
            [startAimaeNode setScale:2];
            [background addChild:startAimaeNode];
            startAimaeNode.position = CGPointMake(-113, 309);
            startAimaeNode.zRotation = iPI(-30);
            [startAimaeNode runAction:boomStart];
            startImage.texture = Atlas(@"ui_games_free")[33];
            SKAction *sound_start1 = [SKAction playSoundFileNamed:@"Sound/star_1s.mp3" waitForCompletion:NO];
            [startImage runAction:sound_start1];
        }];
        SKAction *block2 = [SKAction runBlock:^{
            SKSpriteNode *startAimaeNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"jelly_xiaowei_startBoom")[0]];
            [startAimaeNode setScale:2];
            [background addChild:startAimaeNode];
            startAimaeNode.position = CGPointMake(0, 320);
            startAimaeNode.zRotation = iPI(0);
            [startAimaeNode runAction:boomStart];
            startImage.texture = Atlas(@"ui_games_free")[34];
            SKAction *sound_start1 = [SKAction playSoundFileNamed:@"Sound/star_2s.mp3" waitForCompletion:NO];
            [startImage runAction:sound_start1];
        }];
        SKAction *block3 = [SKAction runBlock:^{
            SKSpriteNode *startAimaeNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"jelly_xiaowei_startBoom")[0]];
            [startAimaeNode setScale:2];
            [background addChild:startAimaeNode];
            startAimaeNode.position = CGPointMake(113, 309);
            startAimaeNode.zRotation = iPI(30);
            [startAimaeNode runAction:boomStart];
            startImage.texture = Atlas(@"ui_games_free")[35];
            SKAction *sound_start1 = [SKAction playSoundFileNamed:@"Sound/star_3s.mp3" waitForCompletion:NO];
            [startImage runAction:sound_start1];
        }];
        
        if (cc.startNumber == 3) {
            SKAction *seq = [SKAction sequence:@[wait, wait, block1, wait, block2, wait, block3]];
            [startImage runAction:seq completion:^{
                [self createPartique];
            }];
        }
        else if (cc.startNumber == 2) {
            SKAction *seq = [SKAction sequence:@[wait, wait, block1, wait, block2]];
            [startImage runAction:seq];
        }
        else if (cc.startNumber == 1) {
            SKAction *seq = [SKAction sequence:@[wait, wait, block1]];
            [startImage runAction:seq];
        }
    }
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
    video.zPosition = 0;
    [video setScale:0.84];
    [background addChild:video];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [video play];
    
    SKSpriteNode *videoMaskNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_free")[21]];
    [background addChild:videoMaskNode];
    videoMaskNode.zPosition = 1;
    
//    playMovieButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[31]];
//    playMovieButton.position = CGPointMake(0, -20);
//    [videoMaskNode addChild:playMovieButton];
    [video pause];
    [video play];
//    [playMovieButton event:^{
//        [video play];
//        playMovieButton.alpha = 0;
//        SKAction *wait = [SKAction waitForDuration:2.4];
//        SKAction *fadeIn = [SKAction fadeInWithDuration:0.6];
//        
//        [self runAction:wait completion:^{
//            [nextButton runAction:fadeIn];
//            if (shareButton) {
//                [shareButton runAction:fadeIn];
//            }
//        }];
//    }];
}

- (void)runLoopTheMovie:(NSNotification *)noti
{
    AVPlayerItem *player = [noti object];
    [player seekToTime:kCMTimeZero]; //设置播放时间到0秒
    [video play];
}

-(void)createScene
{
    background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_free")[1]];
    background.zPosition = self.zPosition +1;
    background.position = CGPointMake(iw/2, ih/2);
    [self addChild:background];

    SK_Label *title = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:44 color:rgb(0xa4a60d, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    title.text = [NSString stringWithFormat:@"%@%@!", iString(@"new:"), jellyName];
    title.position = CGPointMake(0, 190);
    [background addChild:title];
    title.zPosition = 2;
    
    nextButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[2]];
    nextButton.position = CGPointMake(0, -282);
    [background addChild:nextButton];
//    nextButton.alpha = 0;
    nextButton.zPosition = 2000;
    
//    NSArray *haveJellys = [[UserCenter dic] objectForKey:@"haveJellys"];
//    if (haveJellys.count >= 8) {
//        shareButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[22]];
//        shareButton.position = CGPointMake(-113, -282);
//        [background addChild:shareButton];
//        shareButton.alpha = 0;
//        shareButton.zPosition = 2;
//        nextButton.position = CGPointMake(115, -282);
//    }
    
    ViewController *vc = [ViewController single];
    [vc.gameScene.buttonBar hiddenBar];
    
    winnerSound = [SK_Sound createNewSound:@"Sound/ui_winGame_2.mp3" repeat:0];
    winnerSound.volume = 0.2;
    [winnerSound play];
    
    winnerSound1 = [SK_Sound createNewSound:@"Sound/ui_winGame_1.mp3" repeat:0];
    winnerSound1.volume = 0.2;
    [winnerSound1 play];
    
    [self createVideo];
}

-(void)createPartique
{
    SKEmitterNode *startPartique = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Par_starRain" ofType:@"sks"]];
    startPartique.zPosition = self.zPosition-1;
    startPartique.targetNode = self;
    [self addChild:startPartique];
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
        [sprite runAction:[SKAction repeatActionForever:seq0] completion:^{
            sprite.alpha = 1;
        }];
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
        [UserCenter addJelly:jellyTpye];
        [self removeFromParent];
    }];
    
//    ViewController *vc = [ViewController single];
//    [shareButton event:^{
////        [vc umShare_block:^{
////            ShowAddCookGoldView *addGoldView = [ShowAddCookGoldView createWithIsGold:YES number:(int)skRand(1, 5) backCall:nil];
////            addGoldView.position = CGPointMake(iw/2, ih/2);
////            [vc.gameScene addChild:addGoldView];
////        }];
//    }];
}


@end
