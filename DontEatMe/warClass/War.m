//
//  War.m
//  DontEatMe
//
//  Created by ym on 14/7/6.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "War.h"

#import "StudyTip.h"
#import "Prop.h"
#import "Stump.h"
#import "Rock.h"
#import "Floor.h"
#import "Button.h"
#import "ButtonBomb.h"
#import "Bounce.h"
#import "BlueBird.h"
#import "RedBird.h"
#import "YellowBird.h"
#import "Cloud.h"
#import "Meteorite.h"

#import "Grid.h"
#import "ChickenInClass.h"
#import "Jelly.h"

#import "Chicken.h"
#import "SpoonChicken.h"
#import "OnionChicken.h"
#import "FishChicken.h"
#import "IronBasinChicken.h"
#import "WoodenBasinChicken.h"
#import "FatChicken.h"
#import "BombChicken.h"
#import "BeerChicken.h"
#import "FireChicken.h"
#import "SawChicken.h"
#import "WeedChicken.h"
#import "YodaChicken.h"
#import "RifleChicken.h"
#import "MacheteChicken.h"
#import "MaidChicken.h"
#import "RobotBoss.h"
#import "FurChicken.h"
#import "MiniChicken.h"
#import "MiniChickenFlay.h"
#import "SmartChicken.h"
#import "ShadowChicken.h"
#import "BoreChicken.h"
#import "FlashMagicChicken.h"
#import "FireMagicChicken.h"
#import "SleepChicken.h"

#import "RifleBullet.h"
#import "RobotBullet.h"
#import "FireBall.h"
#import "PickNode.h"
#import "MoreChickensHummer.h"
#import "JellyXiaowei.h"

@implementation War
{

    int lowLoop;
    BOOL isGameOver;
    float area;
    float lastChickensTime;
    SKAction *soundHammer;
    SK_Sound *soundDicTempMusic;
    SKAction *soundChickenComing;
	float tempColliedJelly; //furChicken fireBall Attack Lock;
    float createChickenWaitMiniTime;
    ClassCenter *cc;
    ViewController *vc;
    BlueBird *blueBird;
    
    SKSpriteNode *rectL;
    SKSpriteNode *rectR;
    SKSpriteNode *loss;
    
    JellyXiaowei *xiaowei;
    SpoonChicken *spoon;
    OnionChicken *onion;
    FishChicken *fish;
    IronBasinChicken *iron;
    WoodenBasinChicken *wooden;
    FatChicken *fat;
    BombChicken *bomb;
    BeerChicken *beer;
    FireChicken *fire;
    SawChicken *saw;
    WeedChicken *weed;
    YodaChicken *yoda;
    RifleChicken *rifle;
    MacheteChicken *machete;
    MaidChicken *maid;
    RobotBoss *robot;
    FurChicken *fur;
    MiniChicken *mini;
    MiniChickenFlay *miniFly;
    SmartChicken *smart;
    ShadowChicken *shadow;
    BoreChicken *bore;
    FlashMagicChicken *flashMagic;
    FireMagicChicken *fireMagic;
    SleepChicken *sleepChicken;
    
    int isChickensSpeedUp;
    
    //消灭子弹的碰撞体
    Prop *stopWallUp;
    Prop *stopWallDown;
}
-(void)removeFromParent
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [soundDicTempMusic stop]; soundDicTempMusic = nil;
    
    [_jellys removeAllChildren];
    [_jellys removeFromParent];
    _jellys = nil;
    
    [_chickens removeAllChildren];
    [_chickens removeFromParent];
    _chickens = nil;
    
    [_jellysBullets removeAllChildren];
    [_jellysBullets removeFromParent];
    _jellysBullets = nil;
    
    [_chickenBullets removeAllChildren];
    [_chickenBullets removeFromParent];
    _chickenBullets = nil;
    
    [_props removeAllChildren];
    [_props removeFromParent];
    _props = nil;
    
    [_downObjs removeAllChildren];
    [_downObjs removeFromParent];
    _downObjs = nil;
    
    [_guageBar removeAllChildren];
    [_guageBar removeFromParent];
    _guageBar = nil;
    
    [xiaowei removeAllChildren];
    [xiaowei removeFromParent];
    xiaowei = nil;
    
    [spoon removeAllChildren];
    [spoon removeFromParent];
    spoon = nil;
    
    [onion removeAllChildren];
    [onion removeFromParent];
    onion = nil;
    
    [fish removeAllChildren];
    [fish removeFromParent];
    fish = nil;
    
    [iron removeAllChildren];
    [iron removeFromParent];
    iron = nil;
    
    [wooden removeAllChildren];
    [wooden removeFromParent];
    wooden = nil;
    
    [fat removeAllChildren];
    [fat removeFromParent];
    fat = nil;
    
    [bomb removeAllChildren];
    [bomb removeFromParent];
    bomb = nil;
    
    [beer removeAllChildren];
    [beer removeFromParent];
    beer = nil;
    
    [fire removeAllChildren];
    [fire removeFromParent];
    fire = nil;
    
    [saw removeAllChildren];
    [saw removeFromParent];
    saw = nil;
    
    [weed removeAllChildren];
    [weed removeFromParent];
    weed = nil;
    
    [yoda removeAllChildren];
    [yoda removeFromParent];
    yoda = nil;
    
    [rifle removeAllChildren];
    [rifle removeFromParent];
    rifle = nil;
    
    [machete removeAllChildren];
    [machete removeFromParent];
    machete = nil;
    
    [maid removeAllChildren];
    [maid removeFromParent];
    maid = nil;
    
    [robot removeAllChildren];
    [robot removeFromParent];
    robot = nil;
    
    [fur removeAllChildren];
    [fur removeFromParent];
    fur = nil;
    
    [mini removeAllChildren];
    [mini removeFromParent];
    mini = nil;
    
    [miniFly removeAllChildren];
    [miniFly removeFromParent];
    miniFly = nil;
    
    [smart removeAllChildren];
    [smart removeFromParent];
    smart = nil;
    
    [shadow removeAllChildren];
    [shadow removeFromParent];
    shadow = nil;
    
    [bore removeAllChildren];
    [bore removeFromParent];
    bore = nil;
    
    [flashMagic removeAllChildren];
    [flashMagic removeFromParent];
    flashMagic = nil;
    
    [fireMagic removeAllChildren];
    [fireMagic removeFromParent];
    fireMagic = nil;
    
    [sleepChicken removeAllChildren];
    [sleepChicken removeFromParent];
    sleepChicken = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}

