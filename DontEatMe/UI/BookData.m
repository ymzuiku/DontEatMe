//
//  BookData.m
//  DontEatMe
//
//  Created by ym on 15/6/3.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "BookData.h"
#import "FreeJellyProjectVideo.h"
#import "PickNode.h"

@implementation BookData
{
    NSDictionary *jellyDic;
    SKSpriteNode *jellyTip;
    SKSpriteNode *jellyLock;
    int isHave;
    SK_Button *jelly;
    void (^closeBlock)();
    PickNode *pickA;
    PickNode *pickB;
    SK_Sound *sound_shareCallBack;
}

-(id)initWithDic:(NSDictionary *)theDic isHave:(int)theIsHave;
{
    if (self = [super initWithTexture:Atlas(@"ui_book_data")[0]]) {
        self.position = CGPointMake(iw/2+624, ih/2-64);
        jellyDic = theDic;
        isHave = theIsHave;
        [self createData];
        [self createJellyTip];
    }
    return self;
}

-(void)removeFromParent
{
    [jellyTip removeFromParent];
    jellyTip = nil;
    
    [jellyLock removeFromParent];
    jellyLock = nil;
    
    [jelly removeFromParent];
    jelly = nil;
    
    [pickA removeFromParent];
    pickA = nil;
    
    [pickB removeFromParent];
    pickB = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}

