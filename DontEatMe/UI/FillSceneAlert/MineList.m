//
//  MineList.m
//  DontEatMe
//
//  Created by ym on 15/3/5.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "MineList.h"
#import "Story.h"

@implementation MineList
{
    SKSpriteNode *scrollNode;
    NSArray *timeStringArray;
    NSArray *isBetweenDates;
    NSMutableArray *isPlayed;
}

-(void)createInit
{
    ClassCenter *cc = [ClassCenter singleton];
    cc.isOpenFillScene = 3;
    
    [super createInit];
    [self newDates];
    [self newSetScrollNode];
    [self learn];
}

-(void)removeFromParent
{
    [scrollNode removeAllChildren];
    [scrollNode removeFromParent];
    scrollNode = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}


-(void)learn
{
    int isHomeAFirst = [[[UserCenter dic] objectForKey:@"homeABCDFirstIn"][2] intValue];
    if (isHomeAFirst == 0) {
        ViewController *vc = [ViewController single];
        Story *story = [Story createWithNumber:-1 string:iString(@"homeC")];
        story.zPosition = 9001;
        [vc.mapScene addChild:story];
        [[UserCenter dic] objectForKey:@"homeABCDFirstIn"][2] = @1;
        [UserCenter save];
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

-(void)newDates
{
    NSDate *nowDate = [SK_Date nowDate];
    BOOL isTime0 = [SK_Date oneDate:nowDate isBetweenDate:[SK_Date todayWithH:8 m:0 s:0] andDate:[SK_Date todayWithH:8 m:45 s:0]];
    BOOL isTime1 = [SK_Date oneDate:nowDate isBetweenDate:[SK_Date todayWithH:17 m:0 s:0] andDate:[SK_Date todayWithH:18 m:45 s:0]];
    BOOL isTime2 = [SK_Date oneDate:nowDate isBetweenDate:[SK_Date todayWithH:12 m:0 s:0] andDate:[SK_Date todayWithH:12 m:45 s:0]];
    BOOL isTime3 = [SK_Date oneDate:nowDate isBetweenDate:[SK_Date todayWithH:14 m:0 s:0] andDate:[SK_Date todayWithH:14 m:45 s:0]];
    BOOL isTime4 = [SK_Date oneDate:nowDate isBetweenDate:[SK_Date todayWithH:16 m:0 s:0] andDate:[SK_Date todayWithH:16 m:45 s:0]];
    BOOL isTime5 = [SK_Date oneDate:nowDate isBetweenDate:[SK_Date todayWithH:18 m:0 s:0] andDate:[SK_Date todayWithH:18 m:45 s:0]];
    BOOL isTime6 = [SK_Date oneDate:nowDate isBetweenDate:[SK_Date todayWithH:20 m:0 s:0] andDate:[SK_Date todayWithH:20 m:45 s:0]];
    BOOL isTime7 = [SK_Date oneDate:nowDate isBetweenDate:[SK_Date todayWithH:21 m:0 s:0] andDate:[SK_Date todayWithH:21 m:45 s:0]];
    BOOL isTime8 = [SK_Date oneDate:nowDate isBetweenDate:[SK_Date todayWithH:22 m:30 s:0] andDate:[SK_Date todayWithH:23 m:15 s:0]];
    timeStringArray = @[@"8:00~8:45", @"10:00~10:45", @"12:00~12:45", @"14:00~14:45", @"16:00~16:45", @"18:00~18:45", @"20:00~20:45",
                                 @"21:00~21:45", @"22:30~23:15",];
    isBetweenDates = @[@(isTime0), @(isTime1), @(isTime2), @(isTime3), @(isTime4), @(isTime5), @(isTime6), @(isTime7), @(isTime8),];
    
    isPlayed = [[UserCenter dic] objectForKey:@"mineList"];
    NSDate *lastNight = isPlayed[9];
    if ([SK_Date timeDifferenceHourWithNowAndDate:lastNight] > 1) {
        NSDate *toNight = [SK_Date todayWithH:23 m:59 s:0];
        isPlayed = [NSMutableArray arrayWithArray:@[@(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), toNight]];
        [[UserCenter dic] setValue:isPlayed forKey:@"mineList"];
        [UserCenter save];
    }
}

-(void)newSetScrollNode
{
    float ScrollHeight = 3222;
    scrollNode = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(iw, ScrollHeight)];
    [self.scrollView addScrollNode:scrollNode];
    [self.scrollView setScrollNodePosition:CGPointMake(0, ih - ScrollHeight)];
    self.scrollView.bouncesX = YES;
    
    [self createSpriteWithTexture:Atlas(@"ui_map_mine")[0] pos:CGPointMake(320, ScrollHeight - 773+1300) father:scrollNode];
    [self createSpriteWithTexture:Atlas(@"ui_map_mine")[1] pos:CGPointMake(320, ScrollHeight - 2412+1300) father:scrollNode];
    [self createSpriteWithTexture:Atlas(@"ui_map_mine")[2] pos:CGPointMake(320, ScrollHeight - 4224+1300) father:scrollNode];
    
    SKSpriteNode *topImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_mine")[3]];
    topImage.position = CGPointMake(330, ScrollHeight - 255);
    [scrollNode addChild:topImage];
    
    SK_Label *infoTitleLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:45 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    infoTitleLabel.text = iString(@"MineTitle");
    infoTitleLabel.position = CGPointMake(0, 92);
    [topImage addChild:infoTitleLabel];
    
    int line = iSEnglish ? 16 : 8;
    SK_Label *infoLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:line size:28 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeLeft];
    infoLabel.text = iString(@"MineInfo");
    infoLabel.position = CGPointMake(-114, -20);
    [topImage addChild:infoLabel];
    
    StaticActions *sa = [StaticActions single];
    for (int i = 0; i < 9; i++) {
        SK_Button *cell = [SK_Button spriteNodeWithTexture:Atlas(@"ui_map_mine")[5]];
        cell.position = CGPointMake(338, ScrollHeight - (338+260 + i * 278));
        [scrollNode addChild:cell];
        
        cell.touchMoveNode = self.scrollView;
        cell.touchScale = 1.03;
        cell.touchAddzPosition = 0;
        
        SK_Label *goldLabelShadow = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:40 color:rgb(0x000000, 0.3) horizontal:SKLabelHorizontalAlignmentModeCenter];
        goldLabelShadow.text = timeStringArray[i];
        goldLabelShadow.position = CGPointMake(6, -58-4);
        [cell addChild:goldLabelShadow];
        
        SK_Label *goldLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:40 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
        goldLabel.text = goldLabelShadow.text;
        goldLabel.position = CGPointMake(6, -58);
        [cell addChild:goldLabel];
        [cell playSound:sa.sound_buttonB];
        
        if ([isPlayed[i] boolValue] == YES) {
            goldLabel.hidden = YES;
            goldLabelShadow.hidden = YES;
            cell.texture = Atlas(@"ui_map_mine")[6];
        }
        else if ([isBetweenDates[i] boolValue] == YES) {
            goldLabel.hidden = YES;
            goldLabelShadow.hidden = YES;
            [cell playSound:sa.sound_buttonA];
            cell.texture = Atlas(@"ui_map_mine")[4];
            [cell event:^{
                ViewController *vc = [ViewController single];
                [vc.mapScene createAGame:2000+i-1 classString:@"first"];
            }];
        }
    }
    
    [self.scrollView scrollCallBack:^{
        float valueY = 1 - (- self.scrollView.scrollViewY / 350);
        float alpha0 = valueY > 0? valueY : 0;
        float alpha1 = alpha0 <= 1 ? alpha0: 1;
        topImage.alpha = alpha1;
    }];
}

-(void)reloadList
{
    [scrollNode removeFromParent];
    [self newSetScrollNode];
}

@end
