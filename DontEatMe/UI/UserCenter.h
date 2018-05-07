//
//  DateList.h
//  DontEatMe
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCenter : NSObject

+(void)createDic;  //创建Plist
+(void)writePlistWithDic:(id)dic name:(NSString *)name;
+(NSDictionary *)dic;
+(void)createNewDic;
+(void)addCook:(int)num;
+(void)addGold:(int)num;
+(void)addMaxCookTime:(int)day;
+(void)addMaxCook;
+(void)addJelly:(NSString *)jellyName;
+(void)addJellyPro;
+(void)addPickNumber;
+(void)addLand;
+(void)addGem:(NSString *)string;
+(void)setNowClass:(int)number;
+(void)save;
//+(void)openMapLine:(int)number;

@end
