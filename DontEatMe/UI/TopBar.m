//
//  GoldBar.m
//  DontEatMe
//
//  Created by ym on 14-7-4.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "TopBar.h"
#import "Shop.h"

@implementation TopBar
{
    int nowGoldNumber;
    int nowCookNumber;
    SK_Label *timeLabel;
    SK_Label *goldLabel;
    SK_Label *cookLabel;
    SK_Label *cookReloadLabel;
    SK_Label *vipLabel;
    SK_Button *goldButton;
    SK_Button *cookButton;
    SK_Button *vipButton;
    SKAction *addGoldsSound;
    SKAction *addCookSound;
    SKAction *removeCookSound;
    SKSpriteNode *goldAnimeNode;
    SKSpriteNode *cookAnimeNode;
    BOOL isPickTiping;
    int oneSecond;
    int fiveSecond;
}

-(void)removeFromParent
{
    [goldButton removeFromParent];
    goldButton = nil;
    
    [cookButton removeFromParent];
    cookButton = nil;
    
    [vipButton removeFromParent];
    vipButton = nil;
    
    [goldAnimeNode removeFromParent];
    goldAnimeNode = nil;
    
    [cookAnimeNode removeFromParent];
    cookAnimeNode = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}

-(id)init
{
//    float hight = iPhone5? 80:74;
    if (self = [super initWithColor:rgb(0x000000, 0) size:CGSizeMake(iw, 80)]) {
        addGoldsSound = [SKAction playSoundFileNamed:@"Sound/addOneGold.mp3" waitForCompletion:0];
        addCookSound = [SKAction playSoundFileNamed:@"Sound/ui_cook_remove_0.mp3" waitForCompletion:0];
        removeCookSound = [SKAction playSoundFileNamed:@"Sound/ui_cook_remove_1.mp3" waitForCompletion:0];
        self.position = CGPointMake(0, ih+self.size.height/2);
        self.anchorPoint = CGPointMake(0, 0.5);
        self.zPosition = 9999;
        _isCanSee = 1;
        [self createLabels];
        
        SKAction *updateWait = [SKAction waitForDuration:0.9];
        SKAction *updateBlock = [SKAction runBlock:^{
            [self reloadCookLabel];
        }];
        [cookLabel runAction:[SKAction repeatActionForever:[SKAction sequence:@[updateWait, updateBlock]]]];
    }
    return self;
}

-(void)hiddenBackground
{
    return;
    SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, 0) colorBlendFactor:1 duration:0.3];
    [self runAction:color];
}

-(void)showBackground
{
    return;
    SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.3];
    [self runAction:color];
}

-(void)moveDown
{
    [self removeAllActions];
    float hight = iPhone5? 80:74;
    SKAction *move = [SKAction moveToY:ih-hight/2 duration:0.5];
    move.timingMode = SKActionTimingEaseInEaseOut;
    [self runAction:move];
    _isCanSee = 1;
    cookLabel.speed = 1;
}

-(void)moveUp
{
    [self removeAllActions];
    SKAction *move = [SKAction moveToY:ih+110/2  duration:0.5];
    move.timingMode = SKActionTimingEaseInEaseOut;
    [self runAction:move];
    _isCanSee = 0;
    cookLabel.speed = 0;
}