-(id)init
{
    if (self = [super init]) {
        area = 50;
        self.gap = 19;
        isGameOver = NO;
        cc.isWinObject = 0;
        self.c_mana = 0;
        self.classType = basic;
        int tempRand = (int)skRand(0, 4);
        tempRand = 0;
        self.randomLine = (int)skRand(0, 4);
        self.birdFlyLoopTime = 15;
        
        [self createDate];
        
    };
    return self;
}

-(void)createInit
{
    self.userInteractionEnabled = YES;
    cc = [ClassCenter singleton];
    vc = [ViewController single];
    self.jellys = [SKNode node];
    [self addChild:_jellys];
    self.chickens = [SKNode node];
    [self addChild:_chickens];
    self.jellysBullets = [SKNode node];
    [self addChild:_jellysBullets];
    self.chickenBullets = [SKNode node];
    [self addChild:_chickenBullets];
    self.props = [SKNode node];
    [self addChild:_props];
    self.downObjs = [SKNode node];
    [self addChild:_downObjs];
    
    stopWallUp = [[Prop alloc] initWithColor:[UIColor redColor] size:CGSizeMake(iw, 96)];
    [self.props addChild:stopWallUp];
    stopWallUp.position = CGPointMake(iw/2, ih-46);
    stopWallUp.hidden = YES;
    stopWallDown = [[Prop alloc] initWithColor:[UIColor redColor] size:CGSizeMake(iw, 96)];
    [self.props addChild:stopWallDown];
    stopWallDown.position = CGPointMake(iw/2, 0);
    stopWallDown.hidden = YES;
    
    [self isLoss];
    [self changeePath];
    [self createChickens];
    [self createTheGame];
}

-(void)createDate
{
    self.c_name = @"Level Test";
    self.c_scene = @"greed";
    self.nextMusicTime = 900;
    self.c_music = @"greedWorld.mp3";
    self.c_prize = @"gold.1.win";
    
    NSDictionary *dic_0 = @{@"chickenType": @[ck(2, c_maid, 0, nil)],
                            @"time": @0,
                            @"sound": @"xxx.mp3",
                            @"isWin": @1,
                            };
    self.c_chickens = @[dic_0];
}

