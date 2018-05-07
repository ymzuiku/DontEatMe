//
//  SelectJellys.m
//  DontEatMe
//
//  Created by ym on 14/7/6.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "SelectJellys.h"

@implementation SelectJellys
{
    BOOL isMiddle;
    SKSpriteNode *selectLabelImage;
    SKSpriteNode *canvas;
    SKSpriteNode *lawn;
    SK_Button *doneButton;
    SK_Label *selectLabel;
    int pickNumbers;
    BOOL isHaveEnergyJelly;
    BOOL isPickTiping;
    BOOL isTempReloadDoneButton;
    SKAction *selectAJellySound;
    SKSpriteNode *longTouchTipBox;
    int isUserLongTouchJelly;
}


-(void)removeFromParent
{
    [selectLabelImage removeFromParent];
    selectLabelImage = nil;
    
    [doneButton removeFromParent];
    doneButton = nil;
    
    [_bookData removeAllChildren];
    [_bookData removeFromParent];
    _bookData = nil;
    
    [lawn removeAllChildren];
    [lawn removeFromParent];
    lawn = nil;
    
    [canvas removeAllChildren];
    [canvas removeFromParent];
    canvas = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}

-(id)init
{
    if (self = [super initWithColor:rgb(0x000000, 0.0) size:CGSizeMake(iw, ih)]) {
        self.userInteractionEnabled = YES;
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        [self testGame];    //test
    }
    return self;
}

-(void)testGame
{
    ViewController *vc = [ViewController single];
    StaticActions *sa = [StaticActions single];
    SK_Button *revie = [SK_Button spriteNodeWithColor:rgb(0x000000, 0.2) size:CGSizeMake(120, 120)];
    revie.position = CGPointMake(iw/2, ih - 130);
    revie.zPosition = 5000;
    [self addChild:revie];
    [revie playSound:sa.sound_buttonA];
    [revie event:^{
        [vc.gameScene.war winCallBack];
        [vc.gameScene winner];
    }];
}

-(void)createInit
{
    [self createLawn];
    [self createJellys];
    [self moveWindow];
    selectAJellySound = [SKAction playSoundFileNamed:@"Sound/jelly_touch_2.mp3" waitForCompletion:0]; //selectAJellySound.volume = 0.6;
}

-(void)createLawn
{
    pickNumbers = [[[UserCenter dic] objectForKey:@"pickNum"] intValue];
    canvas = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(iw, ih)];
    canvas.anchorPoint = CGPointMake(0, 0);
    canvas.position = CGPointMake(0, 0);
    [self addChild:canvas];
    
    lawn = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_lawn")[0]];
    lawn.anchorPoint = CGPointMake(0, 0);
    lawn.position = cciPhone5Pos(16, -50,
                                 16, -150);
    [canvas addChild:lawn];
    
    doneButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_lawn")[2]];
    doneButton.position = CGPointMake(553-20, 274+20);
    doneButton.alpha = 0.5;
    [lawn addChild:doneButton];
    
    StaticActions *sa = [StaticActions single];
    [doneButton playSound:sa.sound_buttonA];
    [doneButton event:^{
        if (doneButton.alpha > 0.6 && isHaveEnergyJelly == YES) {
            [self moveWindow];
        }
        else if (doneButton.alpha > 0.6 && isHaveEnergyJelly == NO) {
            [self tipPickEnergyJelly];
        }
        else if (doneButton.alpha <= 0.6) {
            [self tipPickNumberLabel];
        }
    }];
    
    selectLabelImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_lawn")[11]];
    selectLabelImage.position = cciPhone5Pos(iw/2, 965,
                                             iw/2, 820);
    [self addChild:selectLabelImage];
    selectLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:40 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    selectLabel.text = [NSString stringWithFormat:@"%@0/%d", iString(@"selectJelly"),pickNumbers];
    [selectLabelImage addChild:selectLabel];
    
    //创建一个长按的教程小tip
    isUserLongTouchJelly = [[[[UserCenter dic] objectForKey:@"userRecord"] objectForKey:@"isUserLongTouchJelly"] intValue];
    if (isUserLongTouchJelly == 0 && _classNumber > 2) {
        longTouchTipBox = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_lawn")[17]];
        longTouchTipBox.position = CGPointMake(303, 423);
        longTouchTipBox.zPosition = 20;
        [lawn addChild:longTouchTipBox];
        
        int line = iSEnglish ? 20 : 12;
        SK_Label *longTouchTipLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:line size:32 color:rgb(0xa1a019, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        longTouchTipLabel.text = iString(@"longTouchTip");
        longTouchTipLabel.position = CGPointMake(0, 0);
        [longTouchTipBox addChild:longTouchTipLabel];
        
        SK_Button *closeLongTouchTipBoxButton = [[SK_Button alloc] initWithTexture:Atlas(@"ui_book_lawn")[18]];
        closeLongTouchTipBoxButton.position = CGPointMake(-209, 49);
        [longTouchTipBox addChild:closeLongTouchTipBoxButton];
        
        [closeLongTouchTipBoxButton event:^{
            [longTouchTipBox removeFromParent];
        }];
    }
}

