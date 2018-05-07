//
//  MapScene.m
//  DontEatMe
//
//  Created by ym on 14/9/5.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "MapScene.h"
#import "MapJelly.h"
#import "Story.h"
#import "StartGameAlert.h"
#import "FillSceneAlert/FishFramAlert.h"
#import "FillSceneAlert/CookiedHouse.h"
#import "FillSceneAlert/GamblingBoat.h"
#import "FillSceneAlert/MineList.h"
#import "Chest.h"
#import "PickNode.h"

@implementation MapScene
{
    SKSpriteNode *bar;
    SK_PSD *mapLine;
    MapJelly *jelly;
    SKSpriteNode *map;
    SKSpriteNode *lands;
    int isWin;
    SK_BackgroundSound *music_BG;
    SKAction *soundRocket;
    SK_Button *tipButtonCopy;
    SK_Button *bookButton;
    int isHaveNewSkill;
    PickNode *pick;
    SKSpriteNode *newSkillImage;
}

-(void)delloc
{
    bar = nil;
    jelly = nil;
    mapLine = nil;
    lands = nil;
    map = nil;
    _sv = nil;
    _topBar = nil;
    pick = nil;
    bookButton = nil;
    tipButtonCopy = nil;
    newSkillImage = nil;
    soundRocket = nil;
}

-(void)removeFromParent
{
    [bar removeAllChildren];
    [bar removeFromParent];
    
    
    [jelly removeAllActions];
    [jelly removeFromParent];
    
    
    [mapLine removeAllChildren];
    [mapLine removeFromParent];
    
    
    [lands removeAllChildren];
    [lands removeFromParent];
    
    
    [map removeAllChildren];
    [map removeFromParent];
    
    
    [_sv removeAllChildren];
    [_sv removeFromParent];
    
    
    [_topBar removeAllChildren];
    [_topBar removeFromParent];
    
    
    [pick removeAllChildren];
    [pick removeFromParent];
    
    
    [bookButton removeAllChildren];
    [bookButton removeFromParent];
    
    
    [tipButtonCopy removeAllActions];
    [tipButtonCopy removeFromParent];
    
    
    [newSkillImage removeAllChildren];
    [newSkillImage removeFromParent];
    
    [self removeAllActions];
    [self removeAllChildren];
    [super removeFromParent];
    
}

+(id)createMapWithWin:(int)isWin
{
    return [[self alloc] initIsWin:isWin];
}

-(id)initIsWin:(int)isWin_
{
    if (self = [super initWithSize:CGSizeMake(iw, ih)]) {
        ClassCenter *cc = [ClassCenter singleton];
        cc.sceneNumber = 1;
        self.backgroundColor = rgb(0x63b4ce, 1);
        self.scaleMode = SKSceneScaleModeAspectFit;
        [self createBar];
        isWin = isWin_;
        if (isWin == -1) {
            [self createScrollView];
            [self fristCreateGame];
            [self lost];
        }
        else if (isWin >= 0 && isWin < 9) {
            [self win];
            [self createScrollView];
        }
        else if (isWin == 9) {
            [self createScrollView];
            [self fristCreateGame];
        }
        [self playBackgroundMusic];
        
        if ([[[UserCenter dic] objectForKey:@"isFirst"] boolValue] == NO) {
            [self createAirShip];
        }
        
        [self reOpenFillScene];
        
        ViewController *vc = [ViewController single];
        vc.isInTheScene = NO;
    }
    return self;
}

-(void)reOpenFillScene
{
    ClassCenter *cc = [ClassCenter singleton];
    if (cc.isOpenFillScene == 1) {
        FishFramAlert *fish = [[FishFramAlert alloc] init];
        [self addChild:fish];
    }
    else if (cc.isOpenFillScene == 2) {
        CookiedHouse *cookiedHouse = [[CookiedHouse alloc] init];
        [self addChild:cookiedHouse];
    }
    else if (cc.isOpenFillScene == 3) {
        MineList *mineList = [[MineList alloc] init];
        [self addChild:mineList];
    }
    else if (cc.isOpenFillScene == 4) {
        GamblingBoat *boat = [[GamblingBoat alloc] init];
        [self addChild:boat];
    }
}

-(void)createAirShip
{
    SKSpriteNode *ship = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_obj")[12]];
    ship.position = CGPointMake(631, 1842);
    ship.zPosition = 1000;
    [map addChild:ship];
    
    [ship runAction:[SK_Actions actionWater]];
}

