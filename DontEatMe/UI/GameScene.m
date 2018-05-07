//
//  GameScene.m
//  DontEatMe
//
//  Created by ym on 14/9/5.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "CreateJelly.h"
#import "GameScene.h"
#import "DownSomeBody.h"
#import "QuitAlert.h"
#import "PauseAnime.h"
#import "LosterAnime.h"
#import "FreeGem.h"
#import "FreeJelly.h"
#import "FreeJellyPro.h"
#import "FreeGold.h"
#import "FreeMap.h"
#import "FreeHighEnergy.h"
#import "FreeWhistle.h"
#import "GridArray.h"

@implementation GameScene
{
    PauseAnime *pauseAnime;
    LosterAnime *loster;
    SKAction *soundPause;
    SKAction *soundGoon;
    int isLosting;
    int lowUpdate;
    BOOL isFirstWinner;
    ClassCenter *cc;
}

-(void)removeFromParent
{
    [_background removeAllChildren];
    [_background removeFromParent];
    _background = nil;
    
    [_war removeAllChildren];
    [_war removeFromParent];
    _war = nil;
    
    [_touchLayer removeAllChildren];
    [_touchLayer removeFromParent];
    _touchLayer = nil;
    
    [_selectJellys removeAllChildren];
    [_selectJellys removeFromParent];
    _selectJellys = nil;
    
    [_topBar removeAllChildren];
    [_topBar removeFromParent];;
    _topBar = nil;
    
    [_buttonBar removeAllChildren];
    [_buttonBar removeFromParent];
    _buttonBar = nil;
    
    [_beginAnime removeAllChildren];
    [_beginAnime removeFromParent];
    _beginAnime = nil;
    
    [_rootView removeAllChildren];
    [_rootView removeFromParent];
    _rootView = nil;
    
    [pauseAnime removeAllChildren];
    [pauseAnime removeFromParent];
    pauseAnime = nil;
    
    [loster removeAllChildren];
    [loster removeFromParent];
    loster = nil;
    
    [_music_BG pauseSound];
    soundPause = nil;
    soundGoon = nil;
    _war_Controller = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}


+(id)createWithNumber:(int)number;
{
    return [[GameScene alloc] initWithNumber:number];
}

-(id)initWithNumber:(int)number
{
    if (self = [super initWithSize:CGSizeMake(iw, ih)]) {
        self.scaleMode = SKSceneScaleModeAspectFit;
        self.userInteractionEnabled = YES;
        _classNumber = number;
        [self clearStaticWar];
        [self newCCData];
        soundPause = [SKAction playSoundFileNamed:@"Sound/ui_stopWar2.mp3" waitForCompletion:0];
        soundGoon = [SKAction playSoundFileNamed:@"Sound/ui_stopWar.mp3" waitForCompletion:0];
        
        ViewController *vc = [ViewController single];
        vc.isInTheScene = NO;
    }
    return self;
}

-(void)newCCData
{
    cc = [ClassCenter singleton];
    cc.sceneNumber = 2;
    cc.groupManas = 0;
    cc.lastObjPosition = CGPointMake(0, 0);
    cc.isCanPlayMusic = YES;
    cc.startNumber = 3;
}

-(void)createWar
{
    self.alpha = 0;
    _rootView = [SKSpriteNode spriteNodeWithColor:rgb(0x000000, 0.3) size:CGSizeMake(iw, ih)];
    _rootView.userInteractionEnabled = YES;
    _rootView.position = CGPointMake(iw/2, ih/2+60);
    _rootView.zPosition = 0;
    [self addChild:_rootView];
    [_rootView setScale:0.832];
    
    _war = [War_Controller createWar:_classNumber];
    _war.userInteractionEnabled = YES;
    _war.position = CGPointMake(0, 60);  //CGPointMake(-iw/2, -ih/2);
    _war.zPosition = 1;
    _war.alpha = 0;
    [_war createInit];
    [self addChild:_war];
    
    [self playBackgoundMusic];
    
    //设定已打过的关卡的金币奖励
    if (self.isAgainClass == 1) {
        if (_classNumber <= 4) {
            _war.c_prize = @"gold.2.win";
        }
        else {
            _war.c_prize = @"gold.5.win";
        }
    }
    
    _background = [[Background alloc] initWithType:_war.c_scene particle:_war.c_particle];
    _background.zPosition = 0;
    _background.position = CGPointMake(-iw/2, -ih/2);
    [_rootView addChild:_background];
    
    SKAction *scale = [SKAction scaleTo:1 duration:0.9];
    scale.timingMode = SKActionTimingEaseOut;
    [_rootView runAction:scale completion:^{
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.3];
        [_war runAction:fadeIn];
    }];
    
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.3];
    fadeIn.timingMode = SKActionTimingEaseOut;
    [self runAction:fadeIn];
    
}

-(void)showSelectJellysLand
{
    _selectJellys = [[SelectJellys alloc] init];
    _selectJellys.zPosition = 2010;
    _selectJellys.classNumber = self.classNumber;
    [self addChild:_selectJellys];
    [_selectJellys createInit];
    
    _topBar = [[TopBar alloc] init];
    [self addChild:_topBar];
    [_topBar moveDown];
    [_topBar hiddenBackground];
}

