//
//  CookiedHouse.m
//  DontEatMe
//
//  Created by ym on 15/2/27.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CookiedHouse.h"
#import "Story.h"

@implementation CookiedHouse
{
    SKSpriteNode *scrollNode;
}

-(void)createInit
{
    [super createInit];
    ClassCenter *cc = [ClassCenter singleton];
    cc.isOpenFillScene = 2;
    self.backgroup.texture = Atlas(@"ui_map_cookHous")[0];
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
    int isHomeAFirst = [[[UserCenter dic] objectForKey:@"homeABCDFirstIn"][1] intValue];
    if (isHomeAFirst == 0) {
        ViewController *vc = [ViewController single];
        Story *story = [Story createWithNumber:-1 string:iString(@"homeB")];
        story.zPosition = 9001;
        [vc.mapScene addChild:story];
        [[UserCenter dic] objectForKey:@"homeABCDFirstIn"][1] = @1;
        [UserCenter save];
    }
}

-(void)newSetScrollNode
{
    NSMutableArray *days = [NSMutableArray array];
    days = [[UserCenter dic] objectForKey:@"cookiedHouse"];
    
    NSDate *lastDate = [[UserCenter dic] objectForKey:@"cookiedHouse"][2];
    float differenceDay = [SK_Date timeDifferenceDayWithNowAndDate:lastDate];
    if (differenceDay >= 0.75) {
        days[0] = @0;
        if ([SK_Date todayWithH:12 m:0 s:0]) {
            days[1] = @0;
        }
        days[2] = [SK_Date nowDate];
        [UserCenter save];
    }
    
    int cellNumberl = (int)days.count - 1;
    
    float tempHeight = 590+ cellNumberl * 220 + 50;
    float ScrollHeight = tempHeight > ih ? tempHeight : ih;
    scrollNode = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(iw, ScrollHeight)];
    [self.scrollView addScrollNode:scrollNode];
    if (iPhone5) {
        [self.scrollView setScrollNodePosition:CGPointMake(0, ih - ScrollHeight)];
    }
    else {
        [self.scrollView setScrollNodePosition:CGPointMake(0, ih - ScrollHeight + 75)];
    }
    self.scrollView.canTouch = NO;
    
    SKSpriteNode *topImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_cookHous")[1]];
    topImage.position = CGPointMake(320, ScrollHeight - 293);
    [scrollNode addChild:topImage];
    
    
    SK_Label *infoTitleLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:52 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    infoTitleLabel.text = iString(@"cookiedHouseTitle");
    infoTitleLabel.position = CGPointMake(152, 36);
    [topImage addChild:infoTitleLabel];
    
    int line = iSEnglish ? 12 : 7;
    SK_Label *infoLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:line size:32 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeLeft];
    infoLabel.text = iString(@"cookiedHouseInfo");
    infoLabel.position = CGPointMake(32, -76);
    [topImage addChild:infoLabel];
    
    StaticActions *sa = [StaticActions single];
    for (int i = 0; i < cellNumberl; i++) {
        SK_Button *cell = [SK_Button spriteNodeWithTexture:Atlas(@"ui_map_cookHous")[2]];
        cell.position = CGPointMake(323, ScrollHeight - (590 + i * 220) - 100);
        [scrollNode addChild:cell];
        
        cell.touchMoveNode = self.scrollView;
        cell.touchScale = 1.03;
        cell.touchAddzPosition = 0;
        
        SK_Label *goldLabelShadow = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:46 color:rgb(0x000000, 0.3) horizontal:SKLabelHorizontalAlignmentModeLeft];
        if (i == 0) {
            goldLabelShadow.text = iString(@"Breakfast");
        } else {
            goldLabelShadow.text = iString(@"Afternoon Tea");
        }
        
        goldLabelShadow.position = CGPointMake(-2, 26-6);
        [cell addChild:goldLabelShadow];
        
        SK_Label *goldLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:46 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeLeft];
        goldLabel.text = goldLabelShadow.text;
        goldLabel.position = CGPointMake(-2, 26);
        [cell addChild:goldLabel];
        
        SK_Label *usedeLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:30 color:rgb(0x486C8F, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
        usedeLabel.text = iString(@"fishFarmUsede");
        usedeLabel.position = CGPointMake(-250, 37);
        [cell addChild:usedeLabel];
        usedeLabel.hidden = YES;
        
        if ([days[i] intValue] == 1) {
            [cell playSound:sa.sound_buttonB];
            [cell event:nil];
            usedeLabel.hidden = NO;
            cell.texture = Atlas(@"ui_map_cookHous")[3];
        }
        else if ([days[i] intValue] == 0) {
            [cell playSound:sa.sound_buttonA];
            [cell event:^{
                [UserCenter addCook:1];
                [[ViewController single].mapScene.topBar reloadLabel:nil];
                days[i] = @1;
                [UserCenter save];
                [self reloadList];
            }];
        }
        
    }
}

-(void)reloadList
{
    [scrollNode removeFromParent];
    [self newSetScrollNode];
}

@end