-(void)playBackgroundMusic
{
    music_BG = [SK_BackgroundSound singleton];
    if ([music_BG.musicName isEqualToString:music_map]) {
        [music_BG playSound];
        return;
    }
    [music_BG stopSound];
    
    // !!!:地图背景随机音乐
    NSString *musicString = music_map;
    if (skRand(0, 1) == 0) {
        musicString = music_land1;
    }
    [music_BG createSound:musicString repeat:-1];
    [music_BG playSound];
    
    ClassCenter *cc = [ClassCenter singleton];
    if (cc.isCanPlayMusic == YES && !music_BG.playing) {
        SKAction *wait = [SKAction waitForDuration:music_BG.singletonPlayer.duration+15];
        SKAction *block = [SKAction runBlock:^{
            [music_BG playSound];
        }];
        SKAction *seq = [SKAction sequence:@[block, wait]];
        [self runAction:[SKAction repeatActionForever:seq]];
    }
}

-(void)createBar
{
    if (self.topBar == nil) {
        _topBar = [[TopBar alloc] init];
        [self addChild:_topBar];
    }
    
    bar = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(iw, 110)];
    bar.position = CGPointMake(0, -bar.size.height);
    bar.anchorPoint = CGPointMake(0, 0);
    bar.zPosition = 101;
    _isBottomMove = YES;
    [self addChild:bar];
    
    SKSpriteNode *leftBG = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_bottom")[13]];
    leftBG.position = CGPointMake(0, 0);
    leftBG.anchorPoint = CGPointMake(0, 0);
    [bar addChild:leftBG];
    
    SKSpriteNode *rightBG = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_bottom")[13]];
    rightBG.anchorPoint = CGPointMake(0, 0);
    rightBG.position = CGPointMake(iw, 0);
    rightBG.xScale = -1;
    [bar addChild:rightBG];
    
    // !!!:创建右下角按钮
    SK_Button *homeButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_lawn")[16]];
    homeButton.position = CGPointMake(50, 55);
    [bar addChild:homeButton];
    
    bookButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_lawn")[15]];
    bookButton.position = CGPointMake(640-52, 52);
    [bar addChild:bookButton];
    
    [self loadNewSkillTip];
    
    ViewController *vc = [ViewController single];
    StaticActions *sa = [StaticActions single];
    [homeButton playSound:sa.sound_buttonB];
    [homeButton event:^{
        [vc gotoHomeScene];
        [self removeFromParent];
    }];
    
    [bookButton playSound:sa.sound_buttonA];
    [bookButton event:^{
        [pick removeFromParent];
        pick = nil;
        [newSkillImage removeFromParent];
        newSkillImage = nil;
        vc.book = [[Book alloc] init];
        [self addChild:vc.book];
        [self moveBarHidden];
        [_sv.miniMapBackground runAction:[SKAction fadeOutWithDuration:0.3]];
    }];
    
    [_topBar moveDown];
    [self moveBarShow];
}

-(void)loadNewSkillTip
{
    isHaveNewSkill = 0;
    NSDictionary * jellyData = [[UserCenter dic] objectForKey:@"jellyData"];
    [jellyData enumerateKeysAndObjectsUsingBlock:^(id key, NSDictionary *dic, BOOL *stop) {
        if ([[dic objectForKey:@"isGemA"] intValue] == 111 || [[dic objectForKey:@"isGemB"] intValue] == 111) {
            isHaveNewSkill ++;
        }
    }];
    if (isHaveNewSkill > 0) {
        if (!newSkillImage) {
            newSkillImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_lawn")[19]];
            newSkillImage.position = CGPointMake(28, 38);
            [bookButton addChild:newSkillImage];
        }
        
        if (!pick) {
            pick = [[PickNode alloc] init];
            pick.zRotation = iPI(15);
            pick.anchorPoint = CGPointMake(0.5, 0.5);
            pick.xScale = -1;
            pick.yScale = 1;
            pick.zPosition = 1;
            pick.position = CGPointMake(-50, 10);
            [bookButton addChild:pick];
        }
        
    }
}

-(void)moveBarShow
{
    [bar removeAllActions];
    SKAction *move = [SKAction moveToY:0 duration:0.5];
    move.timingMode = SKActionTimingEaseInEaseOut;
    [bar runAction:move];
    _isBottomMove = YES;
    [self loadNewSkillTip];
}

