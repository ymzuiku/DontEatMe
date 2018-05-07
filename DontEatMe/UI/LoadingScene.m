//
//  LoadingScene.m
//  DontEatMe
//
//  Created by ym on 14/9/6.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "LoadingScene.h"
#import "War_Controller.h"
#import "ChickenInClass.h"

@implementation LoadingScene
{
    int labelNum;
}

-(void)removeFromParent
{
    [self removeAllChildren];
    [super removeFromParent];
}

+(LoadingScene *)createAtlas:(NSArray *)atlasNames classNumble:(int)numble block:(void (^)())block;
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:[self classNumbelLoad:numble]];
    [array addObjectsFromArray:atlasNames];
    return [[LoadingScene alloc] initWithAtlas:array block:block];
}

+(LoadingScene *)createAtlas:(NSArray *)atlasNames block:(void (^)())block;
{
    return [[LoadingScene alloc] initWithAtlas:atlasNames block:block];
}

-(id)initWithAtlas:(NSArray *)atlasNames block:(void (^)())block;
{
    if (self = [super initWithSize:CGSizeMake(iw, ih)]) {
        self.scaleMode = SKSceneScaleModeAspectFit;
        if (!iPhone5) {
            SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_main_loading")[4]];
            background.position = CGPointMake(iw/2, ih/2);
            [self addChild:background];
        }
        else {
            SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_main_loading")[0]];
            background.position = CGPointMake(iw/2, ih/2);
            [self addChild:background];
        }
        
        SKSpriteNode *light = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_main_loading")[1]];
        light.position = CGPointMake(iw/2, ih/2+20);
        [self addChild:light];
        
        SKAction *rotate = [SKAction rotateToAngle:-M_PI duration:14];
        [light runAction:[SKAction repeatActionForever:rotate]];
        
        SKSpriteNode *tree = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_main_loading")[5]];
        tree.position = CGPointMake(iw/2, ih/2+20);
        [self addChild:tree];
        
        //设置loading字体
        int line = 14;
//        if (iSEnglish) line = 28;
        SK_Label *labelShadow = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:line size:24 color:rgb(0x000000, 0.1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        labelShadow.position = CGPointMake(iw/2+4, 100-2);
        [self addChild:labelShadow];
        
        SK_Label *label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:line size:24 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        label.position = CGPointMake(iw/2+4, +100);
        [self addChild:label];
        
        NSArray *labelArray = [iString(@"loading") componentsSeparatedByString:@"**"];
        labelNum = (int)skRand(0, 4);
        label.text = labelArray[labelNum];
        labelShadow.text = label.text;
        
        float keys = 0.015;
        if (atlasNames.count == 16) {
            keys = 0.042;
        }
        
        SKSpriteNode *bar = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_main_loadingBar")[0]];
        bar.position = CGPointMake(iw/2+4, ih/2-190);
        SKAction *barAnime = [SKAction animateWithTextures:Atlas(@"ui_main_loadingBar") timePerFrame:keys resize:YES restore:NO];
        [bar runAction:barAnime];
        [self addChild:bar];
        
        
        SKAction *waitClearAtlas = [SKAction waitForDuration:1];
        [self runAction:waitClearAtlas completion:^{
            AtlasController *atlasController = [AtlasController single];
            [atlasController loadAtlas:atlasNames completion:^{
                if (block) block();
            }];
        }];
        
    }
    return self;
}

+(NSArray *)classNumbelLoad:(int)numbel
{
    NSMutableSet *set = [NSMutableSet set];
    War *war = [War_Controller createWar:numbel];
    for (NSDictionary *dic in war.c_chickens) {
        NSArray *chickens = [dic objectForKey:@"chickenType"];
        for (ChickenInClass *chickenObj in chickens) {
            NSString *restStr = [NSString stringWithFormat:@"chicken_%@_rest", chickenObj.type];
            NSString *attackStr = [NSString stringWithFormat:@"chicken_%@_attack", chickenObj.type];
            NSString *moveStr = [NSString stringWithFormat:@"chicken_%@_move", chickenObj.type];
            
            [set addObject:restStr];
            [set addObject:moveStr];
            [set addObject:attackStr];

        }
    }
    NSArray *array = [set allObjects];
    return array;
}

@end
