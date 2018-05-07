//
//  FreeHighEnergy.m
//  DontEatMe
//
//  Created by ym on 14/11/27.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "FreeHighEnergy.h"

@implementation FreeHighEnergy
{
    AVAudioPlayer *winnerSound;
    SK_Button *shareAButton;
    SK_Button *shareBButton;
    SK_Button *closeButton;
    NSString *jellyName;
    NSString *jellyTpye;
    SKSpriteNode *background;
    SKVideoNode *video;
    SK_Button *playMovieButton;
    void (^myBlock)();
}

-(id)initWithString:(NSString *)string block:(void (^)())block;
{
    if (self = [super initWithColor:rgb(0x000000, iGrayFloat) size:CGSizeMake(iw, ih)]) {
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        [self loadData:string];
        [self createScene];
        [self touchEvent];
        [self moveUpFadeIn:background];
        myBlock = block;
    }
    return self;
}

-(void)removeFromParent
{
    [winnerSound stop]; winnerSound = nil;
    [video pause];
    [video removeFromParent];
    [self removeAllActions];
    [self removeAllChildren];
    [super removeFromParent];
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
    video.position = CGPointMake(-5, 56);
    [video setScale:0.84];
    [background addChild:video];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [video play];
    
    SKSpriteNode *videoMaskNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_free")[24]];
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
    background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_free")[0]];
    background.zPosition = self.zPosition +1;
    background.position = CGPointMake(iw/2, ih/2-60);
    [self addChild:background];
    [self createVideo];
    
    int line = iSEnglish ? 12 : 6;
    SK_Label *title = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:line size:34 color:rgb(0xa4a60d, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    title.text = iString(@"newHighEnergy");
    title.position = CGPointMake(0, 280);
    [background addChild:title];
    title.zPosition = 2;
    
    int shareAInt;
    int shareBInt;
    if ([iString(@"language") isEqualToString:@"Chinese"]) {
        shareAInt = 25;
        shareBInt = 26;
    }
    else {
        shareAInt = 27;
        shareBInt = 28;
    }
    
    shareAButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[shareAInt]];
    shareAButton.position = CGPointMake(-122, -198);
    shareAButton.zPosition = 2;
//    shareAButton.alpha = 0;
    [background addChild:shareAButton];
    
    shareBButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[shareBInt]];
    shareBButton.position = CGPointMake(122, -198);
    shareBButton.zPosition = 2;
//    shareBButton.alpha = 0;
    [background addChild:shareBButton];
    
    closeButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_lawn")[1]];
    closeButton.position = CGPointMake(-220, 310);
    [closeButton setScale:0.75];
    closeButton.zPosition = 2;
//    closeButton.alpha = 0;
    [background addChild:closeButton];
    
    ViewController *vc = [ViewController single];
    [vc.gameScene.buttonBar hiddenBar];
}

-(void)createPartique
{
    winnerSound = [SK_Sound createNewSound:@"Sound/ui_winGame_2.mp3" repeat:0];
    winnerSound.volume = 0.2;
    [winnerSound play];
    
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
    [closeButton event:^{
        if (myBlock) myBlock();
        [self removeFromParent];
    }];
    
    ViewController *vc = [ViewController single];
    [shareAButton event:^{
        if (iSChinese) {
//            [vc umShareToWechatTimeline_block:^{
//                [UserCenter addJelly:@"highEnergy"];
//                if (myBlock) myBlock();
//                [self removeFromParent];
//            }];
            
        }
        else {
//            [vc umShareToFacebook_block:^{
//                [UserCenter addJelly:@"highEnergy"];
//                if (myBlock) myBlock();
//                [self removeFromParent];
//            }];
        }
    }];
    
    [shareBButton event:^{
        if (iSChinese) {
//            [vc umShareToSina_block:^{
//                [UserCenter addJelly:@"highEnergy"];
//                if (myBlock) myBlock();
//                [self removeFromParent];
//            }];
        }
        else {
//            [vc umShareToTwitter_block:^{
//                [UserCenter addJelly:@"highEnergy"];
//                if (myBlock) myBlock();
//                [self removeFromParent];
//            }];
        }
    }];
}


-(void)shareCallBack
{
    
}

@end
