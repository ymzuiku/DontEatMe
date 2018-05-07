//
//  DateList.m
//  DontEatMe
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "UserCenter.h"

#define plistName @"spark_2.png"
static NSMutableDictionary *tempDic;

@implementation UserCenter

+(void)addMaxCookTime:(int)day
{
    int allDay = [[[UserCenter dic] objectForKey:@"vipDay"] intValue] + day;
    if (allDay < 0) {
        allDay = 0;
    }
    if (allDay > 0) {
        [[UserCenter dic] setValue:@20 forKey:@"maxCook"];
    }
    else {
        [[UserCenter dic] setValue:@10 forKey:@"maxCook"];
    }
    
    if ([[[UserCenter dic] objectForKey:@"vipDay"] intValue] <= 0) {
        NSDate *last = [[NSDate alloc] init];
        [[UserCenter dic] setValue:last forKey:@"lastMaxCookTime"];
    }
    
    [tempDic setValue:@(allDay) forKey:@"vipDay"];
    [self save];
}

+(void)addMaxCook
{
    int cook = [[[UserCenter dic] objectForKey:@"cook"] intValue];
    int maxCook = [[[UserCenter dic] objectForKey:@"maxCook"] intValue];
    if (maxCook > cook) {
        [tempDic setValue:@(maxCook) forKey:@"cook"];
        [self save];
    }
}
 
+(void)addCook:(int)num
{
    int cook = [[[UserCenter dic] objectForKey:@"cook"] intValue] + num;
    if (cook < 0) {
        cook = 0;
    }
    [tempDic setValue:@(cook) forKey:@"cook"];
    [self save];
}

+(void)addGold:(int)num
{
    int gold = [[tempDic objectForKey:@"gold"] intValue] + num;
    if (gold < 0) gold = 0;
    [tempDic setValue:@(gold) forKey:@"gold"];
    [self save];
}

+(void)addJelly:(NSString *)jellyName
{
    BOOL isHavedJelly = NO;
    for (NSString *name in [tempDic objectForKey:@"haveJellys"]) {
        if ([name isEqualToString:jellyName]) {
            isHavedJelly = YES;
        }
    }
    if (isHavedJelly == NO) {
        [[[UserCenter dic] objectForKey:@"haveJellys"] addObject:jellyName];
        [[[UserCenter dic] objectForKey:@"noHaveJellys"] removeObject:jellyName];
        [self addPickNumber];
        [self save];
    }
}

+(void)addJellyPro
{
    int jelly = [[[UserCenter dic] objectForKey:@"haveJelly"] intValue] + 1;
    if (jelly > 19) {
        jelly = 19;
    }
    [tempDic setValue:@(jelly) forKey:@"haveJelly"];
    [self save];
}


+(void)addPickNumber
{
    int pickNum = [[[UserCenter dic] objectForKey:@"pickNum"] intValue] + 1;
    if (pickNum > 8) {
        pickNum = 8;
    }
    [tempDic setValue:@(pickNum) forKey:@"pickNum"];
    [self save];
}

+(void)addLand
{
    int lands = [[[UserCenter dic] objectForKey:@"lands"] intValue] + 1;
    if (lands == 4) {
        lands = 5;
    }
    else if (lands > 6) {
        lands = 6;
    }
    [tempDic setValue:@(lands) forKey:@"lands"];
    [self save];
}

+(void)addGem:(NSString *)string
{
    NSArray *array = [string componentsSeparatedByString:@"."];
    NSString *jellyKey = array[1];
    NSString *gemAorB = [array[2] isEqualToString:@"A"]?@"isGemA":@"isGemB";
    [[[tempDic objectForKey:@"jellyData"] objectForKey:jellyKey] setValue:@0 forKey:gemAorB];
    [self save];
}

+(void)setNowClass:(int)number
{
    [tempDic setValue:@(number) forKey:@"nowClass"];
    [self save];
}

+(void)save
{
    [self writePlistWithDic:tempDic name:nil];
}