-(void)createTheGame //刚创建war
{
    self.isStopBridRoop = 1;
    [vc.gameScene showSelectJellysLand];
    [self createStump];
}

-(void)beginTheGame  //选完果冻
{
    self.isStopBridRoop = 0;
    SKAction *wait = [SKAction waitForDuration:2.5];
    [self runAction:wait completion:^{
        self.isStartPlayTheGame = YES;
        _isGameIn = 1;
        [self startChicken];
    }];
}

#pragma mark -creatChicken
-(void)createChickens
{
    self.guageBar = [[GuageBar alloc] init];
    [self addChild:self.guageBar];
    
    blueBird = [[BlueBird alloc] init];
    [self addChild:blueBird];
    
    //循环飞鸟启动
    SKAction *bridRoopWait = [SKAction waitForDuration:4];
    SKAction *bridRoopBlock = [SKAction runBlock:^{
        [self createBridRoop];
    }];
    SKAction *bridRoopSeq = [SKAction sequence:@[bridRoopBlock, bridRoopWait]];
    [self runAction:[SKAction repeatActionForever:bridRoopSeq]];
    
    [self.c_chickens enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
    
        float time = [[dic objectForKey:@"time"] floatValue];
        createChickenWaitMiniTime = 0;
        
        // 为空直接返回nil;
        
        NSArray *rocks = [dic objectForKey:@"rock"];
        NSArray *clouds = [dic objectForKey:@"cloud"];
        NSArray *meteorites = [dic objectForKey:@"meteorite"];
        NSArray *blueBrids = [dic objectForKey:@"blueBrid"];
        NSArray *redBrids = [dic objectForKey:@"redBrid"];
        NSArray *yellowBrids = [dic objectForKey:@"yellowBrid"];
        
        
        NSArray *chickens = [dic objectForKey:@"chickenType"];
        SKAction *wait = [SKAction waitForDuration:time];
        SKAction *block = [SKAction runBlock:^{
            for (NSNumber *theNumber in rocks) {
                Rock *rock = [[Rock alloc] initWithNumber:[theNumber intValue]];
                [self.props addChild:rock];
            }
            
            for (NSArray *theNumber in clouds) {
                Cloud *cloud = [[Cloud alloc] initWithNumber:[theNumber[0] intValue]*5 cloudType:[theNumber[1] intValue]];
                [self addChild:cloud];
            }
            
            for (NSNumber *theNumber in meteorites) {
                Meteorite *meteorite = [[Meteorite alloc] initWithNumber:[theNumber intValue]];
                [self addChild:meteorite];
            }
            
            for (NSNumber *theNumber in blueBrids) {
                BlueBird *blueBrid = [[BlueBird alloc] initWithNumber:[theNumber intValue]];
                [self addChild:blueBrid];
            }

            for (NSNumber *theNumber in redBrids) {
                RedBird *redBird = [[RedBird alloc] initWithNumber:[theNumber intValue]];
                [self addChild:redBird];
            }

            for (NSNumber *theNumber in yellowBrids) {
                YellowBird *yellowBrid = [[YellowBird alloc] initWithNumber:[theNumber intValue]];
                [self addChild:yellowBrid];
            }
        }];
        
        if (chickens.count > 0) {
            lastChickensTime = time;
        }
        
        [self runAction:[SKAction sequence:@[wait, block]]];
        
        for (ChickenInClass *chickenObj in chickens) {
            createChickenWaitMiniTime += 0.1;
            Chicken *chicken = [self createOneChickenWithName:chickenObj.type];
            [chicken sitLevel:chickenObj.level];
            chicken.myName = chickenObj.type;
//            chicken.dropObj = dropObject;
            
            //单独掉宝
            if (chickenObj.down) {
                chicken.dropObj = chickenObj.down;
            }
            
            int line;
            if (chickenObj.line < 9) {
                line = (chickenObj.line + self.randomLine)%5;
            }
            else {
                line = chickenObj.line%5;
            }
            
            Grid *grid = [[GridArray getGridArray] objectAtIndex:line];
            
            chicken.position = CGPointMake(CGRectGetMidX(grid.gridRect)+skRand(-10, 10), ih + 25);
            
            [chicken resetZPostion];
            [self.chickens addChild:chicken];
            
            // !!!:创建小小鸡，大大鸡
            if (self.classType == basic) {
                [chicken setScale:0.9];
            }
            else if (self.classType == bigChicken) {
                [chicken setScale:1.4];
                chicken.attack *= 1;
                chicken.speedMove *= 0.8;
                [chicken sitDefaultHP:chicken.defaultHP*3];
            }
            else if (self.classType == miniChicken) {
                [chicken setScale:0.7];
                [chicken sitDefaultHP:chicken.defaultHP/2];
            }
            
            chicken.waitStartTime = createChickenWaitMiniTime+time;
        };
    }];
    
    xiaowei = [[JellyXiaowei alloc] initWithTexture:Atlas(@"jelly_xiaowei_rest3")[0]];
    [self.jellys addChild:xiaowei];
    
    self.jellys.hidden = YES;
    self.chickens.hidden = YES;
}


