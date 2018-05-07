//
//  FreeMap.m
//  DontEatMe
//
//  Created by ymMac on 14-8-10.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "FreeMap.h"
#import "FreeHighEnergy.h"
#import "ShowAddCookGoldView.h"

@implementation FreeMap
{
    AVAudioPlayer *winnerSound;
    AVAudioPlayer *winnerSound1;
    SK_Button *nextButton;
    SK_Button *shareButton;
    SKSpriteNode *background;
    int mapNumber;
}

-(id)initWithNumber:(int)number;
{
    if (self = [super initWithColor:rgb(0x000000, iGrayFloat) size:CGSizeMake(iw, ih)]) {
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);

        mapNumber = number;
        [self createScene];
        [self touchEvent];
        [self moveUpFadeIn:background];
        [self createStartAnime];

    }
    return self;
}

-(void)loadData:(int)number;
{
    
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


-(void)createScene
{
    background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_free")[1]];
    background.zPosition = self.zPosition +1;
    background.position = CGPointMake(iw/2, ih/2);
    [self addChild:background];
    
    SKSpriteNode *mapImage = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"ui_map_miniLand_%d.png", mapNumber]];
    mapImage.position = CGPointMake(0, -106+46);
    [background addChild:mapImage];
    
    
    SK_Label *title = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:48 color:rgb(0xa4a60d, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    title.text = iString(@"newMap");
    title.position = CGPointMake(0, 118+46);
    [background addChild:title];
    
    int lineNumber;
    if ([iString(@"language") isEqualToString:@"Chinese"]) {
        lineNumber = 11;
    }else {
        lineNumber = 22;
    }
    
    nextButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[2]];
    nextButton.position = CGPointMake(0, -282);
    [background addChild:nextButton];
    
//    NSArray *haveJellys = [[UserCenter dic] objectForKey:@"haveJellys"];
//    if (haveJellys.count >= 8) {
//        shareButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[22]];
//        shareButton.position = CGPointMake(-113, -282);
//        [background addChild:shareButton];
//        
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
        SKAction *action0 = [self createAction:1.0];
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
    ViewController *vc = [ViewController single];
    ClassCenter *cc = [ClassCenter singleton];
    [nextButton event:^{
        [UserCenter addLand];
        [self removeFromParent];
        [vc.gameScene gotoMap:cc.startNumber];
    }];
    
    [shareButton event:^{
//        [vc umShare_block:^{
//            ShowAddCookGoldView *addGoldView = [ShowAddCookGoldView createWithIsGold:YES number:(int)skRand(1, 5) backCall:nil];
//            addGoldView.position = CGPointMake(iw/2, ih/2);
//            [vc.gameScene addChild:addGoldView];
//        }];
    }];
}

-(void)removeFromParent
{
    [winnerSound stop]; winnerSound = nil;
    [winnerSound1 stop]; winnerSound1 = nil;
    [self removeAllActions];
    [super removeFromParent];
}



@end