-(void)createData
{
    NSString *atlasString = [jellyDic objectForKey:@"atlas"];
    NSString *myNameString = [jellyDic objectForKey:@"myName"];
    NSString *nameString = [jellyDic objectForKey:@"name"];
    NSString *profileString = [jellyDic objectForKey:@"profile"];
    NSString *hpString = [jellyDic objectForKey:@"hp"];
    NSString *attackString = [jellyDic objectForKey:@"attack"];
    NSString *gemA_String = [jellyDic objectForKey:@"gemA"];
    NSString *gemB_String = [jellyDic objectForKey:@"gemB"];
    int price = [[jellyDic objectForKey:@"price"] intValue];
    int isGemA = [[jellyDic objectForKey:@"isGemA"] intValue];
    int isGemB = [[jellyDic objectForKey:@"isGemB"] intValue];
    
    // !!!:创建jelly
    jelly = [SK_Button spriteNodeWithTexture:Atlas(atlasString)[0]];
    jelly.position = CGPointMake(-194-5, 325+10);
    SKAction *anime = [SK_Actions actionAnime:Atlas(atlasString) repeat:0];
    [jelly runAction:anime];
    [self addChild:jelly];
    
    [jelly event:^{
        FreeJellyProjectVideo *jellyVideo = [[FreeJellyProjectVideo alloc] initWithNumber:myNameString];
        jellyVideo.position = cciPhone5Pos(-iw/2, -(ih/2-60), -iw/2, -(ih/2-80));
        [self addChild:jellyVideo];
    }];
    
    if (isHave == 0) {
        jellyLock = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[2]];
        jellyLock.position = CGPointMake(0, -50);
        [jelly addChild:jellyLock];
    }
    
    // !!!:创建名字和简介
    SK_Label *name = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:44 color:rgb(0x5b6240, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    name.position = CGPointMake(64-15, 348+5);
    name.text = nameString;
    [self addChild:name];

    int profile_line = iSEnglish ? 20:12;
    SK_Label *profileLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:profile_line size:24 color:rgb(0x5b6240, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    profileLabel.position = CGPointMake(64-15, 348-45-5);
    profileLabel.text = profileString;
    [self addChild:profileLabel];
    
    // !!!:创建血量和攻击(或者CD）
    SKSpriteNode *hpIcon = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[6]];
    hpIcon.position = CGPointMake(-178-15, 180);
    [self addChild:hpIcon];
    
    int attackOrCd_number = [attackString hasSuffix:@"s"]?8:7;
    SKSpriteNode *attackIcon = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[attackOrCd_number]];
    attackIcon.position = CGPointMake(68-15, 182);
    [self addChild:attackIcon];
    
    SK_Label *hpLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:26 color:rgb(0x5b6240, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
    hpLabel.text = hpString;
    hpLabel.position = CGPointMake(-120-15, 182);
    [self addChild:hpLabel];
    
    SK_Label *attackLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:26 color:rgb(0x5b6240, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
    attackLabel.text = attackString;
    attackLabel.position = CGPointMake(124-15, 182);
    [self addChild:attackLabel];
    
    // !!!:创建技能图标和说明
    NSDictionary *skillDic = @{@"banana":@[@0, @1], @"energy":@[@2, @3], @"iceThin":@[@4, @5], @"shield":@[@6, @7], @"double":@[@8, @9],
                               @"slow":@[@10, @11], @"boom":@[@12, @13], @"highEnergy":@[@14, @15], @"dizzy":@[@16, @17], @"boxer":@[@18, @19], @"iceThick":@[@20, @21],
                               @"strom":@[@22, @23], @"laser":@[@24, @25], @"cure":@[@26, @27], @"iceMist":@[@28, @29], @"aoeBoom":@[@30, @31],
                               @"snail":@[@32, @33], @"iceThorn":@[@34, @35], @"violent":@[@36, @37]};
    int aIcon = [skillDic[myNameString][0] intValue];
    int bIcon = [skillDic[myNameString][1] intValue];
    SKSpriteNode *skillAIcon = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_skillIcon")[aIcon]];
    skillAIcon.position = CGPointMake(-174-15, 38);
    [self addChild:skillAIcon];
    
    SKSpriteNode *skillBIcon = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_skillIcon")[bIcon]];
    skillBIcon.position = CGPointMake(-174-15, -127);
    [self addChild:skillBIcon];
    
    int skill_line = iSEnglish ? 18:12;
    SK_Label *skillALabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:skill_line size:24 color:rgb(0x5b6240, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
    skillALabel.position = CGPointMake(-84-20, 40);
    skillALabel.text = gemA_String;
    [self addChild:skillALabel];
    
    SK_Label *skillBLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:skill_line size:24 color:rgb(0x5b6240, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
    skillBLabel.position = CGPointMake(-84-20, -120);
    skillBLabel.text = gemB_String;
    [self addChild:skillBLabel];
    
    //创建4个按钮
    // !!!:创建宝石A按钮
    if (isGemA > 0) {
        SK_Button *gemAButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_data")[3]];
        gemAButton.position = CGPointMake(-174-15, -17);
        [self addChild:gemAButton];
        
        SK_Label *gemAGoldLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:28 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        gemAGoldLabel.position = CGPointMake(10, 5);
        if (isGemA == 111) {
            gemAGoldLabel.text = iString(@"haveTheGem");
            isGemA = 0;

            pickA = [[PickNode alloc] init];
            pickA.position = CGPointMake(-20, 30);
            pickA.zPosition = 1;
            [gemAButton addChild:pickA];
            
        }
        else {
            gemAGoldLabel.text = [NSString stringWithFormat:@"%d", isGemA];
        }
        [gemAButton addChild:gemAGoldLabel];
        
        // !!!:按钮gemA event
        [gemAButton event:^{
            int nowGold = [[[UserCenter dic] objectForKey:@"gold"] intValue];
            if (nowGold < isGemA) {
                [self createShop];
            }
            else {
                [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:myNameString] setValue:@0 forKey:@"isGemA"];
                [UserCenter addGold:-isGemA];
                SKSpriteNode *gemABuyImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[1]];
                gemABuyImage.position = CGPointMake(-174-15, -15);
                [self addChild:gemABuyImage];
                [self reloadTopBar];
                [gemAButton removeFromParent];
//                sound_shareCallBack = [SK_Sound createNewSound:@"Sound/ui_winGame_1.mp3" repeat:0];
//                [sound_shareCallBack play];
            }
        }];
    }
    else {
        SKSpriteNode *gemABuyImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[1]];
        gemABuyImage.position = CGPointMake(-174-15, -15);
        [self addChild:gemABuyImage];
    }
    
    // !!!:创建宝石B按钮
    if (isGemB > 0) {
        SK_Button *gemBButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_data")[3]];
        gemBButton.position = CGPointMake(-174-15, -15-166);
        [self addChild:gemBButton];
        
        SK_Label *gemBGoldLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:28 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        gemBGoldLabel.position = CGPointMake(10, 5);
        if (isGemB == 111) {
            gemBGoldLabel.text = iString(@"haveTheGem");
            isGemB = 0;
            
            pickB = [[PickNode alloc] init];
            pickB.position = CGPointMake(-20, 30);
            pickB.zPosition = 1;
            [gemBButton addChild:pickB];
        }
        else {
            gemBGoldLabel.text = [NSString stringWithFormat:@"%d", isGemB];
        }
        [gemBButton addChild:gemBGoldLabel];
        
        // !!!:按钮gemB event
        [gemBButton event:^{
            int nowGold = [[[UserCenter dic] objectForKey:@"gold"] intValue];
            if (nowGold < isGemB) {
                [self createShop];
            }
            else {
                [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:myNameString] setValue:@0 forKey:@"isGemB"];
                [UserCenter addGold:-isGemB];
                SKSpriteNode *gemBBuyImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[1]];
                gemBBuyImage.position = CGPointMake(-174-15, -15-162);
                [self addChild:gemBBuyImage];
                [self reloadTopBar];
                [gemBButton removeFromParent];
//                sound_shareCallBack = [SK_Sound createNewSound:@"Sound/ui_winGame_1.mp3" repeat:0];
//                [sound_shareCallBack play];
            }
        }];
    }
    else {
        SKSpriteNode *gemBBuyImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[1]];
        gemBBuyImage.position = CGPointMake(-174-15, -15-162);
        [self addChild:gemBBuyImage];
    }
    
    // !!!:创建解锁jelly按钮
    if (isHave == 0 && price > 0 && price == 111) {  //分享
        SK_Button *buyJellyButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_data")[13]];
        buyJellyButton.position = CGPointMake(-2, -272);
        [self addChild:buyJellyButton];
        
        SK_Label *label= [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:28 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        label.position = CGPointMake(10-4, 5);
        label.text = iString(@"shareFree");
        [buyJellyButton addChild:label];
        
        //分享
        ViewController *vc = [ViewController single];
        sound_shareCallBack = [SK_Sound createNewSound:@"Sound/ui_winGame_1.mp3" repeat:0];
        [buyJellyButton event:^{
//            [vc umShare_block:^{
//                SKAction *anime = [SK_Actions actionAnime:Atlas(@"ui_book_lock") repeat:1];
//                [jellyLock runAction:anime completion:^{
//                    [jellyLock removeFromParent];
//                }];
//                [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:myNameString] setValue:@0 forKey:@"price"];
//                [UserCenter addJelly:myNameString];
//                [buyJellyButton removeFromParent];
////                [self addBuyedImage];
//                [sound_shareCallBack play];
//            }];
        }];
    }
    else if (isHave == 0 && price > 0) {  //购买
        SK_Button *buyJellyButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_data")[4]];
        buyJellyButton.position = CGPointMake(-2, -272);
        [self addChild:buyJellyButton];
        
        SK_Label *label= [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:28 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        label.position = CGPointMake(10, 5);
        label.text = [NSString stringWithFormat:@"%d", price];
        [buyJellyButton addChild:label];
        
        sound_shareCallBack = [SK_Sound createNewSound:@"Sound/ui_winGame_1.mp3" repeat:0];
        [buyJellyButton event:^{
            int nowGold = [[[UserCenter dic] objectForKey:@"gold"] intValue];
            if (nowGold < price) {
                [self createShop];
            }
            else {
                SKAction *anime = [SK_Actions actionAnime:Atlas(@"ui_book_lock") repeat:1];
                [jellyLock runAction:anime completion:^{
                    [jellyLock removeFromParent];
                }];
                [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:myNameString] setValue:@0 forKey:@"price"];
                [UserCenter addJelly:myNameString];
                [UserCenter addGold:-price];
                [self reloadTopBar];
                [buyJellyButton removeFromParent];
//                [self addBuyedImage];
                [sound_shareCallBack play];
            }
        }];
    }
    else if (isHave == 0 && price == 0) {  //未开启
        SKSpriteNode *buyJellyImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[5]];
        buyJellyImage.position = CGPointMake(-15, -272+10);
        [self addChild:buyJellyImage];
        int labelLine = iSEnglish?10:6;
        SK_Label *label= [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:labelLine size:21 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        label.position = CGPointMake(10, -5);
        label.text = iString(@"jellyCanFreeGet");
        [buyJellyImage addChild:label];
    }
    else if (isHave == 1) {
//        [self addBuyedImage];
    }
    
    // !!!:创建关闭按钮
    SK_Button *closeButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_data")[10]];
    closeButton.position = CGPointMake(232, -322);
    [self addChild:closeButton];
    [closeButton event:^{
        if (pickA) {
            [pickA removeFromParent];
        }
        if (pickB) {
            [pickB removeFromParent];
        }
        closeBlock();
    }];
}