-(void)moveBarHidden
{
    [bar removeAllActions];
    SKAction *move = [SKAction moveToY:-bar.size.height-40  duration:0.5];
    move.timingMode = SKActionTimingEaseInEaseOut;
    [bar runAction:move];
    _isBottomMove = NO;
}


// !!!:进关卡
-(void)createAGame:(int)number classString:(NSString *)classString;
{
    ViewController *vc = [ViewController single];
//    if (number == 34 || number == 35) {
//        [vc testAlert];
//        return; //test 用于限制关卡，发ipa包
//    }
    
    if ([[[UserCenter dic] objectForKey:@"cook"] intValue] > 0) {
        StartGameAlert *startGameAlert = [[StartGameAlert alloc] initWithClassNumber:number+1 classString:classString];
        startGameAlert.zPosition = 9100;
        [self addChild:startGameAlert];
    }else {
        [vc.mapScene.topBar tipPickCook];
    }
}

-(void)createStoryWithNumber:(int)number string:(NSString *)string block:(void (^)())block
{
    NSString *storyString = [UserCenter dic][@"mapLine"][number][2][string];
    if (storyString.length <= 1) {
        return;
    }
    Story *story = [Story createWithNumber:number string:string];
    story.zPosition = 3000;
    [self addChild:story];
    
    if (block) {
        [story event:block];
    }
}


//快速创建sprite方法
-(SKSpriteNode *)createSpriteWithTexture:(SKTexture *)texture pos:(CGPoint)pos father:(id)father
{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:texture];
    sprite.position = pos;
    [father addChild:sprite];
    return sprite;
}