-(void)reloadCookLabel
{
    if (_isCanSee == 0) {
        return;
    }
    
    //读取本函数用到的数据
    int vipDay = [[[UserCenter dic] objectForKey:@"vipDay"] intValue];
    NSDate *last = [[UserCenter dic] objectForKey:@"lastCookTime"];
    NSDate *lastMaxTime = [[UserCenter dic] objectForKey:@"lastMaxCookTime"];
    NSDate *now = [[NSDate alloc] init];
    nowCookNumber = [[[UserCenter dic] objectForKey:@"cook"] intValue];
    int maxCookNumber = [[[UserCenter dic] objectForKey:@"maxCook"] intValue];
    int subTime = (int)[now timeIntervalSinceDate:last];
    int subMaxTime = (int)[now timeIntervalSinceDate:lastMaxTime];
    
    //计算每天消耗的vip
    int nowDay = vipDay - subMaxTime/60/60/24;
    if (nowDay != vipDay) {
        [[UserCenter dic] setValue:@(nowDay) forKey:@"vipDay"];
        [[UserCenter dic] setValue:now forKey:@"lastMaxCookTime"];
        vipDay = [[[UserCenter dic] objectForKey:@"vipDay"] intValue];
    }

    //取消Vip
    if (subMaxTime/60/60/24 > vipDay) {
        [[UserCenter dic] setValue:@0 forKey:@"vipDay"];
        vipDay = [[[UserCenter dic] objectForKey:@"vipDay"] intValue];
    }
    
    //根据Vip改变各node位置
    if (vipDay > 0 && vipButton.hidden == YES) {
        cookButton.position = CGPointMake(140+72, 2);
        vipButton.hidden = NO;
    }
    else if (vipDay <= 0 && vipButton.hidden == NO)  {
        vipButton.hidden = YES;
        cookButton.position = CGPointMake(140, 2);
    }
    
    if (vipDay > 1999 && vipLabel.hidden == NO) {
        vipButton.texture = Atlas(@"ui_games_down")[9];
        vipLabel.hidden = YES;
    }
    vipLabel.text = [NSString stringWithFormat:@"%d", vipDay];

    if (nowCookNumber >= maxCookNumber) {
        cookReloadLabel.hidden = YES;
        return;
    }
    
    NSString *nextCookTimeString;
    
    int reloadTime = 30;
    int mm = (reloadTime - 1) - (int)subTime/60;
    int ss = 59-(int)subTime%60;
    if (mm < 0 ) mm = reloadTime - 1;
    if (ss < 0 || ss >= 60) mm = 60;
    nextCookTimeString = [NSString stringWithFormat:@"%d:%d", mm, ss];
    cookReloadLabel.text = [NSString stringWithFormat:@"%@", nextCookTimeString];
    
    float rloadTime = reloadTime*60;
    if (subTime >= rloadTime) {
        [[UserCenter dic] setValue:now forKey:@"lastCookTime"];
        int addCook;
        if ((int)subTime/rloadTime + nowCookNumber > maxCookNumber) {
            addCook = maxCookNumber-nowCookNumber;
        }
        else {
            addCook = (int)subTime/rloadTime;
        }
        [UserCenter addCook:addCook];
        nowCookNumber = [[[UserCenter dic] objectForKey:@"cook"] intValue];
        cookLabel.text = [NSString stringWithFormat:@"%d/%d", nowCookNumber, maxCookNumber];
        [self runAction:addGoldsSound];
        SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_cookRota") timePerFrame:0.042/1.5 resize:YES restore:NO];
        [cookAnimeNode runAction:anime];
        
        if (cookReloadLabel.hidden == YES) {
            cookReloadLabel.hidden = NO;
        }
    }
}

-(void)createLabels
{
    NSString *nextCookTimeString;
    nowCookNumber = [[[UserCenter dic] objectForKey:@"cook"] intValue];
    int maxCookNumber = [[[UserCenter dic] objectForKey:@"maxCook"] intValue];
    int vipDay = [[[UserCenter dic] objectForKey:@"vipDay"] intValue];
    if (nowCookNumber < maxCookNumber) {
        NSDate *last = [[UserCenter dic] objectForKey:@"lastCookTime"];
        NSDate *now = [[NSDate alloc] init];
        NSTimeInterval subTime = [now timeIntervalSinceDate:last];
        nextCookTimeString = [NSString stringWithFormat:@"%d:%d", 14-(int)subTime/60, 59-(int)subTime%60];
    }
    
    //创建Vip标签
    vipButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_map_topBar")[0]];
    vipButton.position = CGPointMake(36, -7);
    [self addChild:vipButton];
    
    //创建Vip天数
    vipLabel = [SK_Label createLabelWithFont:@"AvenirNextCondensed-HeavyItalic" line:0 size:25 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    vipLabel.text = [NSString stringWithFormat:@"%d", vipDay];
    vipLabel.position = CGPointMake(-2, -4);
    [vipButton addChild:vipLabel];
    

    //创建cookButton
    cookButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_map_topBar")[2]];
    cookButton.position = CGPointMake(140, 2);
    [self addChild:cookButton];
    
    StaticActions *sa = [StaticActions single];
    cookLabel.alpha = 0;
    cookButton.alpha = 0;
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.6];
    [cookLabel runAction:fadeIn];
    [cookButton runAction:fadeIn];
    
    
    //创建cookLabel
    cookLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:36 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    cookLabel.text = [NSString stringWithFormat:@"%d/%d", nowCookNumber, maxCookNumber];
    cookLabel.position = CGPointMake(-15, 0);
    [cookButton addChild:cookLabel];
    
    //创建cookReloadLabel
    cookReloadLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:21 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    cookReloadLabel.text = @""; //[NSString stringWithFormat:@"%@", nextCookTimeString];
    cookReloadLabel.position = CGPointMake(63, 0);
    [cookButton addChild:cookReloadLabel];
    
    //创建cookAnime
    cookAnimeNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_cookRota")[0]];
    cookAnimeNode.position = CGPointMake(-98, 3);
    [cookAnimeNode setScale:0.73];
    [cookButton addChild:cookAnimeNode];
    
    if (nowCookNumber == maxCookNumber) {
        cookReloadLabel.hidden = YES;
    }
    else {
        cookReloadLabel.hidden = NO;
    }
    
    //根据Vip改变各node位置
    if (vipDay > 0) {
        vipButton.hidden = NO;
        cookButton.position = CGPointMake(140+72, 2);
        if (vipDay > 1999) {
            vipButton.texture = Atlas(@"ui_map_topBar")[1];
            vipLabel.hidden = YES;
        }
    }
    else {
        vipButton.hidden = YES;
    }
    
    //创建goldButton
    goldButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_map_topBar")[3]];
    goldButton.position = CGPointMake(511, -1);
    [self addChild:goldButton];
    
    //创建goldLabel
    goldLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:36 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeLeft];
    nowGoldNumber = [[[UserCenter dic] objectForKey:@"gold"] intValue];
    goldLabel.text = [NSString stringWithFormat:@"%d", nowGoldNumber];
    goldLabel.position = CGPointMake(-40, 0);
    [goldButton addChild:goldLabel];
    
    //创建goldAnime
    goldAnimeNode = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_goldRota")[0]];
    goldAnimeNode.position = CGPointMake(-80, 3);
    [goldAnimeNode setScale:0.73];
    [goldButton addChild:goldAnimeNode];
    
    goldLabel.alpha = 0;
    goldButton.alpha = 0;
    [goldLabel runAction:fadeIn];
    [goldButton runAction:fadeIn];
    
    //设定cookButton event
    [cookButton playSound:sa.sound_cook];
    [cookButton event:^{
        ViewController *vc = [ViewController single];
        if (!vc.shop){
            vc.shop = [[Shop alloc] initWith:0];
            if (vc.mapScene) {
                [vc.mapScene addChild:vc.shop];
            }
            else {
                [vc.gameScene addChild:vc.shop];
            }
        }
        else {
            [vc.shop openCookPage];
        }
    }];
    
    //设定vipButton event
    [vipButton playSound:sa.sound_cook];
    [vipButton event:^{
        ViewController *vc = [ViewController single];
        if (!vc.shop){
            vc.shop = [[Shop alloc] initWith:0];
            if (vc.mapScene) {
                [vc.mapScene addChild:vc.shop];
            }
            else {
                [vc.gameScene addChild:vc.shop];
            }
        }
        else {
            [vc.shop openCookPage];
        }
    }];
    
    //设定goldButton event
    [goldButton playSound:sa.sound_gold];
    [goldButton event:^{
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
    }];
}

