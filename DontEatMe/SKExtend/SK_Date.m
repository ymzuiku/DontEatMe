//
//  SK_Date.m
//  DontEatMe
//
//  Created by ym on 15/3/5.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "SK_Date.h"

@implementation SK_Date

+(BOOL)oneDate:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
        return NO;
    
    return YES;
}

+(NSDate *)localeDate:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

+(NSDate *)todayWithH:(NSInteger)hour m:(NSInteger)min s:(NSInteger)second;
{
    
    

    //获取当前时间
    NSDate *date = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    currentComps = [currentCalendar components:unitFlags fromDate:date];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    [resultComps setMinute:min];
    [resultComps setSecond:second];
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *todayDate = [resultCalendar dateFromComponents:resultComps];
    
    //获取当前时区的时间
    NSDate *localeDate = [SK_Date localeDate:todayDate];
    return localeDate;
}

+(NSDate *)nowDate
{
    //获取当前时区的时间
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

+(float)timeDifferenceSecondWithNowAndDate:(NSDate *)date
{
    NSDate *nowDate = [SK_Date nowDate];
    int subTime = (int)[nowDate timeIntervalSinceDate:date];
    return (float)subTime;
}

+(float)timeDifferenceMinuteWithNowAndDate:(NSDate *)date
{
    NSDate *nowDate = [SK_Date nowDate];
    int subTime = (int)[nowDate timeIntervalSinceDate:date];
    return subTime/60/60.0;
}

+(float)timeDifferenceHourWithNowAndDate:(NSDate *)date
{
    NSDate *nowDate = [SK_Date nowDate];
    int subTime = (int)[nowDate timeIntervalSinceDate:date];
    return subTime/60/60.0;
}

+(float)timeDifferenceDayWithNowAndDate:(NSDate *)date
{
    NSDate *nowDate = [SK_Date nowDate];
    int subTime = (int)[nowDate timeIntervalSinceDate:date];
    return subTime/60/60.0/24.0;
}

@end
