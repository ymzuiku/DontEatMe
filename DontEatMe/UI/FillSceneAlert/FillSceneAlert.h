//
//  FillSceneAlert.h
//  DontEatMe
//
//  Created by ym on 15/2/25.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class SK_ScrollView;

@interface FillSceneAlert : SKSpriteNode

-(void)createInit;
-(void)newCloseButton;

@property SKSpriteNode *backgroup;
@property SK_ScrollView *scrollView;

@end