-(void)tipPickEnergyJelly
{
    if (isPickTiping == NO) {
        isPickTiping = YES;
        SKSpriteNode *pick = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_hand")[0]];
        [pick setScale:0.75];
        pick.position = CGPointMake(190, 890);
        pick.anchorPoint = CGPointMake(0, 1);
        pick.zPosition = 100;
        [lawn addChild:pick];
        
        SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_hand") timePerFrame:0.042*0.8 resize:YES restore:YES];
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.3/2];
        SKAction *seq = [SKAction sequence:@[anime, anime, fadeOut]];
        
        SKAction *waitSound_0 = [SKAction waitForDuration:anime.duration/2];
        SKAction *waitSound_1 = [SKAction waitForDuration:anime.duration];
        SKAction *block_0 = [SKAction runBlock:^{
            StaticActions *sa = [StaticActions single];
            [self runAction:sa.sound_pickTouch_0];
        }];
        
        SKAction *seq2 = [SKAction sequence:@[waitSound_0, block_0, waitSound_1, block_0]];
        SKAction *group = [SKAction group:@[seq, seq2]];
        
        [pick runAction:group completion:^{
            [pick removeFromParent];
            isPickTiping = NO;
        }];
    }
}

-(void)tipPickNumberLabel
{
    if (isPickTiping == NO) {
        isPickTiping = YES;
        SKSpriteNode *pick = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_hand")[0]];
        [pick setScale:0.75];
        SKAction *moveRight = [SKAction moveByX:185 y:0 duration:0.7];
        moveRight.timingMode = SKActionTimingEaseInEaseOut;
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.3];
        SKAction *seq = [SKAction sequence:@[moveRight,fadeOut]];
        pick.position = CGPointMake(190-45, 890+150);
        pick.anchorPoint = CGPointMake(0, 1);
        pick.zPosition = 100;
        [lawn addChild:pick];
        [pick runAction:seq completion:^{
            [pick removeFromParent];
            isPickTiping = NO;
        }];
    }
}

-(void)moveWindow
{
    StaticActions *sa = [StaticActions single];
    if (!isMiddle) {
        self.paused = NO;
        //移动视图
        canvas.position = CGPointMake(0, -canvas.size.height);
        [canvas runAction:sa.actionSpringUpWindow];
        
        //背景发灰
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.3*1.8];
        [self runAction:color];
        isMiddle = YES;
    }
    else if (isMiddle) {
        //移动视图
        [canvas runAction:sa.actionSpringDownWindow];
        
        ViewController *vc = [ViewController single];
        //背景透明
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, 0) colorBlendFactor:1 duration:0.3*1.8];
        [self runAction:color completion:^{
            [vc.gameScene startGame];
            [self removeAllChildren];
            [self removeFromParent];
        }];
        
        isMiddle = NO;
    }
}

