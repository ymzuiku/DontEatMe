//
//  FreeGem.m
//  DontEatMe
//
//  Created by ym on 6/19/14.
//  Copyright (c) 2014 ym. All rights reserved.
//

#import "FreeGem.h"
#import "FreeHighEnergy.h"
#import "ShowAddCookGoldView.h"

@implementation FreeGem
{
    SK_Sound *winnerSound;
    SK_Sound *winnerSound1;
    SK_Button *nextButton;
    SK_Button *shareButton;
    SKSpriteNode *jelly;
    NSString *gemString;
    NSString *longString;
    SKSpriteNode *background;
    SKSpriteNode *gemImage;
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
    longString = string;
    NSArray *array = [string componentsSeparatedByString:@"."];
//    int num = [array[1] intValue];
    NSString *jellyName = array[1];
    NSString *gemAorB = array[2];
    NSDictionary *dic = [[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:jellyName];
    if ([gemAorB isEqualToString:@"A"]) {
        gemString = [dic objectForKey:@"gemA"];
//        [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:jellyName] setValue:@0 forKey:@"isGemA"];  //@0:已获得, @1:赠送
    }else if ([gemAorB isEqualToString:@"B"]) {
        gemString = [dic objectForKey:@"gemB"];
//        [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:jellyName] setValue:@0 forKey:@"isGemB"];
    }
    NSString *atlasName = [dic objectForKey:@"atlas"];
    
    jelly = [SKSpriteNode spriteNodeWithTexture:Atlas(atlasName)[0]];
    SKAction *action = [SKAction animateWithTextures:Atlas(atlasName) timePerFrame:oneKey];
    [jelly runAction:[SKAction repeatActionForever:action]];
    
    NSString *foodString = [dic objectForKey:@"type"];
    SKTexture *gemTexture;
    
    if ([foodString isEqualToString:@"banana"]) {
        gemTexture = Atlas(@"ui_games_free")[8];
    }
    else if ([foodString isEqualToString:@"boom"]) {
        gemTexture = Atlas(@"ui_games_free")[9];
    }
    else if ([foodString isEqualToString:@"shield"]) {
        gemTexture = Atlas(@"ui_games_free")[10];
    }
    else if ([foodString isEqualToString:@"ice"]) {
        gemTexture = Atlas(@"ui_games_free")[12];
    }
    else if ([foodString isEqualToString:@"energy"]) {
        gemTexture = Atlas(@"ui_games_free")[11];
    }
    
    gemImage = [SKSpriteNode spriteNodeWithTexture:gemTexture];
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
    background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_free")[23]];
    background.zPosition = 1;
    background.position = CGPointMake(iw/2, ih/2);
    [self addChild:background];
    
    jelly.position = CGPointMake(-210, -89);
    [background addChild:jelly];
    
    gemImage.position = CGPointMake(0, 140);
    [background addChild:gemImage];
    
    SK_Label *title = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:24 color:rgb(0xa4a60d, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    title.text = iString(@"newSkill");
    title.position = CGPointMake(0, 59);
    [background addChild:title];
    
    SK_Label *infoTitle = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:24 color:rgb(0xa4a60d, 0.7) horizontal:SKLabelHorizontalAlignmentModeLeft];
    infoTitle.text = iString(@"gemInfoTitle");
    infoTitle.position = CGPointMake(-107-12, -64+16);
    [background addChild:infoTitle];
    
    int lineNumber = iSEnglish ? 22 : 11;
    SK_Label *infoData = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:lineNumber size:28 color:rgb(0xa4a60d, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
    infoData.text = gemString;
    infoData.anchorPoint = CGPointMake(0, 1);
    infoData.position = CGPointMake(infoTitle.position.x, -105);
    [background addChild:infoData];
    
    nextButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[2]];
    nextButton.position = CGPointMake(0, -282);
    nextButton.zPosition = 2000;
    [background addChild:nextButton];
    
//    NSArray *haveJellys = [[UserCenter dic] objectForKey:@"haveJellys"];
//    if (haveJellys.count >= 8) {
//        
//        shareButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_free")[22]];
//        shareButton.position = CGPointMake(-113, -282);
//        [background addChild:shareButton];
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
        NSArray *array = [longString componentsSeparatedByString:@"."];
        NSString *jellyKey = array[1];
        NSString *gemAorB = [array[2] isEqualToString:@"A"]?@"isGemA":@"isGemB";
        NSString *gemAorBGold = [array[2] isEqualToString:@"A"]?@"gemANeedGold":@"gemBNeedGold";
        int gemNumber = [[[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:jellyKey] objectForKey:gemAorB] intValue];
        int gemNeedGold = [[[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:jellyKey] objectForKey:gemAorBGold] intValue];
        if (gemNumber == 0) {
            ShowAddCookGoldView *addGoldView = [ShowAddCookGoldView createWithIsGold:YES number:gemNeedGold backCall:^{
                [self removeFromParent];
                [vc.gameScene gotoMap:cc.startNumber];
            }];
            addGoldView.position = CGPointMake(iw/2, ih/2);
            [vc.gameScene.war addChild:addGoldView];
        }
        else {
            [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:jellyKey] setValue:@111 forKey:gemAorB];
            [UserCenter save];
            [self removeFromParent];
            [vc.gameScene gotoMap:cc.startNumber];
        }
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
    [jelly removeFromParent];
    [super removeFromParent];
}


@end
