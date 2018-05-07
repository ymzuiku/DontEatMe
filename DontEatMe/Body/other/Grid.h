//
//  Grid.h
//  DontEatMe
//
//  Created by pringlesfox on 9/2/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Jelly.h"
#import "Prop.h"

@interface Grid : SKSpriteNode{
    
}

@property         int number;
@property      CGRect gridRect;
@property   NSString* nodeNameInGrid;
@property      Jelly* nodeInGrid;
@property   NSString* proNameInGird;
@property       Prop* propInGrid;
@property         int isShowLines;
@property         int hasNode;
@property         int hasFloor;

-(id)init:(CGRect)rect gridNumber:(int)numb;

@end