-(void)createJellys
{
    NSDictionary *jellyData = [[UserCenter dic] objectForKey:@"jellyData"];
    NSMutableArray *haveJellys = [[UserCenter dic] objectForKey:@"haveJellys"];
    for (int idx = 0; idx< haveJellys.count; idx++) {
        NSDictionary *jellyDic = [jellyData objectForKey:haveJellys[idx]];
        
        SK_Button *jelly;
        if ([jelly.name isEqualToString:@"iceThin"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[0]];
        }
        else if ([jelly.name isEqualToString:@"iceThick"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[1]];
        }
        else if ([jelly.name isEqualToString:@"iceThorn"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[2]];
        }
        else if ([jelly.name isEqualToString:@"iceMist"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[3]];
        }
        else if ([jelly.name isEqualToString:@"dizzy"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[4]];
        }
        else if ([jelly.name isEqualToString:@"aoeBoom"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[5]];
        }
        else {
            jelly = [SK_Button spriteNodeWithTexture:Atlas([jellyDic objectForKey:@"atlas"])[0]];
        }
        
        float xx = 140;
        float yy = 116;
        int line = idx / 4;
        int num = idx % 4;
        jelly.position = CGPointMake(88 + num * xx, 824 - line * yy);
        jelly.name = [jellyDic objectForKey:@"myName"];
        jelly.number = idx;
        [jelly setScale:[[jellyDic objectForKey:@"scale"] floatValue]];
        [lawn addChild:jelly];
        
        if ([jelly.name isEqualToString:@"iceThin"] || [jelly.name isEqualToString:@"iceMist"] ||
            [jelly.name isEqualToString:@"iceThorn"] || [jelly.name isEqualToString:@"iceThick"] ||
            [jelly.name isEqualToString:@"aoeBoom"] || [jelly.name isEqualToString:@"dizzy"]) {
            
        }
        else {
            float waitTime = (rand()/(float)RAND_MAX);
            SKAction *wait = [SKAction waitForDuration:waitTime];
            SKAction *anime = [SK_Actions actionAnime:Atlas([jellyDic objectForKey:@"atlas"]) repeat:0];
            [jelly runAction:wait completion:^{
                [jelly runAction:anime];
            }];
        }
        
        int price = [[jellyDic objectForKey:@"price"] intValue];
        if (price > 0) {
            SKTexture *buySpriteTex;
            if ([[jellyDic objectForKey:@"price"] intValue] > 999) {
                buySpriteTex = Atlas(@"ui_book_lawn")[14];
            }
            else {
                buySpriteTex = Atlas(@"ui_book_lawn")[4];
            }
            SKSpriteNode *buySprite = [SKSpriteNode spriteNodeWithTexture:buySpriteTex];
            buySprite.name = @"buy";
            buySprite.position = CGPointMake(0, -38-12);
            [jelly addChild:buySprite];
            NSString *string = [NSString stringWithFormat:@"%d", [[jellyDic objectForKey:@"price"] intValue]];
            SK_Label *label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:24 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
            label.text = string;
            label.position = CGPointMake(-13, 3);
            label.icon = Atlas(@"ui_book_lawn")[8];
            [buySprite addChild:label];
            [buySprite setScale:1/[[jellyDic objectForKey:@"scale"] floatValue]];
        }
        
        SKSpriteNode *selectImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_lawn")[10]];
        selectImage.position = CGPointMake(30, -30);
        selectImage.hidden = YES;
        selectImage.name = @"selectImage";
        [jelly addChild:selectImage];
        
        ClassCenter *cc = [ClassCenter singleton];
        cc.classJellyNames = [NSMutableDictionary dictionary];
        NSString *type = jelly.name;
        
        [jelly event:^{
            [self runAction:selectAJellySound];
            if ([[jellyDic objectForKey:@"price"] intValue] > 0) {
                _bookData = [[BookData alloc] initWithDic:jellyDic isHave:1];
                [canvas addChild:_bookData];
                [self bookDataMoveIn];
                [_bookData closeBlock:^{
                    [self bookDataMoveOut];
                }];
            }
            else {
                if ([jelly.name isEqualToString:@"energy"] || [jelly.name isEqualToString:@"highEnergy"]) {
                    isHaveEnergyJelly = YES;
                }
                if (selectImage.hidden == NO) {
                    selectImage.hidden = YES;
                    [cc.classJellyNames removeObjectForKey:type];
                    [self reloadDoneButton:NO];
                }
                else if (selectImage.hidden == YES && cc.classJellyNames.count < pickNumbers){
                    selectImage.hidden = NO;
                    [cc.classJellyNames setValue:type forKey:type];
                    [self reloadDoneButton:NO];
                }
            }
            
            if (cc.classJellyNames.count >= pickNumbers) {
                [self reloadDoneButton:YES];
                isTempReloadDoneButton = YES;
            }
            else if (cc.classJellyNames.count < pickNumbers && isTempReloadDoneButton){
                [self reloadDoneButton:YES];
                isTempReloadDoneButton = NO;
            }
        }];
        
        [jelly longEvent:^{
            if (isUserLongTouchJelly == 0) {
                [longTouchTipBox removeFromParent];
                [[[UserCenter dic] objectForKey:@"userRecord"] setValue:@1 forKey:@"isUserLongTouchJelly"];
            }
            StaticActions *sa = [StaticActions single];
            [self runAction:sa.sound_buttonA];
            _bookData = [[BookData alloc] initWithDic:jellyDic isHave:1];
            [canvas addChild:_bookData];
            [self bookDataMoveIn];
            [_bookData closeBlock:^{
                [self bookDataMoveOut];
            }];
        }];
    }
}