-(Chicken *)createOneChickenWithName:(NSString *)name
{
    Chicken *chicken;
    if ([name isEqualToString:@"spoon"]) {
        if (!spoon) spoon = [[SpoonChicken alloc] init];
        chicken = [spoon copy];
    }else if ([name isEqualToString:@"onion"]){
        if (!onion) onion = [[OnionChicken alloc] init];
        chicken = [onion copy];
    }else if ([name isEqualToString:@"fish"]){
        if (!fish) fish = [[FishChicken alloc] init];
        chicken = [fish copy];
    }else if ([name isEqualToString:@"ironBasin"]){
        if (!iron) iron = [[IronBasinChicken alloc] init];
        chicken = [iron copy];
    }else if ([name isEqualToString:@"woodenBasin"]){
        if (!wooden) wooden = [[WoodenBasinChicken alloc] init];
        chicken = [wooden copy];
    }else if ([name isEqualToString:@"fat"]){
        if (!fat) fat = [[FatChicken alloc] init];
        chicken = [fat copy];
    }else if ([name isEqualToString:@"bomb"]){
        if (!bomb) bomb = [[BombChicken alloc] init];
        chicken = [bomb copy];
    }else if ([name isEqualToString:@"beer"]){
        if (!beer) beer = [[BeerChicken alloc] init];
        chicken = [beer copy];
    }else if ([name isEqualToString:@"fire"]){
        if (!fire) fire = [[FireChicken alloc] init];
        chicken = [fire copy];
    }else if ([name isEqualToString:@"saw"]){
        if (!saw) saw = [[SawChicken alloc] init];
        chicken = [saw copy];
    }else if ([name isEqualToString:@"weed"]){
        if (!weed) weed = [[WeedChicken alloc] init];
        chicken = [weed copy];
    }else if ([name isEqualToString:@"yoda"]){
        if (!yoda) yoda = [[YodaChicken alloc] init];
        chicken = [yoda copy];
    }else if ([name isEqualToString:@"rifle"]){
        if (!rifle) rifle = [[RifleChicken alloc] init];
        chicken = [rifle copy];
    }else if ([name isEqualToString:@"machete"]){
        if (!machete) machete = [[MacheteChicken alloc] init];
        chicken = [machete copy];
    }else if ([name isEqualToString:@"maid"]){
        if (!maid) maid = [[MaidChicken alloc] init];
        chicken = [maid copy];
    }else if ([name isEqualToString:@"robot"]){
        if (!robot) robot = [[RobotBoss alloc] init];
        chicken = [robot copy];
    }else if ([name isEqualToString:@"fur"]){
        if (!fur) fur = [[FurChicken alloc] init];
        chicken = [fur copy];
    }else if ([name isEqualToString:@"mini"]){
        if (!mini) mini = [[MiniChicken alloc] init];
        chicken = [mini copy];
    }else if ([name isEqualToString:@"miniFly"]){
        if (!miniFly) miniFly = [[MiniChickenFlay alloc] init];
        chicken = [miniFly copy];
    }else if ([name isEqualToString:@"smart"]){
        if (!smart) smart = [[SmartChicken alloc] init];
        chicken = [smart copy];
    }else if ([name isEqualToString:@"shadow"]){
        if (!shadow) shadow = [[ShadowChicken alloc] init];
        chicken = [shadow copy];
    }else if ([name isEqualToString:@"bore"]){
        if (!bore) bore = [[BoreChicken alloc] init];
        chicken = [bore copy];
    }else if ([name isEqualToString:@"flashMagic"]){
        if (!flashMagic) flashMagic = [[FlashMagicChicken alloc] init];
        chicken = [flashMagic copy];
    }else if ([name isEqualToString:@"fireMagic"]){
        if (!fireMagic) fireMagic = [[FireMagicChicken alloc] init];
        chicken = [fireMagic copy];
    }else if ([name isEqualToString:@"sleep"]){
        if (!sleepChicken) sleepChicken = [[SleepChicken alloc] init];
        chicken = [sleepChicken copy];
    }
    
    return chicken;
}

