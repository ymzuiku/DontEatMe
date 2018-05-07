//
//  Rock.m
//  DontEatMe
//
//  Created by pringlesfox on 7/30/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Rock.h"

static SKAction *stonDown;

@implementation Rock
{
    SKSpriteNode *shadow;
    SKSpriteNode *rock;
}

-(id)initWithNumber:(int)number
{
    if (self = [super initWithNumber:number]) {
        
        self.boxRect = CGRectMake(-57,-48, 114, 96);
        self.myName = @"rock";
        self.defaultHP = 3000;
        self.nowHP = self.defaultHP;
		[self setPropInGrid:2];
        [self rockStandAnima];
    }
    return self;
}

-(void)rockStandAnima
{
    shadow = [[SKSpriteNode alloc] initWithTexture:AtlasNum(@"ui_scene_obj_rock",0)];
    [self addChild:shadow];
    
    rock = [[SKSpriteNode alloc] initWithTexture:AtlasNum(@"ui_scene_obj_rock",1)];
    rock.position = CGPointMake(0,2000);
    rock.zPosition = 3000;
    [self addChild:rock];
    
    SKAction *rockMoveDown = [SKAction moveByX:0 y:-2000 duration:1.0];
    SKAction *rockWait = [SKAction waitForDuration:2.0];
    stonDown = [SKAction sequence:@[rockWait,rockMoveDown]];
    [rock runAction:stonDown completion:^{
        rock.zPosition = (1999-self.position.y);
    }];
}

-(void)changeHP:(float)HP
{
    self.nowHP -= HP;
   if(self.nowHP < self.defaultHP/2){
       [self rockBrack];
    }
    
}

-(void)rockBrack
{
    SKAction *animate = [SKAction animateWithTextures:Atlas(@"ui_scene_obj_rock") timePerFrame:oneKey resize:YES restore:NO];
    [rock runAction:animate];
}

-(void)dealloc
{
    stonDown = nil;
}



@end
