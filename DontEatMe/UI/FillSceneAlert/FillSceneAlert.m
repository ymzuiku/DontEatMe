//
//  FillSceneAlert.m
//  DontEatMe
//
//  Created by ym on 15/2/25.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "FillSceneAlert.h"
#import "SK_ScrollView.h"

@implementation FillSceneAlert

-(id)init
{
    if (self = [super init]) {
        [self createInit];
    }
    return self;
}

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        [self createInit];
    }
    return self;
}

-(id)initWithColor:(UIColor *)color size:(CGSize)size
{
    if (self = [super initWithColor:color size:size]) {
        [self createInit];
    }
    return self;
}

-(id)initWithImageNamed:(NSString *)name
{
    if (self = [super initWithImageNamed:name]) {
        [self createInit];
    }
    return self;
}

-(void)createInit
{
    self.zPosition = 9000;
    self.anchorPoint = CGPointMake(0, 0);
    self.position = CGPointMake(0, 0);
    _backgroup = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_fishFarm")[5]];
    _backgroup.position = CGPointMake(iw/2, ih/2);
    [self addChild:_backgroup];
    
    [self newScrollView];
    [self newCloseButton];
}

-(void)newCloseButton
{
    SKSpriteNode *closeButtonBackgroup = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_fishFarm")[0]];
    closeButtonBackgroup.anchorPoint = CGPointMake(0, 0);
    closeButtonBackgroup.position = CGPointMake(0, 0);
    closeButtonBackgroup.zPosition = 20;
    [self addChild:closeButtonBackgroup];
    
    SK_Button *closeButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_map_fishFarm")[1]];
    closeButton.position = CGPointMake(61, 63);
    [closeButtonBackgroup addChild:closeButton];
    
    StaticActions *sa = [StaticActions single];
    [closeButton playSound:sa.sound_buttonB];
    [closeButton event:^{
        [self removeFromParent];
    }];
}

-(void)newScrollView
{
    _scrollView = [SK_ScrollView createScrollViewWithSize:CGSizeMake(iw, ih)];
    _scrollView.anchorPoint = CGPointMake(0, 0);
    _scrollView.position = CGPointMake(0, 0);
    [self addChild:_scrollView];
}

-(void)removeFromParent
{
    ClassCenter *cc = [ClassCenter singleton];
    cc.isOpenFillScene = 0;
    
    [_backgroup removeAllChildren];
    [_backgroup removeFromParent];
    _backgroup = nil;
    
    [_scrollView removeAllChildren];
    [_scrollView removeFromParent];
    _scrollView = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
}

@end
