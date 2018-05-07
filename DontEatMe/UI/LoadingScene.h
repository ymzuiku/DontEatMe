//
//  LoadingScene.h
//  DontEatMe
//
//  Created by ym on 14/9/6.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LoadingScene : SKScene

+(LoadingScene *)createAtlas:(NSArray *)atlasNames classNumble:(int)numble block:(void (^)())block;
+(LoadingScene *)createAtlas:(NSArray *)atlasNames block:(void (^)())block;
-(id)initWithAtlas:(NSArray *)atlasNames block:(void (^)())block;

@end