-(void)addBuyedImage
{
    SKSpriteNode *buyJellyImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[14]];
    buyJellyImage.position = CGPointMake(-15, -272+10);
    [self addChild:buyJellyImage];
}

-(void)reloadTopBar
{
    ViewController *vc = [ViewController single];
    if (vc.mapScene) {
        [vc.mapScene.topBar reloadLabel:nil];
    }
    else if (vc.gameScene) {
        [vc.gameScene.topBar reloadLabel:nil];
    }
}

-(void)createJellyTip
{
    int bookProfileJellyButtonTouch = [[[[UserCenter dic] objectForKey:@"userRecord"] objectForKey:@"bookProfileJellyButtonTouch"] intValue];
    if ( bookProfileJellyButtonTouch > 1) {
        return;
    }
    
    jellyTip = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_data")[9]];
    jellyTip.position = CGPointMake(49, 46);
    jellyTip.alpha = 0;
    [jellyTip setScale:0.8];
    [jelly addChild:jellyTip];
    [jellyTip runAction:[SK_Actions actionWait]];
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.65];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.65];
    SKAction *waitTip = [SKAction waitForDuration:2.5];
    SKAction *blockTip = [SKAction runBlock:^{
        [jellyTip runAction:fadeIn];
    }];
    SKAction *waitTip2 = [SKAction waitForDuration:3.5];
    SKAction *blockTIp2 = [SKAction runBlock:^{
        [jellyTip runAction:fadeOut];
    }];
    SKAction *seqTip = [SKAction sequence:@[waitTip, blockTip, waitTip2, blockTIp2]];
    [self runAction:seqTip];
}


-(void)closeBlock:(void (^) ())block
{
    closeBlock = block;
}

-(void)createShop
{
    ViewController *vc = [ViewController single];
    if (!vc.shop){
        vc.shop = [[Shop alloc] initWith:1];
        if (vc.mapScene) {
            [vc.mapScene addChild:vc.shop];
        }
        else {
            [vc.gameScene addChild:vc.shop];
        }
    }
    else {
        [vc.shop openGoldPage];
    }
    
}

@end