-(void)reloadLabel:(void(^)())block
{
    int maxCookNumber = [[[UserCenter dic] objectForKey:@"maxCook"] intValue];
    NSString *newGoldString = [NSString stringWithFormat:@"%d", [[[UserCenter dic] objectForKey:@"gold"] intValue]];
    NSString *newCookString = [NSString stringWithFormat:@"%d/%d", [[[UserCenter dic] objectForKey:@"cook"] intValue], maxCookNumber];
    if (goldLabel && ![goldLabel.text isEqualToString:newGoldString]) {
        if (nowGoldNumber < [[[UserCenter dic] objectForKey:@"gold"] intValue]) {
            [self runAction:addGoldsSound];
        }
        else {
            [self runAction:goldButton.sound];
        }
        SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_goldRota") timePerFrame:0.042/1.5 resize:YES restore:NO];
        [goldAnimeNode runAction:anime completion:^{
            if (block) block();
        }];
        goldLabel.text = newGoldString;
    }
    
    if (cookLabel && ![cookLabel.text isEqualToString:newCookString]) {
        if (nowCookNumber < [[[UserCenter dic] objectForKey:@"cook"] intValue]) {
            [self runAction:addCookSound];
            cookLabel.text = newCookString;
        }
        else {
            [self runAction:removeCookSound];
            cookLabel.text = newCookString;
        }
        SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_cookRota") timePerFrame:0.042/1.5 resize:YES restore:NO];
        [cookAnimeNode runAction:anime completion:^{
            if (block) block();
        }];
    }
}

-(void)tipPickCook
{
    if (isPickTiping == NO) {
        isPickTiping = YES;
        SKSpriteNode *pick = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_hand")[0]];
        [pick setScale:0.75];
        pick.position = CGPointMake(5, 40);
        pick.anchorPoint = CGPointMake(0, 1);
        pick.zPosition = 9001;
        [self addChild:pick];
        
        SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_games_hand") timePerFrame:0.042*0.8 resize:YES restore:NO];
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

-(void)tipPickGold
{
    if (isPickTiping == NO) {
        isPickTiping = YES;
        SKSpriteNode *pick = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_hand")[0]];
        [pick setScale:0.75];
        pick.position = CGPointMake(iw-135, 40); //
        pick.anchorPoint = CGPointMake(0, 1);
        pick.zPosition = 9001;
        [self addChild:pick];
        
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


@end