-(void)reloadDoneButton:(BOOL)isCheckEnergy
{
    ClassCenter *cc = [ClassCenter singleton];
    if (isCheckEnergy) {
        isHaveEnergyJelly = NO;
        [cc.classJellyNames enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *name = (NSString *)obj;
            if ([name isEqualToString:@"energy"] || [name isEqualToString:@"highEnergy"]) {
                isHaveEnergyJelly = YES;
            }
        }];
        
        if (cc.classJellyNames.count < pickNumbers) {
            doneButton.alpha = 0.5;
        }else {
            doneButton.alpha = 1;
        }
    }
    selectLabel.text = [NSString stringWithFormat:@"%@%d/%d", iString(@"selectJelly"), (int)cc.classJellyNames.count, pickNumbers];
}

-(void)hiddenJellyGoldTip:(NSString *)jellyName
{
    SKSpriteNode *jelly = (SKSpriteNode *)[lawn childNodeWithName:jellyName];
    SKSpriteNode *buySprite = (SKSpriteNode *)[jelly childNodeWithName:@"buy"];
    [buySprite removeFromParent];
}

-(void)bookDataMoveIn
{
    SKAction *moveIn = [SKAction moveToX:-590 duration:0.2];
    moveIn.timingMode = SKActionTimingEaseInEaseOut;
    [canvas runAction:moveIn];
    [selectLabelImage runAction:moveIn];
}

-(void)bookDataMoveOut
{
    SKAction *moveOut = [SKAction moveToX:0 duration:0.2];
    moveOut.timingMode = SKActionTimingEaseInEaseOut;
    [canvas runAction:moveOut completion:^{
        [_bookData removeFromParent];
    }];
    SKAction *moveImageOut = [SKAction moveTo:cciPhone5Pos(iw/2, 965, iw/2, 820) duration:0.2];
    [selectLabelImage runAction:moveImageOut];
}


@end
