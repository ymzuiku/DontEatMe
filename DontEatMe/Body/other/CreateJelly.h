//
//  CreateJelly.h
//  DontEatMe
//
//  Created by pringlesfox on 9/12/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Grid.h"
#import "GridArray.h"

@interface CreateJelly : NSObject

+(void)addJellyWithName:(NSString *)name pos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;

@end

