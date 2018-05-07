//
//  PSDLayer.h
//  PSFrameToSpriteKit
//
//  Created by ymMac on 14-8-3.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKExtendHeader.h"

@interface SK_PSD : SKSpriteNode

+(id)createWithPath:(NSString *)path name:(NSString *)name;
+(id)createWithPath:(NSString *)path name:(NSString *)name loadNumbers:(NSArray *)loadNumbers;
-(id)initWithPath:(NSString *)path name:(NSString *)name loadNumbers:(NSArray *)loadNumbers;

+(id)createOneSpriteWithPath:(NSString *)path name:(NSString *)name spriteName:(NSString *)spriteName;
-(id)initOneSpriteWithPath:(NSString *)path name:(NSString *)name spriteName:(NSString *)spriteName;

+(id)createOneAltasWithPath:(NSString *)path name:(NSString *)name atlasName:(NSString *)atlasName;
-(id)initOneAltasWithPath:(NSString *)path name:(NSString *)name atlasName:(NSString *)atlasName;

+(NSArray *)createPostionsWithPath:(NSString *)path name:(NSString *)name;

@property (nonatomic) NSArray *lineNumbers;

@end