-(void)createScrollView
{
    int haveLands = [[[UserCenter dic] objectForKey:@"lands"] intValue];
    _sv = [SK_ScrollView createScrollViewWithSize:CGSizeMake(iw, ih)];
    [self addChild:_sv];
    
    map = [SKSpriteNode spriteNodeWithColor:rgb(0x63b4ce, 1) size:CGSizeMake(5434, 4350)];
    [_sv addScrollNode:map];
    [_sv showRadar:[SKTexture textureWithImageNamed:@"miniMap.png"]];
    _sv.miniMapBackground.zPosition = 100;
    [map setScale:0.95]; //test 缩放整个地图测试一下效果  //0.9
    
    lands = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(1, 1)];
    lands.position = CGPointMake(0, 0);
    [map addChild:lands];
    
    // !!!:创建版块
    float landsHeight = 4350;
    NSString *atlasName;
    if ([iString(@"language") isEqualToString:@"Chinese"]) {
        atlasName = @"ui_map_buttons_cn";
    }
    else {
        atlasName = @"ui_map_buttons_en";
    }
    
    if (haveLands >= -1) {
        // !!!:创建版块1 小岛
        SKSpriteNode *land1 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_land_0")[0]];
        land1.position = CGPointMake(1024, landsHeight-2976);
        land1.zPosition = 0.03;
        [lands addChild:land1];
    }
    
    if (haveLands >= 0) {
        // !!!:创建版块2 绿地
        SKSpriteNode *land2 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_land_1")[0]];
        land2.position = CGPointMake(1950, landsHeight-3253);
        land2.zPosition = 0.08;
        [lands addChild:land2];
        
        SKTexture *fishFarmTex;
        if ([iString(@"language") isEqualToString:@"Chinese"]) {
            fishFarmTex = Atlas(@"ui_map_buttons_cn")[0];
        }
        else {
            fishFarmTex = Atlas(@"ui_map_buttons_en")[0];
        }
        
        CGPoint pos = CGPointMake(1598, landsHeight - 3665);
        
        SK_Button *fishFarm = [SK_Button spriteNodeWithColor:rgb(0x000000, 0) size:CGSizeMake(230, 230)];
        fishFarm.zPosition = 10;
        fishFarm.position = pos;
        fishFarm.touchScale = 1.1;
        fishFarm.touchAddzPosition = 0;
        [lands addChild:fishFarm];
        
        SKSpriteNode *fishFarmImage = [self createSpriteWithTexture:fishFarmTex pos:pos father:lands];
        fishFarmImage.zPosition = fishFarm.zPosition -1;
        fishFarm.backgoundImage = fishFarmImage;
        fishFarm.touchMoveNode = _sv;
        
        [fishFarm event:^{
            FishFramAlert *fish = [[FishFramAlert alloc] init];
            [self addChild:fish];
        }];
        
        if (haveLands == 0) {
            SKSpriteNode *cloud2 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_allLandCloud")[2]];
            cloud2.position = CGPointMake(1957, 1098);
            cloud2.zPosition = 90;
            [cloud2 setScale:4];
            [lands addChild:cloud2];
        }
    }
    
    if (haveLands >= 1) {
        // !!!:创建版块3 雪地
        SKSpriteNode *land3 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_land_2")[0]];
        land3.position = CGPointMake(2868+177/2-26, landsHeight - 3004 + 306/2-15);
        land3.zPosition = 0.07;
        [lands addChild:land3];
        
        SK_Button *snow = [SK_Button spriteNodeWithColor:rgb(0x000000, 0) size:CGSizeMake(380, 380)];
        snow.zPosition = 11;
        snow.position = CGPointMake(2336, landsHeight - 2457);
        snow.touchScale = 1.1;
        snow.touchAddzPosition = 0;
        [lands addChild:snow];
        
        SKSpriteNode *snowImage = [self createSpriteWithTexture:Atlas(atlasName)[1] pos:snow.position father:lands];
        snowImage.zPosition = snow.zPosition - 1;
        snow.backgoundImage = snowImage;
        snow.touchMoveNode = _sv;
        
        SKSpriteNode *snowMask = [SKSpriteNode spriteNodeWithTexture:Atlas(atlasName)[5]];
        snowMask.zPosition = 10.5;
        snowMask.position = CGPointMake(2353, landsHeight - 2666);
        [lands addChild:snowMask];
        
        SK_Button *house = [SK_Button spriteNodeWithColor:rgb(0x000000, 0) size:CGSizeMake(300, 230)]; //[SK_Button spriteNodeWithTexture:Atlas(atlasName)[2]];
        house.zPosition = 11;
        house.position = CGPointMake(3065, landsHeight - 2119);
        house.touchScale = 1.1;
        house.touchAddzPosition = 0;
        [lands addChild:house];
        
        SKSpriteNode *houseImage = [self createSpriteWithTexture:Atlas(atlasName)[2] pos:house.position father:lands];
        houseImage.zPosition = house.zPosition -1;
        house.backgoundImage = houseImage;
        house.touchMoveNode = _sv;
        
        SK_Button *waterShip = [SK_Button spriteNodeWithTexture:Atlas(atlasName)[7]];
        waterShip.zPosition = 11;
        waterShip.position = CGPointMake(3105 + 110, landsHeight - 3913 - 10);
        waterShip.touchScale = 1.1;
        waterShip.touchAddzPosition = 0;
        [lands addChild:waterShip];
        waterShip.touchMoveNode = _sv;
        
        [snow event:^{
            MineList *mineList = [[MineList alloc] init];
            [self addChild:mineList];
        }];
        
        [house event:^{
            CookiedHouse *cookiedHouse = [[CookiedHouse alloc] init];
            [self addChild:cookiedHouse];
        }];
        
        [waterShip event:^{
            
        }];
        
        if (haveLands == 1) {
            SKSpriteNode *cloud3 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_allLandCloud")[3]];
            cloud3.position = CGPointMake(2960+40, 1468);
            cloud3.zPosition = 90.1;
            [cloud3 setScale:4];
            [lands addChild:cloud3];
        }
        
    }
    
    if (haveLands >= 2) {
        // !!!:创建版块4 沙漠
        SKSpriteNode *land4 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_land_3")[0]];
        land4.position = CGPointMake(1643 + 15 - 6, landsHeight - 1925 + 65);
        land4.zPosition = 0.06;
        [lands addChild:land4];
        
        SK_Button *ship = [SK_Button spriteNodeWithTexture:Atlas(@"ui_map_obj")[17]];
        ship.zPosition = 11;
        ship.position = CGPointMake(690+190, landsHeight - 1025 - 140);
        ship.touchScale = 1.07;
        [ship setScale:0.7];
        ship.touchAddzPosition = 0;
        [lands addChild:ship];
        
        SKSpriteNode *shipImage = [self createSpriteWithTexture:Atlas(atlasName)[3] pos:CGPointMake(690+30, landsHeight - 1025) father:lands];
        shipImage.zPosition = 0.065;
        //    ship.backgoundImage = shipImage;
        ship.touchMoveNode = _sv;
        
        [ship event:^{
            GamblingBoat *gamblingBoat = [[GamblingBoat alloc] init];
            [self addChild:gamblingBoat];
        }];
        
        if (haveLands == 2) {
            SKSpriteNode *cloud4 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_allLandCloud")[4]];
            cloud4.position = CGPointMake(728*2-80, 1379*2+80);
            cloud4.zPosition = 90.2;
            [cloud4 setScale:4];
            [lands addChild:cloud4];
        }
    }
    
    if (haveLands >= 3) {
        // !!!:创建版块5 森林
        SKSpriteNode *land5 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_land_4")[0]];
        land5.position = CGPointMake(2559, landsHeight - 849 -5);
        land5.zPosition = 0.04;
        [lands addChild:land5];
        
        if (haveLands == 3) {
            SKSpriteNode *cloud5 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_allLandCloud")[5]];
            cloud5.position = CGPointMake(2584, 3470);
            cloud5.zPosition = 90.1;
            [cloud5 setScale:4];
            [lands addChild:cloud5];
        }
        
    }
    
    if (haveLands >= 4) {
        // !!!:创建版块6 熔岩
        SKSpriteNode *land6 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_land_6")[0]];
        land6.position = CGPointMake(4058 -180, landsHeight - 1265);
        land6.zPosition = 0.05;
        [lands addChild:land6];
        
        SK_Button *fireMt = [SK_Button spriteNodeWithColor:rgb(0x000000, 0) size:CGSizeMake(350, 350)];
        fireMt.zPosition = 11;
        fireMt.position = CGPointMake(4507, landsHeight - 615);
        fireMt.touchScale = 1.1;
        fireMt.touchAddzPosition = 0;
        [lands addChild:fireMt];
        
        SKSpriteNode *fireMtImage = [self createSpriteWithTexture:Atlas(atlasName)[4] pos:fireMt.position father:lands];
        fireMtImage.zPosition = fireMt.zPosition - 1;
        fireMt.backgoundImage = fireMtImage;
        fireMt.touchMoveNode = _sv;
        
        SKSpriteNode *mask = [SKSpriteNode spriteNodeWithTexture:Atlas(atlasName)[6]];
        mask.zPosition = 10.5;
        mask.position = CGPointMake(4563, landsHeight - 816);
        [lands addChild:mask];
        
        [fireMt event:^{
            
        }];
        
        if (haveLands == 4) {
            SKSpriteNode *cloud6 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_allLandCloud")[6]];
            cloud6.position = CGPointMake(3936, 3193);
            cloud6.zPosition = 90.2;
            [cloud6 setScale:4];
            [lands addChild:cloud6];
        }
        
    }
    
    if (haveLands >= 5) {
        // !!!:创建版块7 果园
        SKSpriteNode *land7 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_land_7")[0]];
        land7.position = CGPointMake(4551, landsHeight-2387);
        land7.zPosition = 0.09;
        [lands addChild:land7];
        
        if (haveLands == 5) {
            SKSpriteNode *cloud7 = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_allLandCloud")[7]];
            cloud7.position = CGPointMake(4460, 2206);
            cloud7.zPosition = 90.3;
            [cloud7 setScale:4];
            [lands addChild:cloud7];
        }
    }
    
    [self reloadMaps];
}