-(void)startChicken
{
    self.chickens.hidden = NO;
    self.jellys.hidden = NO;
    [xiaowei move];
    
    [self.guageBar beginGame:lastChickensTime];
    for (Chicken *chicken in self.chickens.children) {
        SKAction *miniWait = [SKAction waitForDuration:chicken.waitStartTime];
        [self.chickens runAction:miniWait completion:^{
            [chicken startup];
        }];
    }
    
    
    // !!!:切换激烈背景音乐
    if (_nextMusicTime == 900) {
        _nextMusicTime = lastChickensTime-self.gap*0.7;
    }
    SKAction *waitNextMusicTime = [SKAction waitForDuration:_nextMusicTime];
    SKAction *playGetUp = [SKAction runBlock:^{
        StaticActions *sa = [StaticActions single];
        [self.chickens runAction:sa.sound_getUp withKey:@"sound_getUp"];
    }];
    
    SKAction *playTempMusic = [SKAction runBlock:^{
        soundDicTempMusic = [SK_Sound createNewSound:music_bigChicken repeat:3];        //test
        [soundDicTempMusic play];
    }];
    
    [self.guageBar runAction:waitNextMusicTime completion:^{
        [vc.gameScene.music_BG fadeStop];
        
        SKAction *tempWait = [SKAction waitForDuration:3];
        [self runAction:[SKAction sequence:@[tempWait,playGetUp, tempWait, playTempMusic]]];
        SKAction *backgroundMusicPlayWait = [SKAction waitForDuration:6+81];
        [self runAction:backgroundMusicPlayWait completion:^{
            if ([[[UserCenter dic] objectForKey:@"music"] boolValue] == YES) {
                [vc.gameScene.music_BG playSound];
            }
        }];
    }];
}

-(void)createBridRoop
{
    if (self.isStopBridRoop == 1) {
        return;
    }
    
    if (self.manaType == manaInfinity) {
        self.isStopBridRoop = 1;
        self.manaType = manaBasic;
        RedBird *brid = [[RedBird alloc] initWithNumber:(int)skRand(5, 7)*5];
        [self addChild:brid];
        _birdFlyNumber++;
        SKAction *waitCreateBridAction = [SKAction waitForDuration:20];
        [self runAction:waitCreateBridAction completion:^{
            self.isStopBridRoop = 0;
        }];
        return;
    }
    
    if (cc.groupManas >= 6 || vc.gameScene.mana + cc.groupManas > 9) {
        return;
    }
    
    self.isStopBridRoop = 1;
    SKAction *waitCreateBridBegin = [SKAction waitForDuration:4];
    SKAction *waitCreateBridAction = [SKAction waitForDuration:self.birdFlyLoopTime];  //飞鸟循环CD时间, 检验时间在createChicken中,120ms一次
    SKAction *createBirdAction = [SKAction runBlock:^{
        [blueBird fly];
        _birdFlyNumber++;
    }];
    SKAction *seq = [SKAction sequence:@[waitCreateBridBegin, createBirdAction, waitCreateBridAction]];
    [self runAction:seq completion:^{
        self.isStopBridRoop = 0;
    }];
}

-(void)whistleOneBird
{
    BlueBird *brid = [[BlueBird alloc] init];
    [self addChild:brid];
    [brid flyOnes];
    _birdFlyNumber++;
}


-(void)playSoundChickenComing
{
    soundChickenComing = [SKAction playSoundFileNamed:@"Sound/chicken_say_0.mp3" waitForCompletion:0];
    SKAction *wait = [SKAction waitForDuration:10];
    SKAction *intervalWait1 = [SKAction waitForDuration:1.8];
    [self runAction:[SKAction sequence:@[wait, soundChickenComing, intervalWait1, soundChickenComing]]];
}

-(void)createStump
{
    
}

