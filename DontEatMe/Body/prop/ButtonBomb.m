//
//  ButtonBomb.m
//  DontEatMe
//
//  Created by pringlesfox on 8/18/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "ButtonBomb.h"

static SKAction *explode;
@implementation ButtonBomb

-(id)initWithNumber:(int)number
{
    if (self = [super initWithNumber:number]) {
        self.texture = AtlasNum(@"ui_scene_obj_button", 2);
        self.position = CGPointMake(self.position.x+6, self.position.y-10);
        self.name = @"prop";
        self.myName = @"buttonBomb";
        self.attack = 500;
        self.zPosition = 0;     //(1999-self.position.y);
        self.boxRect = CGRectMake(-57,-48, 114, 96);
        self.defaultHP = 300;
        self.type = 6;
        [self setPropInGrid:0];
    }
    return self;
}

-(void)propDoThings
{
    [self bombExplode];
}

-(void)bombExplode
{
    SKSpriteNode *bomb = [[SKSpriteNode alloc] init];
    [self addChild:bomb];
    bomb.zPosition = 1999;
    explode = [SKAction animateWithTextures:Atlas(@"jelly_boom_die") timePerFrame:oneKey resize:YES restore:NO];
    [bomb runAction:explode];
}

-(void)boomMake
{
    NSMutableArray *gridArray = [GridArray getGridArray];
    Grid *grid = gridArray[self.gridNamber];
    grid.propInGrid = self;
    SKAction *changeAlpha = [SKAction fadeAlphaTo:1.0 duration:1.5];
    [self runAction:changeAlpha];
}




@end
