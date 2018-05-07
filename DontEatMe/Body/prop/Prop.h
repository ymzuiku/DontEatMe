//
//  Jelly.h
//  AtlasTesing
//
//  Created by pringlesfox on 3/30/14.
//  Copyright (c) 2014 ym. All rights reserved.
//

#import "Body.h"
#import "GridArray.h"
#import "Jelly.h"

@interface Prop : Body

@property NSUInteger gridNamber;
@property int type;
@property int isCantBeTouch;
@property int isColliedMoveUpDown;

-(id)init;
-(id)initWithNumber:(int)number;
-(void)setPropInGrid:(int)hasNodeNumber;
-(void)propDoThings;
-(void)jump;

-(void)propMove:(int)moveCount velocity:(Jelly *)propVelocity;
-(void)checkPropInTheGrid;
@end