-(void)reloadMaps
{
    StaticActions *sa = [StaticActions single];
    int haveLands = [[[UserCenter dic] objectForKey:@"lands"] intValue];
    NSArray *mapNumbers;
    if (haveLands == 0) {
        mapNumbers = @[@"0-3"];
    }
    else if (haveLands == 1) {
        mapNumbers = @[@"0-11"];
    }
    else if (haveLands == 2) {
        mapNumbers = @[@"0-25", @"71-74"];
    }
    else if (haveLands == 3) {
        mapNumbers = @[@"0-34", @"71-78"];
    }
    else if (haveLands == 5) {
        mapNumbers = @[@"0-52"];
    }
    else if (haveLands == 6) {
        mapNumbers = @[@"0-60", @"71-81"];
    }
    else if (haveLands == 7) {
        mapNumbers = @[@"0-70", @"71-81"];
    }
    
    mapLine = [SK_PSD createWithPath:@"ui_map_land" name:@"mapLine" loadNumbers:mapNumbers];
    mapLine.position = CGPointMake(0, 0);
    mapLine.zPosition = 0.2;
    [map addChild:mapLine];
    
    jelly = [[MapJelly alloc] initWithLine:mapLine];
    jelly.zPosition = 90.9;
    [map addChild:jelly];
    
    int nowClass = [[[UserCenter dic] objectForKey:@"nowClass"] intValue];
    
    NSArray *mapDic = [UserCenter dic][@"mapLine"];
    
    tipButtonCopy = [SK_Button spriteNodeWithTexture:Atlas(@"ui_map_obj")[9]];
    int mapLineLength = (int)mapLine.children.count;
    
    // !!!:创已开启的关卡的地铺和上浮的奖励道具按钮
    int nowStarNumber = 0;
    for (int idx = 0 ; idx < mapLineLength; idx++) {
        int mapDicNum = [mapLine.lineNumbers[idx] intValue];
        NSString *classString = mapDic[mapDicNum][0];
        SKSpriteNode *obj = mapLine.children[idx];
        if (mapDicNum == nowClass) {
            jelly.position = CGPointMake(obj.position.x, obj.position.y+32);
            [jelly event:^{
                ClassCenter *cc = [ClassCenter singleton];
                cc.nowMapNumber = mapDicNum;
                [self createAGame:mapDicNum classString:classString];
            }];
        }
        if ([mapDic[mapDicNum][0] isEqualToString:@"first"]) {
            SK_Button *tipButton = [tipButtonCopy copy];
            obj.texture = Atlas(@"ui_map_obj")[9];
            obj.size = obj.texture.size;
            
            NSString *prizeString = mapDic[mapDicNum][1];
            NSArray *prizeArray = [prizeString componentsSeparatedByString:@"."];
            NSString *prize = prizeArray[0];
            
            //设置button上的texture
            SKTexture *texture;
            
            if ([prize isEqualToString:@"gold"]) {
                texture = Atlas(@"ui_map_obj")[0];
            }
            else if ([prize isEqualToString:@"cook"]) {
                texture = Atlas(@"ui_map_obj")[1];
            }
            else if ([prize isEqualToString:@"map"]) {
                texture = Atlas(@"ui_map_obj")[2];
            }
            else if ([prize isEqualToString:@"gem"]) {
                if ([prizeArray[1] isEqualToString:@"banana"]){
                    texture = Atlas(@"ui_map_obj")[3];
                }
                else if ([prizeArray[1] isEqualToString:@"boom"]) {
                    texture = Atlas(@"ui_map_obj")[4];
                }
                else if ([prizeArray[1] isEqualToString:@"energy"]) {
                    texture = Atlas(@"ui_map_obj")[5];
                }
                else if ([prizeArray[1] isEqualToString:@"shield"]) {
                    texture = Atlas(@"ui_map_obj")[6];
                }
                else if ([prizeArray[1] isEqualToString:@"ice"]) {
                    texture = Atlas(@"ui_map_obj")[7];
                }
            }
            else if ([prize isEqualToString:@"jelly"]) {
                texture = Atlas(@"ui_map_obj")[15];
            }
            else if ([prize isEqualToString:@"whistle"]) {
                texture = Atlas(@"ui_map_obj")[16];
            }
            
            //创建button
            tipButton.texture = texture;
            tipButton.position = CGPointMake(obj.position.x-3, obj.position.y+36);
            tipButton.zPosition = 91;
//            if(idx == 1) {
//                tipButton.zPosition = 92;
//            }
            tipButton.size = texture.size;
            [map addChild:tipButton];
            
            SKSpriteNode *shadow = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_obj")[11]];
            shadow.zPosition = 1;
            [obj addChild:shadow];
            [tipButton runAction:sa.actionWait];
            [tipButton setScale:1.2];
            
            tipButton.touchMoveNode = _sv;
            tipButton.touchScale = 1.5;
            [tipButton event:^{
                if (isWin == 1) {
                    ClassCenter *cc = [ClassCenter singleton];
                    cc.lastMapNumber = nowClass;
                }
                ClassCenter *cc = [ClassCenter singleton];
                cc.nowMapNumber = mapDicNum;
                [jelly moveTo:mapDicNum lineIdx:idx isLost:0];
            }];
        }
        else if ([classString isEqualToString:@"close"]) {
            
        }
        else {
            NSString *flayAtlasString = @"ui_map_flay_0";
            if ([classString isEqualToString:@"again3"]) {
                nowStarNumber += 3;
                flayAtlasString = @"ui_map_flay_3";
            }
            else if ([classString isEqualToString:@"again2"]) {
                nowStarNumber += 2;
                flayAtlasString = @"ui_map_flay_2";
            }
            else if ([classString isEqualToString:@"again1"]) {
                nowStarNumber += 1;
                flayAtlasString = @"ui_map_flay_1";
            }
            else if ([classString isEqualToString:@"again0"]) {
                flayAtlasString = @"ui_map_flay_0";
            }
            SK_Button *tipButton = [tipButtonCopy copy];
            obj.texture = Atlas(@"ui_map_obj")[9];
            obj.size = obj.texture.size;
            tipButton = [SK_Button spriteNodeWithTexture:Atlas(flayAtlasString)[0]];
            SKAction *anime = [SK_Actions actionAnime:Atlas(flayAtlasString) repeat:0];
            SKAction *wait = [SKAction waitForDuration:skRand(0.012, 0.012*5)];
            SKAction *seq = [SKAction sequence:@[wait, anime]];
            tipButton.position = CGPointMake(obj.position.x+14, obj.position.y+28);
            tipButton.zPosition = 2;
            [tipButton setScale:1.15];
            [map addChild:tipButton];
            [tipButton runAction:seq];
            tipButton.speed = 0.55;
            
            tipButton.touchMoveNode = _sv;
            tipButton.touchScale = 1.5;
            [tipButton event:^{
                if (isWin == 1) {
                    ClassCenter *cc = [ClassCenter singleton];
                    cc.lastMapNumber = nowClass;
                }
                ClassCenter *cc = [ClassCenter singleton];
                cc.nowMapNumber = mapDicNum;
                [jelly moveTo:mapDicNum lineIdx:idx isLost:0];
            }];
        }
    }
    
    // !!!:创建宝箱
    if (haveLands >= 0) {
        Chest *chest1 = [[Chest alloc] initWithNowNumber:nowStarNumber needNumber:25 chestNum:0];
        chest1.position = CGPointMake(1906-10, 1286+10);
        chest1.zPosition = 89;
        [lands addChild:chest1];
    }
    if (haveLands >= 2) {
        Chest *chest2 = [[Chest alloc] initWithNowNumber:nowStarNumber needNumber:80 chestNum:1];
        chest2.position = CGPointMake(2938-10, 1689+10);
        chest2.zPosition = 89;
        [lands addChild:chest2];
    }
    if (haveLands >= 3) {
        Chest *chest3 = [[Chest alloc] initWithNowNumber:nowStarNumber needNumber:125 chestNum:2];
        chest3.position = CGPointMake(1457-10, 3059+10);
        chest3.zPosition = 89;
        [lands addChild:chest3];
    }
    if (haveLands >= 4) {
        Chest *chest4 = [[Chest alloc] initWithNowNumber:nowStarNumber needNumber:170 chestNum:3];
        chest4.position = CGPointMake(2654-10, 4003+10);
        chest4.zPosition = 89;
        [lands addChild:chest4];
    }
    if (haveLands >= 5) {
        Chest *chest5 = [[Chest alloc] initWithNowNumber:nowStarNumber needNumber:210 chestNum:4];
        chest5.position = CGPointMake(3752-10, 3395+10);
        chest5.zPosition = 89;
        [lands addChild:chest5];
    }
    if (haveLands >= 6) {
        Chest *chest6 = [[Chest alloc] initWithNowNumber:nowStarNumber needNumber:240 chestNum:5];
        chest6.position = CGPointMake(4482-10, 2468+10);
        chest6.zPosition = 89;
        [lands addChild:chest6];
    }
    
    [_sv jumpTo:CGPointMake(jelly.position.x*0.9, jelly.position.y*0.9)]; //test 缩放地图之后，刚开始的地图位置
}


