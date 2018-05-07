//
//  Meteorite.m
//  DontEatMe
//
//  Created by pringlesfox on 8/20/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Meteorite.h"

static SKAction *stonMove;

@implementation Meteorite

-(id)initWithNumber:(int)number
{
    if (self = [super initWithNumber:number]) {
        self.zPosition = 1999.1-self.position.y/2000;
        [self fly:[self flyPath]];
    }
    return self;
}

-(SKAction *)flyPath
{
    SKAction *move = [SKAction moveTo:CGPointMake(-200,100) duration:5.0];
    return move;
}

-(void)fly:(SKAction *)flyPath
{
    SKAction *fly = [SKAction animateWithTextures:Atlas(@"ui_scene_anime_rock") timePerFrame:oneKey resize:YES restore:NO];
    SKAction *repFly = [SKAction repeatActionForever:fly];
    stonMove = [SKAction group:@[repFly,flyPath]];
    [self runAction:stonMove];
}

-(void)dealloc
{
    stonMove = nil;
}

@end
