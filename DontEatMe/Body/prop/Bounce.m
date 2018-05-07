//
//  Bounce.m
//  DontEatMe
//
//  Created by pringlesfox on 8/19/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Bounce.h"
#import "BounceBullet.h"

static SKAction *springFight;


@implementation Bounce
{
    SKSpriteNode *spring;
    BounceBullet *bounceBullet;
}

-(id)initWithNumber:(int)number
{
    if (self = [super initWithNumber:number]) {
        self.boxRect = CGRectMake(-57,-48, 114, 96);
        self.myName = @"bounce";
        self.defaultHP = 200;
		[self setPropInGrid:2];
        [self springStand];
    }
    return self;
}

-(void)springStand
{
    spring = [[SKSpriteNode alloc] initWithTexture:AtlasNum(@"ui_scene_obj_bounce",0)];
    [self addChild:spring];
}

-(void)springAction:(float)posX games:(SKNode *)games
{
    if (springFight == nil) {
        springFight = [SKAction animateWithTextures:Atlas(@"ui_scene_obj_bounce") timePerFrame:oneKey resize:YES restore:NO];
    }
    [spring runAction:springFight completion:^{
        bounceBullet = [[BounceBullet alloc] initWithPosition:CGPointMake(posX, self.position.y) zPosition:self.zPosition];
        [games addChild:bounceBullet];

    }];
    
}

//-(void)changeHP:(float)hurt
//{
//    self.nowHP -= hurt;
//    if (self.nowHP <= 0) {
//        [self killSelf];
//    }
//}


-(void)dealloc
{
    springFight = nil;
}


@end