-(void)lost
{
    ClassCenter *cc = [ClassCenter singleton];
    [jelly moveTo:cc.lastMapNumber lineIdx:0 isLost:1];
}

-(void)win
{
    int nowClassNumber = [[[UserCenter dic] objectForKey:@"nowClass"] intValue];
//    if (nowClassNumber == 0) {
//        [[UserCenter dic] setValue:@NO forKey:@"isFirst"];
//    }
    [[UserCenter dic] setValue:@NO forKey:@"isFirst"];
    
    NSMutableArray *nowClass = [NSMutableArray array];
    NSMutableArray *nextClass = [NSMutableArray array];
    
    nowClass = [[[UserCenter dic] objectForKey:@"mapLine"] objectAtIndex:nowClassNumber];
    nextClass = [[[UserCenter dic] objectForKey:@"mapLine"] objectAtIndex:nowClassNumber+1];
    
    // !!!:开启分支、新关卡
    if ([nowClass[0] isEqualToString:@"first"]) {
        
    }
    
    if (nowClassNumber >= 16 && nowClassNumber < 25) {
        NSMutableArray *tempClassArray = [NSMutableArray array];
        tempClassArray = [[[UserCenter dic] objectForKey:@"mapLine"] objectAtIndex:71];
        if ([tempClassArray[0] isEqualToString:@"close"]) {
            tempClassArray[0] = @"first";
        }
    }
    else if (nowClassNumber >= 32 && nowClassNumber < 34) {
        NSMutableArray *tempClassArray = [NSMutableArray array];
        tempClassArray = [[[UserCenter dic] objectForKey:@"mapLine"] objectAtIndex:75];
        if ([tempClassArray[0] isEqualToString:@"close"]) {
            tempClassArray[0] = @"first";
        }
    }
    else if (nowClassNumber >= 56 && nowClassNumber < 60) {
        NSMutableArray *tempClassArray = [NSMutableArray array];
        tempClassArray = [[[UserCenter dic] objectForKey:@"mapLine"] objectAtIndex:79];
        if ([tempClassArray[0] isEqualToString:@"close"]) {
            tempClassArray[0] = @"first";
        }
    }
    
    if (isWin == 0) {
        if (![nowClass[0] isEqualToString:@"again1"] && ![nowClass[0] isEqualToString:@"again2"]
            && ![nowClass[0] isEqualToString:@"again3"]) {
            nowClass[0] = @"again0";
        }
    }
    else if (isWin == 1) {
        if (![nowClass[0] isEqualToString:@"again2"] && ![nowClass[0] isEqualToString:@"again3"]) {
            nowClass[0] = @"again1";
        }
    }
    else if (isWin == 2) {
        if (![nowClass[0] isEqualToString:@"again3"]) {
            nowClass[0] = @"again2";
        }
    }
    else if (isWin == 3) {
        nowClass[0] = @"again3";
    }
    [mapLine.children enumerateObjectsUsingBlock:^(SKNode *obj, NSUInteger idx, BOOL *stop) {
        if (idx == nowClassNumber) {
            [obj removeAllChildren];
        }
    }];
    
    //除了赌场不开启，其他赢了都开启下关为first;
    if (nowClassNumber != 77) {
        nextClass[0] = @"first";
    }
    
    [self createStoryWithNumber:nowClassNumber string:@"over" block:nil];
    
    //存盘
    [UserCenter save];
}


