//
//  Background.m
//  DontEatMe
//
//  Created by ym on 14/7/7.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "Background.h"

@implementation Background
{
    SKEmitterNode *partique;
}

-(void)removeFromParent
{
    [_rootView removeAllChildren];
    [_rootView removeFromParent];
    _rootView = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}

-(id)initWithType:(NSString *)type particle:(NSString *)particleName;
{
    if (self = [super init]) {
        _rootView = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(iw, ih)];
        _rootView.position = CGPointMake(iw/2, ih/2);
        [self addChild:_rootView];
        
        if ([type isEqualToString:@"island"]) [self createIslandWorld];
        else if ([type isEqualToString:@"greed"]) [self createGreedWorld];
        else if ([type isEqualToString:@"snow"]) [self createSnowWorld];
        else if ([type isEqualToString:@"desert"]) [self createDesertWorld];
        else if ([type isEqualToString:@"blue"]) [self createBlueWorld];
        else if ([type isEqualToString:@"forest"]) [self createForestWorld];
        else if ([type isEqualToString:@"lava"]) [self createLavaWorld];
        else if ([type isEqualToString:@"fruit"]) [self createFruitWorld];
        else if ([type isEqualToString:@"kuang"]) [self createKuangWorld];
        
//        [self scale_rootView];
        
        self.zPosition = -1;
        self.position = CGPointMake(0, 0);
        self.anchorPoint = CGPointMake(0, 0);
        [self createPartique:particleName];
    }
    return self;
}

-(void)scale_rootView
{
    [_rootView setScale:0.832];
    SKAction *scale = [SKAction scaleTo:1 duration:0.7];
    scale.timingMode = SKActionTimingEaseOut;
    [_rootView runAction:scale];
}

-(void)createPartique:(NSString *)partiqueName
{
    if (!partiqueName) {
        return;
    }
    if ([partiqueName isEqualToString:@"Tree"]) {
        return;
    }
    partique = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:partiqueName ofType:@"sks"]];
    partique.zPosition = 1999.4;
    partique.targetNode = self;
    partique.userInteractionEnabled = NO;
    partique.position = CGPointMake(0, ih/2);
    if ([partiqueName isEqualToString:@"Send"]) {
        partique.position = CGPointMake(0, 0);
    }
    [_rootView addChild:partique];
}

-(void)createIslandWorld
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_island_background")[0]];
    background.zPosition = 0;
    background.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    background.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:background];
    
    SKSpriteNode *top = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_island_background")[1]];
    top.zPosition = 1999.1;
    top.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    top.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:top];
}

-(void)createGreedWorld
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_greed_background")[0]];
    background.zPosition = 0;
    background.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    background.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:background];
    
    SKSpriteNode *top = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_greed_background")[1]];
    top.zPosition = 1999.1;
    top.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    top.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:top];
    
//    //part
//    SKEmitterNode *treePar = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Tree" ofType:@"sks"]];
//    treePar.zPosition = 1999.4;
//    treePar.targetNode = self;
//    treePar.userInteractionEnabled = NO;
//    treePar.position = CGPointMake(-iw/2+20, ih/2);
//    [_rootView addChild:treePar];
//    
//    SKEmitterNode *treePar2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Tree" ofType:@"sks"]];
//    treePar2.zPosition = 1999.4;
//    treePar2.targetNode = self;
//    treePar2.userInteractionEnabled = NO;
//    treePar2.position = CGPointMake(iw/2-20, ih/2);
//    [_rootView addChild:treePar2];
}

-(void)createSnowWorld
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_snow_background")[0]];
    background.zPosition = 0;
    background.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    background.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:background];
    
    SKSpriteNode *top = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_snow_background")[1]];
    top.zPosition = 1999.1;
    top.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    top.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:top];
}

-(void)createDesertWorld
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_desert_background")[0]];
    background.zPosition = 0;
    background.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    background.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:background];
    
    SKSpriteNode *top = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_desert_background")[1]];
    top.zPosition = 1999.1;
    top.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    top.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:top];
}

