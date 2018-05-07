//
//  GridArray.m
//  DontEatMe
//
//  Created by pringlesfox on 9/2/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "GridArray.h"
#import "Grid.h"

#define grid0 @"{98,1095}"
#define grid1 @"{212,1095}"
#define grid2 @"{326,1095}"
#define grid3 @"{440,1095}"
#define grid4 @"{554,1095}"
#define grid5 @"{98,1001}"
#define grid6 @"{212,1001}"
#define grid7 @"{326,1001}"
#define grid8 @"{440,1001}"
#define grid9 @"{554,1001}"
#define grid10 @"{98,907}"
#define grid11 @"{212,907}"
#define grid12 @"{326,907}"
#define grid13 @"{440,907}"
#define grid14 @"{554,907}"
#define grid15 @"{98,813}"
#define grid16 @"{212,813}"
#define grid17 @"{326,813}"
#define grid18 @"{440,813}"
#define grid19 @"{554,813}"
#define grid20 @"{98,719}"
#define grid21 @"{212,719}"
#define grid22 @"{326,719}"
#define grid23 @"{440,719}"
#define grid24 @"{554,719}"
#define grid25 @"{98,625}"
#define grid26 @"{212,625}"
#define grid27 @"{326,625}"
#define grid28 @"{440,625}"
#define grid29 @"{554,625}"
#define grid30 @"{98,531}"
#define grid31 @"{212,531}"
#define grid32 @"{326,531}"
#define grid33 @"{440,531}"
#define grid34 @"{554,531}"
#define grid35 @"{98,437}"
#define grid36 @"{212,437}"
#define grid37 @"{326,437}"
#define grid38 @"{440,437}"
#define grid39 @"{554,437}"
#define grid40 @"{98,343}"
#define grid41 @"{212,343}"
#define grid42 @"{326,343}"
#define grid43 @"{440,343}"
#define grid44 @"{554,343}"

static NSMutableArray *array;

@implementation GridArray

+(NSMutableArray *)getGridArray
{
    if (array == nil) {
        array = [NSMutableArray arrayWithCapacity:45];
        for (int i = 0; i<40; i++) {
            int cell = i/5;
            int roll = i%5;
            CGRect rect = CGRectMake(36+(114*roll), ih-46-((cell+1)*94)-32, 114, 94);
            Grid *grid = [[Grid alloc]init:rect gridNumber:i];
            [array addObject:grid];
        }
        [array addObject:[[Grid alloc] init:CGRectMake(iw/2, ih-882-80, 268, 80) gridNumber:40]];
    }
    return array;
}


+(void)clearPropGridWithNumber:(int)number
{
    Grid *grid = [array objectAtIndex:number];
    grid.hasNode = 0;
    grid.propInGrid = nil;
}

+(void)clearJellyGridWithNumber:(int)number
{
    Grid *grid = [array objectAtIndex:number];
    grid.hasNode = 0;
    grid.nodeInGrid = nil;
}

+(void)clearAllNode
{
    [array removeAllObjects];
    array = nil;
}


@end