#pragma mark -other
-(void)pauseGame
{
    for (Chicken *chicken in self.chickens.children) {
        [chicken pause];
    }
}

-(void)goonGame
{
    for (Chicken *chicken in self.chickens.children) {
        [chicken goon];
    }
}


-(void)changeePath
{
    rectL = [[SKSpriteNode alloc] initWithColor:rgb(0x453355, 0.5) size:CGSizeMake(116, 94)];
    rectL.position = CGPointMake(95, ih-830);
    rectR = [[SKSpriteNode alloc] initWithColor:rgb(0x453355, 0.5) size:CGSizeMake(116, 94)];
    rectR.position = CGPointMake(551, ih-830);
    
    [self addChild:rectL];
    [self addChild:rectR];
    rectL.hidden = YES;
    rectR.hidden = YES;
}

#pragma mark - Updata
-(void)rootUpdate
{
    if (self.paused == NO && self.speed > 0) {
        [self collied];
        [self changeIsWin];
    }
}

-(void)changeIsWin
{
    if (self.chickens.children.count == 0 && _isGameIn == 1) {
        [vc.gameScene.touchLayer closeTouchUI];
        [vc.gameScene downObject:self.c_prize pos:CGPointMake(iw/2, ih/2+260)];
        for (Jelly *jelly in self.jellys.children) {
            if ([jelly.myName isEqualToString:@"energy"]) {
                jelly.speed = 0;
            }
        }
        self.isStopBridRoop = 1;
        _isGameIn = 2;
    }
}

-(void)winCallBack{};

-(void)reviveGame
{
    SKSpriteNode *hammer = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_hammer")[0]];
    hammer.zPosition = 1999.95;
    hammer.anchorPoint = CGPointMake(0, 0.5);
    hammer.zRotation = iPI(-80);
    hammer.position = CGPointMake(-430, ih-680);
    [self addChild:hammer];
    
    SKSpriteNode *hammerShadow = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_hammer")[1]];
    hammerShadow.position = CGPointMake(iw/2, ih-888);
    hammerShadow.alpha = 0;
    [self addChild:hammerShadow];
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:1];
    [hammerShadow runAction:fadeIn];
    
    SKAction *actionHammer = [SK_Actions actionHammer];
    [hammer runAction:actionHammer completion:^{
        [hammer removeFromParent];
        [hammerShadow removeFromParent];
    }];
    
    soundHammer = [SKAction playSoundFileNamed:@"Sound/war_hammer.mp3" waitForCompletion:0];
    [self runAction:soundHammer];
    
    for (Chicken *chicken in self.chickens.children) {
        if (chicken.position.y < (ih-620)){
            SKAction *scel = [SKAction scaleYTo:0.3 duration:0.2];
            SKAction *wait = [SKAction waitForDuration:3];
            chicken.boxRect = CGRectMake(0, 0, 0, 0);
            [chicken removeAllActions];
            [chicken runAction:[SKAction sequence:@[scel, wait]] completion:^{
                [chicken useDie];
                isGameOver = NO;
            }];
        }
    }
    
    for (Prop *prop in self.props.children) {
        if (prop.position.y < (ih-620)){
            SKAction *scel = [SKAction scaleYTo:0.3 duration:0.2];
            SKAction *wait = [SKAction waitForDuration:3];
            prop.boxRect = CGRectMake(0, 0, 0, 0);
            [prop removeAllActions];
            [prop runAction:[SKAction sequence:@[scel, wait]] completion:^{
                [prop useDie];
                isGameOver = NO;
            }];
        }
    }
}

-(void)moreChickensHammer
{
    MoreChickensHummer *more = [[MoreChickensHummer alloc] init];
    [self addChild:more];
}

