//
//  AtlasController.h
//  DontEatMe
//
//  Created by ym on 14/9/5.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Atlas(name)             [[AtlasController single] newAtlas:name]
#define AtlasNum(name, idx)     [[[AtlasController single] newAtlas:name] objectAtIndex:idx]

@interface AtlasController : NSObject

@property (nonatomic) NSMutableDictionary *atlasDic;
+(AtlasController *)single;

-(void)loadAtlas:(NSArray *)names completion:(void (^) ())block;
-(void)addAtlas:(NSArray *)names completion:(void (^) ())block;
-(void)clearAtlas:(void (^) ())block;
-(void)loadSomeAtlas:(NSString *)atlasName;
+(NSArray *)tempAtlas:(NSString *)atlasName;
-(NSArray *)newAtlas:(NSString *)atlasName;

@end
