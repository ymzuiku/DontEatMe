//
//  Grid.m
//  DontEatMe
//
//  Created by pringlesfox on 9/2/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Grid.h"

@implementation Grid
//@synthesize hasNode = _hasNode, nodeInGrid = _nodeInGrid, propInGrid = _propInGrid;

-(id)init:(CGRect)rect gridNumber:(int)numb
{
    if (self = [super init]) {
        _number = numb;
        _gridRect = rect;
        _isShowLines = 0;
        self.position = CGPointMake(rect.origin.x+57, rect.origin.y+74);
    }
    return self;
}

@end
