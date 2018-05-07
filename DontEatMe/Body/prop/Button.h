//
//  Button.h
//  DontEatMe
//
//  Created by pringlesfox on 8/18/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Prop.h"

@interface Button : Prop

-(id)initWithNumber:(int)number;
-(void)buttonDown;

@property NSMutableArray *bombArray;

@end
