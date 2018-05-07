//
//  Floor.h
//  DontEatMe
//
//  Created by pringlesfox on 8/18/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Prop.h"
#import "Jelly.h"

@interface Floor : Prop

@property int bullet;

-(void)addJellyArray:(Jelly *)jelly;

@end