-(void)createBlueWorld
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"scene_blue_background", 0)];
    background.zPosition = 0.1;
    background.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    background.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:background];
    
    SKSpriteNode *shadow = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"scene_blue_shadow", 0)];
    SKAction *anime_0 = [SKAction animateWithTextures:Atlas(@"scene_blue_shadow") timePerFrame:0.042 resize:YES restore:YES];
    SKAction *anime_1 = [SKAction animateWithTextures:Atlas(@"scene_blue_shadow") timePerFrame:0.042*1.3 resize:YES restore:YES];
    SKAction *anime_2 = [SKAction animateWithTextures:Atlas(@"scene_blue_shadow") timePerFrame:0.042*1.8 resize:YES restore:YES];
    SKAction *seq = [SKAction sequence:@[anime_0, anime_1, anime_2]];
    [shadow runAction:[SKAction repeatActionForever:seq]];
    shadow.zPosition = 1999.1;
    shadow.position = CGPointMake(0, 0);
    shadow.anchorPoint = CGPointMake(0, 0);
    [shadow setScale:10];
    [background addChild:shadow];
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *light = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"scene_blue_background", 2)];
        light.zPosition = 1999.2;
        light.anchorPoint = CGPointMake(0, 0);
        if (i == 0) light.position = CGPointMake(23, 141);
        if (i == 1) light.position = CGPointMake(575, 127);
        if (i == 2) light.position = CGPointMake(-42, 898);
        [background addChild:light];
        
        SKSpriteNode *sofa = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"scene_blue_background", 1)];
        sofa.zPosition = 1999.3;
        sofa.anchorPoint = CGPointMake(0, 0);
        if (i == 0) sofa.position = CGPointMake(34, 39);
        if (i == 1) sofa.position = CGPointMake(684, 38);
        if (i == 2) sofa.position = CGPointMake(5, 818);
        [background addChild:sofa];
    }
}

-(void)createForestWorld
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_forest_background")[0]];
    background.zPosition = 0;
    background.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    background.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:background];
    
    SKSpriteNode *shadow = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_scene_anime_treeA", 0)];
    SKAction *anime_1 = [SKAction animateWithTextures:Atlas(@"ui_scene_anime_treeA") timePerFrame:0.042*1.8 resize:YES restore:NO];
    SKAction *anime_2 = [SKAction animateWithTextures:Atlas(@"ui_scene_anime_treeA") timePerFrame:0.042*2.4 resize:YES restore:NO];
    SKAction *anime_3 = [SKAction animateWithTextures:Atlas(@"ui_scene_anime_treeA") timePerFrame:0.042*1.4 resize:YES restore:NO];
    SKAction *anime_4 = [SKAction animateWithTextures:Atlas(@"ui_scene_anime_treeA") timePerFrame:0.042*2.8 resize:YES restore:NO];
    SKAction *anime_2b = [anime_2 reversedAction];
    SKAction *anime_4b = [anime_4 reversedAction];
    SKAction *seq = [SKAction sequence:@[anime_1, anime_2b, anime_1, anime_2b, anime_3, anime_4b]];
    [shadow runAction:[SKAction repeatActionForever:seq]];
    shadow.zPosition = 1999.1;
    shadow.position = CGPointMake(0, 0);
    shadow.anchorPoint = CGPointMake(0, 0);
    [shadow setScale:10.8];
    [background addChild:shadow];
    
    SKSpriteNode *top = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_forest_background")[1]];
    top.zPosition = 1999.1;
    top.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    top.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:top];
}

-(void)createLavaWorld
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_lava_background")[0]];
    background.zPosition = 0;
    background.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    background.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:background];
    
    SKSpriteNode *top = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_lava_background")[1]];
    top.zPosition = 1999.1;
    top.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    top.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:top];
}

-(void)createFruitWorld
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_fruit_background")[0]];
    background.zPosition = 0;
    background.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    background.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:background];
    
    SKSpriteNode *top = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_fruit_background")[1]];
    top.zPosition = 1999.1;
    top.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    top.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:top];
}

-(void)createKuangWorld
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_kuang_background")[0]];
    background.zPosition = 0;
    background.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    background.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:background];
    
    SKSpriteNode *top = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_kuang_background")[1]];
    top.zPosition = 1999.1;
    top.position = cciPhone5AutoPos(-64-iw/2, -117-ih/2);
    top.anchorPoint = CGPointMake(0, 0);
    [_rootView addChild:top];
    
    SKSpriteNode *shadow = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"scene_blue_shadow", 0)];
    SKAction *anime_0 = [SKAction animateWithTextures:Atlas(@"scene_blue_shadow") timePerFrame:0.042 resize:YES restore:YES];
    SKAction *anime_1 = [SKAction animateWithTextures:Atlas(@"scene_blue_shadow") timePerFrame:0.042*1.3 resize:YES restore:YES];
    SKAction *anime_2 = [SKAction animateWithTextures:Atlas(@"scene_blue_shadow") timePerFrame:0.042*1.8 resize:YES restore:YES];
    SKAction *seq = [SKAction sequence:@[anime_0, anime_1, anime_2]];
    [shadow runAction:[SKAction repeatActionForever:seq]];
    shadow.zPosition = 1999.1;
    shadow.position = CGPointMake(0, 0);
    shadow.anchorPoint = CGPointMake(0, 0);
    [shadow setScale:12];
    [background addChild:shadow];
}

@end