+(void)writePlistWithDic:(NSDictionary *)dic name:(NSString *)name
{
    if (name == nil) {
        NSMutableData *date = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:date];
        [archiver encodeObject:dic forKey:@"arch0t"];
        [archiver finishEncoding];
        
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *file = [[path objectAtIndex:0] stringByAppendingPathComponent:plistName];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:file]) {
            NSString *file2 = [[path objectAtIndex:0] stringByAppendingPathComponent:@"spark_1.png"];
            [date writeToFile:file2 atomically:YES];
            
            NSString *file3 = [[path objectAtIndex:0] stringByAppendingPathComponent:@"mail_1.png"];
            [date writeToFile:file3 atomically:YES];
            
            NSString *file4 = [[path objectAtIndex:0] stringByAppendingPathComponent:@"mail_2.png"];
            [date writeToFile:file4 atomically:YES];
        }
        [date writeToFile:file atomically:YES];
    }
    else {
        NSMutableData *date = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:date];
        [archiver encodeObject:dic forKey:@"arch0t"];
        [archiver finishEncoding];
        
        NSString *file = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        [date writeToFile:file atomically:YES];
    }
}

+(NSMutableDictionary *)dic
{
    return tempDic;
}

+(void)createNewDic
{
    tempDic = [NSMutableDictionary dictionaryWithDictionary:[UserCenter firstDic]];
    NSDate *nowTime = [[NSDate alloc] init];
    [tempDic setValue:nowTime forKey:@"lastCookTime"];
    [tempDic setValue:nowTime forKey:@"lastMaxCookTime"];
    [UserCenter save];
}

+(void)createDic
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *file = [[path objectAtIndex:0] stringByAppendingPathComponent:plistName];
//    NSLog(@"%@", file);
    if (![[NSFileManager defaultManager] fileExistsAtPath:file]) {
        tempDic = [NSMutableDictionary dictionaryWithDictionary:[UserCenter firstDic]];
        NSDate *nowTime = [[NSDate alloc] init];
        [tempDic setValue:nowTime forKey:@"lastCookTime"];
        [tempDic setValue:nowTime forKey:@"lastMaxCookTime"];
        [UserCenter save];
    }
    else {
        NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:file];
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        tempDic = [unArchiver decodeObjectForKey:@"arch0t"];
        [unArchiver finishDecoding];
    }
    if ([[tempDic objectForKey:@"id"] intValue] != 18) {
        tempDic = nil;
    }
}



//------------------------------------  初始化新的Dic  ------------------------------------
// !!!:初始化新的Dic

+(NSDictionary *)firstDic
{
    //@"haveJelly": @1,   //1-19
    NSDictionary *dic = @{@"haveJellys": [UserCenter haveJellys],
                          @"noHaveJellys": [UserCenter noHaveJellys],
                          @"pickNum": @1,     //1-8
                          @"music": @YES,
                          @"gold": @0,
                          @"cook": @6,
                          @"maxCook": @10,
                          @"id": @18,
                          @"jellyData": [UserCenter jellyData],
                          @"mapLine" : [UserCenter mapLine],
                          @"userRecord": [UserCenter userRecord],
                          @"lands": @0,
                          @"nowClass": @0,
                          @"isFirst": @YES,
                          @"isOpenDifficulty": @NO,
                          @"lastCookTime": @0,
                          @"lastMaxCookTime": @0,
                          @"vipDay": @0,
                          @"otherClass": [UserCenter otherClass],
                          @"fishFarm" : [UserCenter fishFarmList],
                          @"cookiedHouse": [UserCenter cookiedHouseList],
                          @"mineList": [UserCenter mineList],
                          @"chestIsOpen": [UserCenter chestIsOpen],
                          @"homeABCDFirstIn": [UserCenter homeABCDFirstIn],
                          };
    return dic;
}

+(NSMutableArray *)homeABCDFirstIn
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@0, @0, @0, @0]];
    return arr;
}

