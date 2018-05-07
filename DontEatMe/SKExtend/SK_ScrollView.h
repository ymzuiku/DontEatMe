//
//  SKEScrollView.h
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

/* 使用方法
SK_ScrollView *sv = [SK_ScrollView scrollViewWithSize:CGSizeMake(iw, ih)];
sv.zPosition = 1;
[self addChild:sv];

SK_Map *map = [SK_Map createMapWithAtlasName:@"map" size:CGSizeMake(5000, 3750)];
[sv addScrollNode:map];
[sv showRadar:[SKTexture textureWithImageNamed:@"back.png"]];
[sv moveTo:CGPointMake(963, 1293)];
 */

#import <SpriteKit/SpriteKit.h>

@interface SK_ScrollView : SKSpriteNode

+(id)createScrollViewWithSize:(CGSize)size;
-(void)addScrollNode:(SKSpriteNode *)node;
-(void)moveTo:(CGPoint)point;
-(void)jumpTo:(CGPoint)point;
-(void)showRadar:(SKTexture *)texture;
-(void)setScrollNodePosition:(CGPoint)pos;
-(void)scrollCallBack:(void (^)())callBack;

@property (nonatomic) BOOL canTouch;
@property (nonatomic) float scrollViewY;
@property (nonatomic) float scrollViewX;
@property (nonatomic) BOOL bouncesX;
@property (nonatomic) BOOL bouncesY;
@property (nonatomic) SKSpriteNode *miniMapBackground;

@end
