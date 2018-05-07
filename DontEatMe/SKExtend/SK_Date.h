//
//  SK_Date.h
//  DontEatMe
//
//  Created by ym on 15/3/5.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SK_Date : NSObject

+(NSDate *)nowDate;
+(NSDate *)todayWithH:(NSInteger)hour m:(NSInteger)min s:(NSInteger)second;
+(BOOL)oneDate:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
+(float)timeDifferenceSecondWithNowAndDate:(NSDate *)date;
+(float)timeDifferenceMinuteWithNowAndDate:(NSDate *)date;
+(float)timeDifferenceHourWithNowAndDate:(NSDate *)date;
+(float)timeDifferenceDayWithNowAndDate:(NSDate *)date;
+(NSDate *)localeDate:(NSDate *)date;


@end