-(void)fristCreateGame
{
    if ([[[UserCenter dic] objectForKey:@"isFirst"] boolValue] == NO) {
        return;
    }
    SKSpriteNode *mask = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(iw, ih)];
    mask.alpha = 0.002;
    mask.userInteractionEnabled = YES;
    mask.position = CGPointMake(iw/2, ih/2);
    mask.zPosition = 2999;
    [self addChild:mask];
    
    jelly.hidden = YES;
    SKSpriteNode *ship = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_obj")[13]];
    ship.position = CGPointMake(-180, 1169);
    ship.zPosition = 11;
    [map addChild:ship];
    
    SKAction *move = [SKAction moveTo:CGPointMake(502, 1667) duration:1.5];
    SKAction *moveOut = [SKAction moveTo:CGPointMake(631-50, 1842+50) duration:0.6];
    SKAction *wait = [SKAction waitForDuration:2];
    move.timingMode = SKActionTimingEaseInEaseOut;
    moveOut.timingMode = SKActionTimingEaseInEaseOut;
    SKAction *rest = [SK_Actions actionWater];
    
    soundRocket = [SKAction playSoundFileNamed:@"Sound/map_rocket.mp3" waitForCompletion:0];
    [self runAction:soundRocket];
    
    [ship runAction:move completion:^{
        [jelly runAction:wait completion:^{
            jelly.hidden = NO;
        }];
        [ship runAction:rest];
        [self createStoryWithNumber:0 string:@"begin" block:^{
            [self runAction:soundRocket];
            [ship runAction:moveOut completion:^{
                [mask removeFromParent];
                ViewController *vc = [ViewController single];
                [UserCenter addCook:-1];
                [UserCenter save];
                [vc.mapScene.topBar reloadLabel:^{
                    [vc gotoGameScene:1 classString:@"first"];
//                    [vc.mapScene createAGame:1 classString:@"first"];
                }];
            }];
        }];
    }];
}

@end