-(void)startGame
{
    NSMutableArray *jellyNamesArray = [NSMutableArray array];
    for (NSString *name in cc.classJellyNames) {
        [jellyNamesArray addObject:name];
    }
    //test 取消果冻预加载
//    StaticActions *sa = [StaticActions single];
//    AtlasController *ac = [AtlasController single];
//    NSArray *jellys = [sa loadJellyChickenAtlas:jellyNamesArray];
//    [ac addAtlas:jellys completion:^{
//
//        
//    }];
    
    [_war beginTheGame];
    SKAction *wait = [SKAction waitForDuration:1.2];
    [self runAction:wait completion:^{
        _beginAnime = [[BeginAnime alloc] init];
        _beginAnime.zPosition = 1999.1;
        [_beginAnime showtime];
        [self addChild:_beginAnime];
    }];
    
    _touchLayer = [[TouchLayer alloc] init];
    _touchLayer.zPosition = 1999.5; //1999.5
    [self addChild:_touchLayer];

    _buttonBar = [[ButtonBar alloc] init];
    _buttonBar.zPosition = 2001;
    [self addChild:_buttonBar];
    
    [_topBar moveUp];
    [_topBar showBackground];
    [self changeMana:_war.c_mana];
}

-(void)playBackgoundMusic
{
    _music_BG = [SK_BackgroundSound singleton];
    [_music_BG stopSound];
    
    if (cc.isCanPlayMusic == YES && !_music_BG.playing) {
        [_music_BG createSound:_war.c_music repeat:30];
        [_music_BG playSound];
    }
}

-(void)downObject:(NSString *)string pos:(CGPoint)pos;
{
    DownSomeBody *downSomeBody = [[DownSomeBody alloc] initWithBodyTpye:string];
    [downSomeBody setDownPosition:pos];
    downSomeBody.zPosition = 2000.9;  //1999.9
    [self addChild:downSomeBody];
}

-(void)gotoMap:(int)isWin
{
    [_war removeFromParent];
    [self clearStaticWar];
    ViewController *vc = [ViewController single];
    [vc gotoMapScene:isWin];
}

-(void)loster
{
    [self winner];
    return;
    if (!_topBar) {
        _topBar = [[TopBar alloc] init];
        [self addChild:_topBar];
    }
    
    [_topBar moveDown];
    [_buttonBar hiddenBar];
    loster = [[LosterAnime alloc] init];
    loster.zPosition = 2002;
    [self addChild:loster];
    
    isLosting = 1;
    [self pause];
}

-(void)winner
{
    if (isFirstWinner == YES) {
        return;
    }
    isFirstWinner = YES;
    [_topBar moveDown];
    NSString *longName = _war.c_prize;
    NSArray *nameArray = [longName componentsSeparatedByString:@"."];
    NSString *name = nameArray[0];
    
    if ([name isEqualToString:@"gold"] || [name isEqualToString:@"cook"]) {
        FreeGold *freeGold = [[FreeGold alloc] initWith:longName];
        freeGold.zPosition = 2012;
        [self addChild:freeGold];
    }
    else if ([name isEqualToString:@"gem"]) {
        FreeGem *freeGem = [[FreeGem alloc] initWith:longName];
        freeGem.zPosition = 2012;
        [self addChild:freeGem];
    }
    else if ([name isEqualToString:@"jelly"]) {
        FreeJelly *freejelly = [[FreeJelly alloc] initWith:longName];
        freejelly.zPosition = 2012;
        [self addChild:freejelly];
    }
    else if ([name isEqualToString:@"jellyPro"]) {
        FreeJellyPro *freejellyPro = [[FreeJellyPro alloc] initWith:longName];
        freejellyPro.zPosition = 2012;
        [self addChild:freejellyPro];
    }
    else if ([name isEqualToString:@"map"]) {
        FreeMap *freeMap = [[FreeMap alloc] initWithNumber:[nameArray[1] intValue]];
        freeMap.zPosition = 2012;
        [self addChild:freeMap];
    }
    else if ([name isEqualToString:@"whistle"]) {
        FreeWhistle *freeWhistle = [[FreeWhistle alloc] initWith:longName];
        freeWhistle.zPosition = 2012;
        [self addChild:freeWhistle];
    }
}

-(void)revive;
{
    [loster removeFromParent];
    [_war reviveGame];
}

-(void)reloadGame
{
    [_war removeFromParent];
    [self removeFromParent];
    ViewController *vc = [ViewController single];
    if (self.isAgainClass == 0) {
        [vc gotoGameScene:_classNumber classString:@"first"];
    }
    else {
        [vc gotoGameScene:_classNumber classString:@"again0"];
    }
}

-(void)pause
{
    _touchLayer.userInteractionEnabled = NO;
    [_touchLayer closeTouchUI];
    [_topBar moveDown];
    [_topBar showBackground];
    [_war pauseGame];
    _war.paused = YES;
    _war.speed = 0;
    pauseAnime = [[PauseAnime alloc] init];
    [self addChild:pauseAnime];
    
    if (isLosting == 0) {
        [self runAction:soundPause];
    }
    
    if (cc.isCanPlayMusic == YES && _music_BG.playing == YES) {
        _music_BG.singletonPlayer.volume = 0.03;
    }
}

-(void)goon
{
    _touchLayer.userInteractionEnabled = YES;
    [_topBar moveUp];
    [_war goonGame];
    _war.paused = NO;
    _war.speed = 1;
    
    [pauseAnime removeFromParent];
    pauseAnime = nil;
    
    if (isLosting == 0) {
        [self runAction:soundGoon];
    }
    
    if (cc.isCanPlayMusic == YES && _music_BG.playing == YES) {
        _music_BG.singletonPlayer.volume = 0.18;
    }
    
    isLosting = 0;
}

-(void)changeMana:(int)theMana
{
    _mana += theMana;
    [_touchLayer changeMana:_mana];
    [_buttonBar changeMana:_mana];
}

-(void)update:(NSTimeInterval)currentTime
{
    [_war rootUpdate];
}

-(void)clearStaticWar
{
    [GridArray clearAllNode];
    [Body clearStatic];
    [Jelly clearStatic];
}

@end