+(NSMutableArray *)noHaveJellys
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@"energy", @"iceThin", @"shield",
                                                           @"double", @"slow", @"boom", @"dizzy",
                                                           @"iceThick", @"laser", @"cure", @"aoeBoom",
                                                           @"iceThorn", @"violent", @"boxer", @"highEnergy",
                                                           @"iceMist", @"strom", @"snail"]];
    return arr;
}

+(NSMutableArray *)haveJellys
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:
                           @[@"banana"]];
    return arr;
}

+(NSMutableArray *)chestIsOpen
{
    return [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0]];
}

+(NSMutableDictionary *)userRecord
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"bookProfileJellyButtonTouch" : @0,
                                                                               @"freeHammer" : @2,
                                                                               @"whistle": @0,
                                                                               @"isUserLongTouchJelly": @0,}];
    return dic;
}

+(NSMutableDictionary *)otherClass
{
    NSDictionary *dic = @{@"1000":@1, @"1001":@1, @"1002":@1, @"1003":@1, @"1004":@1, @"1005":@1, @"1006":@1, @"1007":@1, @"1008":@1, @"1009":@1,
                          @"1010":@1, @"1011":@1, @"1012":@1, @"1013":@1, @"1014":@1, @"1015":@1, @"1016":@1, @"1017":@1, @"1018":@1, @"1019":@1,};
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    return muDic;
}

+(NSArray *)fishFarmList
{
    NSMutableArray *isOpen = [NSMutableArray arrayWithArray:@[@0, @0]];
    NSMutableArray *days = [NSMutableArray arrayWithArray:@[@1, @0, @0, @0, @0, @0, @0, @0]];
    NSMutableArray *golds = [NSMutableArray arrayWithArray:@[@20, @30, @40, @50, @60, @100, @150, @250]];
    return @[isOpen, days, golds];
}

+(NSMutableArray *)cookiedHouseList
{
    NSMutableArray *days = [NSMutableArray arrayWithArray:@[@0, @0, [SK_Date nowDate]]];
    return days;
}

+(NSMutableArray *)mineList
{
    NSDate *toNight = [SK_Date todayWithH:23 m:59 s:0];
    NSMutableArray *isPlayed = [NSMutableArray arrayWithArray:@[@(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), toNight]];
    return isPlayed;
}

