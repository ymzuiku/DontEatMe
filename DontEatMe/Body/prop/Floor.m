//
//  Floor.m
//  DontEatMe
//
//  Created by pringlesfox on 8/18/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Floor.h"

@implementation Floor
{
    NSMutableArray *jellyArray;
}

-(id)initWithNumber:(int)number
{
    if (self = [super initWithNumber:number]) {
        self.texture = AtlasNum(@"chicken_buff_floor_create", 0);
        self.myName = @"floor";
        self.boxRect = CGRectMake(-57,-48, 114, 96);
        self.defaultHP = 300;
        self.type = 5;
        jellyArray = [[NSMutableArray alloc] init];
        [self floorCreate];
        [self floorOver];
    }
    return self;
}


-(void)floorCreate
{
    
    SKAction *floorCreate = [SKAction animateWithTextures:Atlas(@"chicken_buff_floor_create") timePerFrame:oneKey resize:YES restore:NO];
    [self runAction:floorCreate completion:^{
         [self floorRest];
        
    }];
    
}

-(void)floorAttack:(Jelly *)jelly
{
    
}

-(void)addJellyArray:(Jelly *)jelly
{
    if (![jellyArray containsObject:jelly]) {
        [jellyArray addObject:jelly];
    }
}

-(void)floorRest
{
    SKAction *floorRest = [SKAction animateWithTextures:Atlas(@"chicken_buff_floor_rest") timePerFrame:oneKey resize:YES restore:NO];
    SKAction *repRest = [SKAction repeatActionForever:floorRest];
    [self runAction:repRest withKey:@"rest"];
}

-(void)floorOver
{
    SKAction *floorCreate = [SKAction animateWithTextures:Atlas(@"chicken_buff_floor_create") timePerFrame:oneKey resize:YES restore:NO];
    SKAction *floorOver = [floorCreate reversedAction];
    SKAction *waitTime = [SKAction waitForDuration:20.0];
    SKAction *killRest = [SKAction runBlock:^{
        [self removeActionForKey:@"rest"];
    }];
    SKAction *floorOverAction = [SKAction sequence:@[waitTime,killRest,floorOver]];
    [self runAction:floorOverAction completion:^{
        [self useDie];
    }];
    
}


@end

