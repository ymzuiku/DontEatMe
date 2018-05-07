//
//  Ck.m
//  DontEatMe
//
//  Created by ym on 14-7-23.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "ChickenInClass.h"

@implementation ChickenInClass

+(id)createWithLine:(int)line_ type:(NSString *)type_ level:(int)level_ skill:(NSString *)skill_ down:(NSString *)down_
{
    return [[ChickenInClass alloc] initWithLine:(int)line_ type:(NSString *)type_ level:(int)level_ skill:(NSString *)skill_ down:(NSString *)down_];
}


-(id)initWithLine:(int)line_ type:(NSString *)type_ level:(int)level_ skill:(NSString *)skill_ down:(NSString *)down_
{
    if (self = [super init]) {
        self.line  = line_;
        self.type  = type_;
        self.level = level_;
        self.skill = skill_;
        self.down  = down_;
    }
    return self;
}

@end
