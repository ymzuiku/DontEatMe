//
//  DateCenter.m
//  SpriteKitTest
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "ClassCenter.h"

@implementation ClassCenter

+(id)singleton
{
    static dispatch_once_t pred = 0;
    __strong static id classCenter = nil;
    dispatch_once(&pred, ^{
        classCenter = [[self alloc] init]; // or some other init method
    });
    return classCenter;
}


@end
