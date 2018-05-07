//
//  FishFramAlert.m
//  DontEatMe
//
//  Created by ym on 15/2/25.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "FishFramAlert.h"
#import "Story.h"

@implementation FishFramAlert
{
    SKSpriteNode *scrollNode;
}

-(void)createInit
{
    [super createInit];
    ClassCenter *cc = [ClassCenter singleton];
    cc.isOpenFillScene = 1;
    self.backgroup.texture = Atlas(@"ui_map_fishFarm")[5];
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
    int isHomeAFirst = [[[UserCenter dic] objectForKey:@"homeABCDFirstIn"][0] intValue];
    if (isHomeAFirst == 0) {
        ViewController *vc = [ViewController single];
        Story *story = [Story createWithNumber:-1 string:iString(@"homeA")];
        story.zPosition = 90001;
        [vc.mapScene addChild:story];
        [[UserCenter dic] objectForKey:@"homeABCDFirstIn"][0] = @1;
        [UserCenter save];
    }
}

-(void)newSetScrollNode
{
    NSMutableArray *days = [NSMutableArray array];
    NSMutableArray *golds = [NSMutableArray array];
    days = [[[UserCenter dic] objectForKey:@"fishFarm"] objectAtIndex:1];
    golds = [[[UserCenter dic] objectForKey:@"fishFarm"] objectAtIndex:2];
    
    int isOpen = [[[UserCenter dic] objectForKey:@"fishFarm"][0][0] intValue];
    if (isOpen == 1) {
        NSDate *lastDate = [[UserCenter dic] objectForKey:@"fishFarm"][0][1];
        NSDate *nowDate = [SK_Date nowDate];
        int subTime = (int)[nowDate timeIntervalSinceDate:lastDate];
        float nowDay = subTime/60/60/24.0;
        if (nowDay >= 0.75) {
            [days enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
                int isReceive = [obj intValue];
                if (isReceive == 1) {
                    *stop = YES;
                }
                else if (isReceive == 0) {
                    days[idx] = @1;
                    [[UserCenter dic] objectForKey:@"fishFarm"][0][1] = nowDate;
                    [UserCenter save];
                    *stop = YES;
                }
            }];
        }
    }

    int cellNumberl = (int)days.count;
    
    float ScrollHeight = 570+ cellNumberl * 200 + 50;
    scrollNode = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(iw, ScrollHeight)];
    [self.scrollView addScrollNode:scrollNode];
    [self.scrollView setScrollNodePosition:CGPointMake(0, ih - ScrollHeight)];
    self.scrollView.bouncesX = YES;
    
    SKSpriteNode *topImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_fishFarm")[6]];
    topImage.position = CGPointMake(318, ScrollHeight - 280);
    [scrollNode addChild:topImage];
    
    SK_Button *buyButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_map_fishFarm")[7]];
    buyButton.position = CGPointMake(-169, 10);
    [topImage addChild:buyButton];
    
    SK_Label *buyLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:43 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    if (isOpen == 0) {
        buyLabel.text = iString(@"4.99$");
    }
    else {
        buyLabel.text = iString(@"fishFarmBuyed");
    }
    [buyButton addChild:buyLabel];
    
    SK_Label *allGoldLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:60 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    allGoldLabel.position = CGPointMake(134, -112);
    allGoldLabel.text = @"700";
    [topImage addChild:allGoldLabel];
    
    SK_Label *infoTitleLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:52 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    infoTitleLabel.text = iString(@"fishFarmTitle");
    infoTitleLabel.position = CGPointMake(104, 118);
    [topImage addChild:infoTitleLabel];
    
    int line = iSEnglish ? 12 : 7;
    SK_Label *infoLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:line size:32 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeLeft];
    infoLabel.text = iString(@"fishFarmInfo");
    infoLabel.position = CGPointMake(0, -3);
    [topImage addChild:infoLabel];
    
    StaticActions *sa = [StaticActions single];
    [buyButton playSound:sa.sound_buttonA];
    [buyButton event:^{
        if (isOpen == 0) {
            [[ViewController single] buyAlertWithTitle:iString(@"buyFishFarmTitle") message:iString(@"buyFishFarmInfo") type:@"fishFarmOpen" number:1 callBack:^{
                [self reloadList];
            }];
        }
    }];
    
    for (int i = 0; i < cellNumberl; i++) {
        SK_Button *cell = [SK_Button spriteNodeWithTexture:Atlas(@"ui_map_fishFarm")[2]];
        cell.position = CGPointMake(323, ScrollHeight - (584 + i * 200));
        [scrollNode addChild:cell];
        
        cell.touchMoveNode = self.scrollView;
        cell.touchScale = 1.03;
        cell.touchAddzPosition = 0;
        
        SK_Label *goldLabelShadow = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:74 color:rgb(0x000000, 0.3) horizontal:SKLabelHorizontalAlignmentModeLeft];
        goldLabelShadow.text = [NSString stringWithFormat:@"%d", [golds[i] intValue]];
        goldLabelShadow.position = CGPointMake(0, 34-8);
        [cell addChild:goldLabelShadow];
        
        SK_Label *goldLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:74 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeLeft];
        goldLabel.text = goldLabelShadow.text;
        goldLabel.position = CGPointMake(0, 34);
        [cell addChild:goldLabel];
        
        SK_Label *dayLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:28 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeRight];
        NSArray *dayLabelStrArray = [iString(@"fishDayLabels") componentsSeparatedByString:@"*"];
        dayLabel.text = dayLabelStrArray[i];
        dayLabel.position = CGPointMake(257, -30);
        [cell addChild:dayLabel];
        
        SK_Label *usedeLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:30 color:rgb(0x486C8F, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
        usedeLabel.text = iString(@"fishFarmUsede");
        usedeLabel.position = CGPointMake(-250, 37);
        [cell addChild:usedeLabel];
        usedeLabel.hidden = YES;
        
        if ([days[i] intValue] == 0) {
            cell.texture = Atlas(@"ui_map_fishFarm")[4];
        }
        else if ([days[i] intValue] == 1) {
            cell.texture = Atlas(@"ui_map_fishFarm")[2];
            [cell playSound:sa.sound_buttonA];
            [cell event:^{
                if (isOpen == 0) {
                    [[ViewController single] buyAlertWithTitle:iString(@"buyFishFarmTitle") message:iString(@"buyFishFarmInfo") type:@"fishFarmOpen" number:1 callBack:^{
                        [self reloadList];
                    }];
                }
                else {
                    [UserCenter addGold:[golds[i] intValue]];
                    [[ViewController single].mapScene.topBar reloadLabel:nil];
                    cell.texture = Atlas(@"ui_map_fishFarm")[3];
                    [cell playSound:sa.sound_buttonB];
                    [cell event:nil];
                    usedeLabel.hidden = NO;
                    [[[UserCenter dic] objectForKey:@"fishFarm"] objectAtIndex:1][i] = @2;
                    days[i] = @2;
                    [UserCenter save];
                }
            }];
        }
        else if ([days[i] intValue] == 2) {
            cell.texture = Atlas(@"ui_map_fishFarm")[3];
            [cell playSound:sa.sound_buttonB];
            [cell event:nil];
            usedeLabel.hidden = NO;
        }
    }
}

-(void)reloadList
{
    [scrollNode removeFromParent];
    [self newSetScrollNode];
}



@end
