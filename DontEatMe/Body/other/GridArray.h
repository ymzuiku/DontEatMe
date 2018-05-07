//
//  GridArray.h
//  DontEatMe
//
//  Created by pringlesfox on 9/2/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridArray : NSObject

+(NSMutableArray *)getGridArray;
+(void)clearPropGridWithNumber:(int)number;
+(void)clearJellyGridWithNumber:(int)number;
+(void)clearAllNode;

@end