+(NSArray *)mapLine
{
    //close, first, adventurer, brave, king
    //cook.2, gold.2, jelly.12, map.2, jellyPro.15
    //type: banana, ice...., boom, spoon,
    //stroy0~N;
    //gem.banana\ gem.boom \gem.energy \gem.shield \gem.ice \whistle.1
    NSMutableArray *c1 = [NSMutableArray arrayWithArray:@[@"close",@"gold.1",
                                                          @{@"begin":iString(@"s1"), @"over": iString(@"s1v")}]];
    
    NSMutableArray *c2 = [NSMutableArray arrayWithArray:@[@"close",@"jelly.1",
                                                          @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c3 = [NSMutableArray arrayWithArray:@[@"close",@"jelly.1",
                                                          @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c4 = [NSMutableArray arrayWithArray:@[@"close",@"map.1",
                                                         @{@"over": iString(@"s4v"), @"begin": @""}]];
    
    NSMutableArray *c5 = [NSMutableArray arrayWithArray:@[@"close",@"gem.ice",
                                                          @{@"over": iString(@"s5v"), @"begin": @""}]];
    
    NSMutableArray *c6 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                          @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c7 = [NSMutableArray arrayWithArray:@[@"close",@"whistle.1",
                                                          @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c8 = [NSMutableArray arrayWithArray:@[@"close",@"jelly.1",
                                                          @{@"over": iString(@"s8v"), @"begin": @""}]];
    
    NSMutableArray *c9 = [NSMutableArray arrayWithArray:@[@"close",@"jelly.1",
                                                          @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c10 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                          @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c11 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c12 = [NSMutableArray arrayWithArray:@[@"close",@"map.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c13 = [NSMutableArray arrayWithArray:@[@"close",@"jelly.1",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c14 = [NSMutableArray arrayWithArray:@[@"close",@"gem.boom",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c15 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c16 = [NSMutableArray arrayWithArray:@[@"close",@"gem.banana",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c17 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c18 = [NSMutableArray arrayWithArray:@[@"close",@"jelly.1",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c19 = [NSMutableArray arrayWithArray:@[@"close",@"gem.energy",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c20 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c21 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c22 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": iString(@"s22v"), @"begin": @""}]];
    
    NSMutableArray *c23 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c24 = [NSMutableArray arrayWithArray:@[@"close",@"jelly.1",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c25 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c26 = [NSMutableArray arrayWithArray:@[@"close",@"map.1",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c27 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c28 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c29 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c30 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c31 = [NSMutableArray arrayWithArray:@[@"close",@"gem.banana",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c32 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c33 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": iString(@"s33v"), @"begin": @""}]];
    
    NSMutableArray *c34 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c35 = [NSMutableArray arrayWithArray:@[@"close",@"map.4",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c36 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c37 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c38 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c39 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c40 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c41 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c42 = [NSMutableArray arrayWithArray:@[@"close",@"jelly.1",
                                                           @{@"over": iString(@"s42v"), @"begin": @""}]];
    
    NSMutableArray *c43 = [NSMutableArray arrayWithArray:@[@"close",@"gem.ice",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c44 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c45 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c46 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c47 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c48 = [NSMutableArray arrayWithArray:@[@"close",@"gem.banana",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c49 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c50 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c51 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c52 = [NSMutableArray arrayWithArray:@[@"close",@"gem.shield",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c53 = [NSMutableArray arrayWithArray:@[@"close",@"map.5",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c54 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": iString(@"s54")}]];
    
    NSMutableArray *c55 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c56 = [NSMutableArray arrayWithArray:@[@"close",@"cook.5",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c57 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c58 = [NSMutableArray arrayWithArray:@[@"close",@"gem.boom",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c59 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c60 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c61 = [NSMutableArray arrayWithArray:@[@"close",@"map.6",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c62 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c63 = [NSMutableArray arrayWithArray:@[@"close",@"gem.ice",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c64 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c65 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": iString(@"s65v"), @"begin": @""}]];
    
    NSMutableArray *c66 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c67 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c68 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c69 = [NSMutableArray arrayWithArray:@[@"close",@"cook.1",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c70 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c71 = [NSMutableArray arrayWithArray:@[@"close",@"gold.30",
                                                           @{@"over": @"", @"begin": iString(@"s71")}]];
    
    NSMutableArray *c72 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c73 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c74 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c75 = [NSMutableArray arrayWithArray:@[@"close",@"gem.banana",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c76 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c77 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c78 = [NSMutableArray arrayWithArray:@[@"close2",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c79 = [NSMutableArray arrayWithArray:@[@"close",@"gem.boom",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c80 = [NSMutableArray arrayWithArray:@[@"close",@"gold.15",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c81 = [NSMutableArray arrayWithArray:@[@"close",@"cook.2",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSMutableArray *c82 = [NSMutableArray arrayWithArray:@[@"close",@"gem.ice",
                                                           @{@"over": @"", @"begin": @""}]];
    
    NSArray *back = @[c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32,c33,c34,c35,c36,c37,c38,c39,c40,c41,c42,c43,c44,c45,c46,c47,c48,c49,c50,c51,c52,c53,c54,c55,c56,c57,c58,c59,c60,c61,c62,c63,c64,c65,c66,c67,c68,c69,c70,c71,c72,c73,c74,c75,c76,c77,c78,c79,c80,c81,c82];
    return back;
}


+(NSMutableDictionary *)jellyData
{
//TODO: banana
    //gem.banana\ gem.boom \gem.energy \gem.shield \gem.ice \whistle.1
    NSDictionary *banana = @{@"type": @"banana",
                             @"myName": @"banana",
                             @"name": iString(@"banana"),
                             @"profile": iString(@"banana_profile"),
                             @"hp": @"500",
                             @"attack": @"18",
                             @"gemA": iString(@"banana_gemA"),
                             @"gemB": iString(@"banana_gemB"),
                             @"isGemA": @35,
                             @"isGemB": @35,
                             @"gemANeedGold": @50,
                             @"gemBNeedGold": @70,
                             @"mana": @2,
                             @"scale":@1,
                             @"price": @0,
                             @"atlas": @"jelly_banana_rest",};
//TODO: energy
    NSDictionary *energy = @{@"type": @"energy",
                             @"myName": @"energy",
                             @"name": iString(@"energy"),
                             @"profile": iString(@"energy_profile"),
                             @"hp": @"300",
                             @"attack": @"24s",
                             @"gemA": iString(@"energy_gemA"),
                             @"gemB": iString(@"energy_gemB"),
                             @"isGemA": @15,
                             @"isGemB": @110,
                             @"gemANeedGold": @15,
                             @"gemBNeedGold": @110,
                             @"mana": @1,
                             @"scale":@1,
                             @"price": @0,
                             @"atlas": @"jelly_energy_reat_lawn",};
//TODO: doubleJelly
    NSDictionary *doubleJelly = @{@"type": @"banana",
                                  @"myName": @"double",
                                  @"name": iString(@"double"),
                                  @"profile": iString(@"double_profile"),
                                  @"hp": @"300",
                                  @"attack": @"12",
                                  @"gemA": iString(@"double_gemA"),
                                  @"gemB": iString(@"double_gemB"),
                                  @"isGemA": @110,
                                  @"isGemB": @110,
                                  @"gemANeedGold": @110,
                                  @"gemBNeedGold": @110,
                                  @"mana": @4,
                                  @"scale": @1,
                                  @"price": @0,
                                  @"atlas": @"jelly_double_rest",};
//TODO: slow
    NSDictionary *slow = @{@"type": @"boom",
                           @"myName": @"slow",
                           @"name": iString(@"slow"),
                           @"profile": iString(@"slow_profile"),
                           @"hp": @"300",
                           @"attack": @"0",
                           @"gemA": iString(@"slow_gemA"),
                           @"gemB": iString(@"slow_gemB"),
                           @"isGemA": @110,
                           @"isGemB": @50,
                           @"gemANeedGold": @110,
                           @"gemBNeedGold": @50,
                           @"mana": @1,
                           @"scale":@1,
                           @"price": @0,
                           @"atlas": @"jelly_slow_rest",};
//TODO: shield
    NSDictionary *shield = @{@"type": @"shield",
                             @"myName": @"shield",
                             @"name": iString(@"shield"),
                             @"profile": iString(@"shield_profile"),
                             @"hp": @"300",
                             @"attack": @"15s",
                             @"gemA": iString(@"shield_gemA"),
                             @"gemB": iString(@"shield_gemB"),
                             @"isGemA": @70,
                             @"isGemB": @50,
                             @"gemANeedGold": @70,
                             @"gemBNeedGold": @50,
                             @"mana": @1,
                             @"scale":@1,
                             @"price": @0,
                             @"atlas": @"jelly_shield_rest",};
//TODO: boxer
    NSDictionary *boxer = @{@"type": @"banana",
                            @"myName": @"boxer",
                            @"name": iString(@"boxer"),
                            @"profile": iString(@"boxer_profile"),
                            @"hp": @"2500",
                            @"attack": @"30",
                            @"gemA": iString(@"boxer_gemA"),
                            @"gemB": iString(@"boxer_gemB"),
                            @"isGemA": @110,
                            @"isGemB": @180,
                            @"gemANeedGold": @110,
                            @"gemBNeedGold": @180,
                            @"mana": @5,
                            @"scale":@1,
                            @"price": @111,
                            @"atlas": @"jelly_boxer_rest",};
//TODO: boom
    NSDictionary *boom = @{@"type": @"boom",
                           @"myName": @"boom",
                           @"name": iString(@"boom"),
                           @"profile": iString(@"boom_profile"),
                           @"hp": @"300",
                           @"attack": @"550",
                           @"gemA": iString(@"boom_gemA"),
                           @"gemB": iString(@"boom_gemB"),
                           @"isGemA": @70,
                           @"isGemB": @50,
                           @"gemANeedGold": @70,
                           @"gemBNeedGold": @80,
                           @"mana": @3,
                           @"scale":@1,
                           @"price": @0,
                           @"atlas": @"jelly_boom_rest",};
    
//TODO: strom
    NSDictionary *strom = @{@"type": @"banana",
                            @"myName": @"strom",
                            @"name": iString(@"strom"),
                            @"profile": iString(@"strom_profile"),
                            @"hp": @"2500",
                            @"attack": @"12s",
                            @"gemA": iString(@"strom_gemA"),
                            @"gemB": iString(@"strom_gemB"),
                            @"isGemA": @180,
                            @"isGemB": @110,
                            @"gemANeedGold": @180,
                            @"gemBNeedGold": @170,
                            @"mana": @5,
                            @"scale":@1,
                            @"price": @450,
                            @"atlas": @"jelly_strom_rest",};
//TODO: violent
    NSDictionary *violent = @{@"type": @"banana",
                              @"myName": @"violent",
                              @"name": iString(@"violent"),
                              @"profile": iString(@"violent_profile"),
                              @"hp": @"300",
                              @"attack": @"40",
                              @"gemA": iString(@"violent_gemA"),
                              @"gemB": iString(@"violent_gemB"),
                              @"isGemA": @110,
                              @"isGemB": @320,
                              @"gemANeedGold": @70,
                              @"gemBNeedGold": @320,
                              @"mana": @4,
                              @"scale":@1,
                              @"price": @0,
                              @"atlas": @"jelly_violent_rest",};
//TODO: highEnergy
    NSDictionary *highEnergy = @{@"type": @"energy",
                                 @"myName": @"highEnergy",
                                 @"name": iString(@"highEnergy"),
                                 @"profile": iString(@"highEnergy_profile"),
                                 @"hp": @"300",
                                 @"attack": @"24s",
                                 @"gemA": iString(@"highEnergy_gemA"),
                                 @"gemB": iString(@"highEnergy_gemB"),
                                 @"isGemA": @20,
                                 @"isGemB": @180,
                                 @"gemANeedGold": @20,
                                 @"gemBNeedGold": @180,
                                 @"mana": @4,
                                 @"scale":@1,
                                 @"price": @250,
                                 @"atlas": @"jelly_highEnergy_rest_lawn",};
//TODO: snail
    NSDictionary *snail = @{@"type": @"shield",
                            @"myName": @"snail",
                            @"name": iString(@"snail"),
                            @"profile": iString(@"snail_profile"),
                            @"hp": @"300",
                            @"attack": @"12s",
                            @"gemA": iString(@"snail_gemA"),
                            @"gemB": iString(@"snail_gemB"),
                            @"isGemA": @320,
                            @"isGemB": @180,
                            @"gemANeedGold": @320,
                            @"gemBNeedGold": @110,
                            @"mana": @3,
                            @"scale":@1,
                            @"price": @950,
                            @"atlas": @"jelly_snail_rest",};
//TODO: iceThin
    NSDictionary *iceThin = @{@"type": @"ice",
                              @"myName": @"iceThin",
                              @"name": iString(@"iceThin"),
                              @"profile": iString(@"iceThin_profile"),
                              @"hp": @"3500",
                              @"attack": @"0",
                              @"gemA": iString(@"iceThin_gemA"),
                              @"gemB": iString(@"iceThin_gemB"),
                              @"isGemA": @110,
                              @"isGemB": @20,
                              @"gemANeedGold": @110,
                              @"gemBNeedGold": @20,
                              @"mana": @2,
                              @"scale":@1.05,
                              @"price": @0,
                              @"atlas": @"jelly_iceThin_rest",};
//TODO: iceThick 加厚
    NSDictionary *iceThick = @{@"type": @"ice",
                               @"myName": @"iceThick",
                               @"name": iString(@"iceThick"),
                               @"profile": iString(@"iceThick_profile"),
                               @"hp": @"8000",
                               @"attack": @"30s",
                               @"gemA": iString(@"iceThick_gemA"),
                               @"gemB": iString(@"iceThick_gemB"),
                               @"isGemA": @60,
                               @"isGemB": @40,
                               @"gemANeedGold": @60,
                               @"gemBNeedGold": @40,
                               @"mana": @4,
                               @"scale":@1,
                               @"price": @0,
                               @"atlas": @"jelly_iceThick_rest",};
//TODO: iceMist
    NSDictionary *iceMist = @{@"type": @"ice",
                              @"myName": @"iceMist",
                              @"name": iString(@"iceMist"),
                              @"profile": iString(@"iceMist_profile"),
                              @"hp": @"6000",
                              @"attack": @"0",
                              @"gemA": iString(@"iceMist_gemA"),
                              @"gemB": iString(@"iceMist_gemB"),
                              @"isGemA": @180,
                              @"isGemB": @110,
                              @"gemANeedGold": @180,
                              @"gemBNeedGold": @110,
                              @"mana": @5,
                              @"scale":@1.05,
                              @"price": @350,
                              @"atlas": @"jelly_iceMist_rest_lawn",};
//TODO: iceThorn 冰刺
    NSDictionary *iceThorn = @{@"type": @"ice",
                               @"myName": @"iceThorn",
                               @"name": iString(@"iceThorn"),
                               @"profile": iString(@"iceThorn_profile"),
                               @"hp": @"6000",
                               @"attack": iString(@"rebound"),
                               @"gemA": iString(@"iceThorn_gemA"),
                               @"gemB": iString(@"iceThorn_gemB"),
                               @"isGemA": @70,
                               @"isGemB": @180,
                               @"gemANeedGold": @70,
                               @"gemBNeedGold": @80,
                               @"mana": @5,
                               @"scale":@1.05,
                               @"price": @0,
                               @"atlas": @"jelly_iceThron_rest",};
    
//TODO: cure
    NSDictionary *cure = @{@"type": @"shield",
                           @"myName": @"cure",
                           @"name": iString(@"cure"),
                           @"profile": iString(@"cure_profile"),
                           @"hp": @"300",
                           @"attack": @"15s",
                           @"gemA": iString(@"cure_gemA"),
                           @"gemB": iString(@"cure_gemB"),
                           @"isGemA": @110,
                           @"isGemB": @180,
                           @"gemANeedGold": @110,
                           @"gemBNeedGold": @180,
                           @"mana": @2,
                           @"scale":@1,
                           @"price": @0,
                           @"atlas": @"jelly_cure_rest",};
//TODO: aoeBoom
    NSDictionary *aoeBoom = @{@"type": @"boom",
                              @"myName": @"aoeBoom",
                              @"name": iString(@"aoeBoom"),
                              @"profile": iString(@"aoeBoom_profile"),
                              @"hp": @"2000",
                              @"attack": @"250",
                              @"gemA": iString(@"aoeBoom_gemA"),
                              @"gemB": iString(@"aoeBoom_gemB"),
                              @"isGemA": @110,
                              @"isGemB": @110,
                              @"gemANeedGold": @110,
                              @"gemBNeedGold": @110,
                              @"mana": @7,
                              @"scale":@1,
                              @"price": @0,
                              @"atlas": @"jelly_aoeBoom_rest",};
//TODO: dizzy
    NSDictionary *dizzy = @{@"type": @"boom",
                            @"myName": @"dizzy",
                            @"name": iString(@"dizzy"),
                            @"profile": iString(@"dizzy_profile"),
                            @"hp": @"2000",
                            @"attack": @"0",
                            @"gemA": iString(@"dizzy_gemA"),
                            @"gemB": iString(@"dizzy_gemB"),
                            @"isGemA": @320,
                            @"isGemB": @180,
                            @"gemANeedGold": @320,
                            @"gemBNeedGold": @180,
                            @"mana": @2,
                            @"scale":@1,
                            @"price": @0,
                            @"atlas": @"jelly_dizzy_rest",};
//TODO: laser
    NSDictionary *laser = @{@"type": @"banana",
                            @"myName": @"laser",
                            @"name": iString(@"laser"),
                            @"profile": iString(@"laser_profile"),
                            @"hp": @"300",
                            @"attack": @"90",
                            @"gemA": iString(@"laser_gemA"),
                            @"gemB": iString(@"laser_gemB"),
                            @"isGemA": @320,
                            @"isGemB": @80,
                            @"gemANeedGold": @320,
                            @"gemBNeedGold": @80,
                            @"mana": @9,
                            @"scale":@1,
                            @"price": @0,
                            @"atlas": @"jelly_laser_rest",};
    
//--------------------------------------------------------------------------------------------------------------
    NSMutableDictionary *banana_m = [NSMutableDictionary dictionaryWithDictionary:banana];
    NSMutableDictionary *energy_m = [NSMutableDictionary dictionaryWithDictionary:energy];
    NSMutableDictionary *doubleJelly_m = [NSMutableDictionary dictionaryWithDictionary:doubleJelly];
    NSMutableDictionary *iceThin_m = [NSMutableDictionary dictionaryWithDictionary:iceThin];
    NSMutableDictionary *slow_m = [NSMutableDictionary dictionaryWithDictionary:slow];
    NSMutableDictionary *shield_m = [NSMutableDictionary dictionaryWithDictionary:shield];
    NSMutableDictionary *iceThorn_m = [NSMutableDictionary dictionaryWithDictionary:iceThorn];
    NSMutableDictionary *boxer_m = [NSMutableDictionary dictionaryWithDictionary:boxer];
    NSMutableDictionary *boom_m = [NSMutableDictionary dictionaryWithDictionary:boom];
    NSMutableDictionary *strom_m = [NSMutableDictionary dictionaryWithDictionary:strom];
    NSMutableDictionary *violent_m = [NSMutableDictionary dictionaryWithDictionary:violent];
    NSMutableDictionary *highEnergy_m = [NSMutableDictionary dictionaryWithDictionary:highEnergy];
    NSMutableDictionary *snail_m = [NSMutableDictionary dictionaryWithDictionary:snail];
    NSMutableDictionary *iceThick_m = [NSMutableDictionary dictionaryWithDictionary:iceThick];
    NSMutableDictionary *cure_m = [NSMutableDictionary dictionaryWithDictionary:cure];
    NSMutableDictionary *aoeBoom_m = [NSMutableDictionary dictionaryWithDictionary:aoeBoom];
    NSMutableDictionary *dizzy_m = [NSMutableDictionary dictionaryWithDictionary:dizzy];
    NSMutableDictionary *iceMist_m = [NSMutableDictionary dictionaryWithDictionary:iceMist];
    NSMutableDictionary *laser_m = [NSMutableDictionary dictionaryWithDictionary:laser];

//    NSMutableArray *aa = [NSMutableArray arrayWithArray: @[banana_m, energy_m, iceThin_m, shield_m, doubleJelly_m,slow_m, boom_m, highEnergy_m, dizzy_m, boxer_m, iceThick_m,  strom_m, laser_m, cure_m, iceMist_m, aoeBoom_m, snail_m, iceThorn_m, violent_m]];
    
    NSMutableDictionary *all = [NSMutableDictionary dictionaryWithDictionary:@{@"banana":banana_m, @"energy":energy_m, @"iceThin":iceThin_m, @"shield":shield_m, @"double":doubleJelly_m,
                                                                               @"slow":slow_m, @"boom":boom_m, @"highEnergy":highEnergy_m, @"dizzy":dizzy_m, @"boxer":boxer_m, @"iceThick":iceThick_m,
                                                                               @"strom":strom_m, @"laser":laser_m, @"cure":cure_m, @"iceMist":iceMist_m, @"aoeBoom":aoeBoom_m,
                                                                               @"snail":snail_m, @"iceThorn":iceThorn_m, @"violent":violent_m}];
    return all;
}


@end