-(void)isLoss
{
    loss = [[SKSpriteNode alloc] initWithColor:rgb(0x453355, 0.01) size:CGSizeMake(iw*2, 90)];
    loss.position = CGPointMake(iw/2, ih-950-100);
    [self addChild:loss];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -collied
-(void)collied
{
    int isStartUp = 0;
    for (Chicken *chicken in self.chickens.children) {
        isStartUp += chicken.isStartup;
        
        if (chicken.position.y > ih) {
            continue;
        }
        
        [chicken reloadRect];
        [chicken resetZPostion];
        
        if (chicken.isCanNotCoill == YES) {
            continue;
        }
        
        [self colliedChickenMoveDown:chicken];
        
        for (Jelly *jelly in self.jellys.children) {
            [self colliedBChicken:chicken jelly:jelly];
        }
        
        for (Weapon *jellysBullets in self.jellysBullets.children) {
            [jellysBullets reloadRect];
            [self colliedEmpty:chicken weapon:jellysBullets];
        }
        
        for (Prop *prop in self.props.children) {
            [prop reloadRect];
            [self colliedCChicken:chicken prop:prop];
        }
    }
    
    // !!!:加速每波小鸡直接的间隔
    if (isStartUp > 0 && isChickensSpeedUp == 0) {
        isChickensSpeedUp = 1;
    }
    
    if (isStartUp == 0 && isChickensSpeedUp == 1) {
        isChickensSpeedUp = 5;
        self.chickens.speed = 5;
        self.guageBar.speed = 5;
    }
    else if(isChickensSpeedUp == 5){
        isChickensSpeedUp = 1;
        self.chickens.speed = 1;
        self.guageBar.speed = 1;
    }
    
    for (Jelly *jelly in self.jellys.children) {
        
        if (jelly.isCanNotCoill == YES) {
            continue;
        }
        
        for (Weapon *chickenBullets in self.chickenBullets.children) {
            [chickenBullets reloadRect];
            [self colliedEmpty:jelly weapon:chickenBullets];
        }
        for (Prop *prop in self.props.children) {
            [prop reloadRect];
            [self colliedDJelly:jelly prop:prop];
        }
    }
    
    for (Prop *prop in self.props.children) {
        [prop reloadRect];
        for (Weapon *jellysBullets in self.jellysBullets.children) {
            [jellysBullets reloadRect];
            [self colliedProp:prop weapon:jellysBullets];
            [self colliedStopWall:stopWallUp weapon:jellysBullets];
        }
        for (Weapon *chickenBullets in self.chickenBullets.children) {
            [chickenBullets reloadRect];
            [self colliedProp:prop weapon:chickenBullets];
            [self colliedStopWall:stopWallDown weapon:chickenBullets];
        }
    }
    
    
}

-(void)colliedChickenMoveDown:(Chicken *)chicken
{
    if (chicken.position.y > 360) {
        return;
    }
    if (CGRectIntersectsRect(chicken.boxRect, rectL.frame) || CGRectIntersectsRect(chicken.boxRect, rectR.frame)) {
        [chicken chickenCoilDown];
    }
    if (CGRectIntersectsRect(chicken.boxRect, loss.frame)) {
        if (isGameOver == NO) {
            isGameOver = YES;
            [vc.gameScene loster];
        }
    }
}

-(void)colliedBChicken:(Chicken *)chicken jelly:(Jelly *)jelly
{
    if (CGRectIntersectsRect(jelly.attackRect, chicken.boxRect)) {
        jelly.attackBody = chicken;
        [jelly useAttack];
    }
    if (CGRectIntersectsRect(jelly.boxRect, chicken.attackRect)) {
        chicken.attackBody = jelly;
        [chicken useAttack];
    }
}


-(void)colliedEmpty:(Body *)empty weapon:(Weapon *)weapon
{
    [weapon attackBody:empty];
}

-(void)colliedCChicken:(Chicken *)chicken prop:(Prop *)prop
{
    if (CGRectIntersectsRect(chicken.boxRect, prop.boxRect)) {
        [prop beColliedBy:chicken];
        [chicken beColliedBy:prop];
    }
}

-(void)colliedDJelly:(Jelly *)jelly prop:(Prop *)prop
{
    if (CGRectIntersectsRect(jelly.boxRect, prop.boxRect)) {
        [prop beColliedBy:jelly];
        [jelly beColliedBy:prop];
    }
}

-(void)colliedProp:(Prop *)prop weapon:(Weapon *)weapon
{
    if (![prop.myName isEqualToString:@"boomButton"]) {                // 防止炸弹的按钮被jelly的子弹攻击
        [weapon attackBody:prop];
    }
//    if (CGRectIntersectsRect(weapon.boxRect, prop.boxRect)) {
//        [prop changeHP:weapon.attack attacker:weapon];
//    }
}

-(void)colliedStopWall:(Prop *)wall weapon:(Weapon *)weapon
{
    if (CGRectIntersectsRect(wall.frame, weapon.boxRect)) {
        [weapon removeFromParent];
    }
}


@end
