//
//  Background.h
//  DontEatMe
//
//  Created by ym on 14/7/7.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Background : SKSpriteNode

-(id)initWithType:(NSString *)type particle:(NSString *)particleName;

@property (nonatomic) SKSpriteNode *rootView;

@end
