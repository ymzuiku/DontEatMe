//
//  AtlasController.m
//  DontEatMe
//
//  Created by ym on 14/9/5.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "AtlasController.h"

@implementation AtlasController
{
    int needLoadNumber;
    int loadNumber;
    void (^myBlock)();
}

+(AtlasController *)single
{
    static AtlasController *single;
    if (!single) {
        single = [[AtlasController alloc] init];
        single.atlasDic = [NSMutableDictionary dictionary];
    }
    return single;
}

-(void)clearAtlas:(void (^)())block
{
    [self.atlasDic removeAllObjects];
    if (block) block();
}

-(NSArray *)newAtlas:(NSString *)atlasName
{
    if ([self.atlasDic objectForKey:atlasName]) {
        return [self.atlasDic objectForKey:atlasName];
    }
//    else if (Atlas_Static(atlasName)){
//        return Atlas_Static(atlasName);
//    }
    else {
        [self.atlasDic setValue:[AtlasController tempAtlas:atlasName] forKey:atlasName];
        return [self.atlasDic objectForKey:atlasName];
    }
}

-(void)loadAtlas:(NSArray *)names completion:(void (^) ())block;
{
//    if(block) block();
//    return
    [self.atlasDic removeAllObjects];
    self.atlasDic = nil;
    self.atlasDic = [NSMutableDictionary dictionary];
    
    loadNumber = 0;
    needLoadNumber = (int)names.count -1;
    for (NSString *name in names) {
        [self loadSomeAtlas:name];
    };
    myBlock = block;
}

-(void)addAtlas:(NSArray *)names completion:(void (^) ())block
{
    loadNumber = 0;
    needLoadNumber = (int)names.count -1;
    for (NSString *name in names) {
        [self loadSomeAtlas:name];
    };
    myBlock = block;
}

-(void)loadSomeAtlas:(NSString *)atlasName
{
    if (!atlasName) {
        return;
    }
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName];
    int number = (int)atlas.textureNames.count;
    [atlas preloadWithCompletionHandler:^{
        if ([self.atlasDic objectForKey:atlasName]) {
            loadNumber++;
        }
        else {
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i< number; i++) {
                NSString *fileName = [NSString stringWithFormat:@"%@_%d", atlasName, i];
                [array addObject:[atlas textureNamed:fileName]];
            }
            [self.atlasDic setValue:array forKey:atlasName];
            loadNumber++;
        }
        if (loadNumber > needLoadNumber) {
            if (myBlock) myBlock();
            myBlock = nil;
            NSLog(@"一共 %d / %d", loadNumber, needLoadNumber);
        }
    }];
}

+(NSArray *)tempAtlas:(NSString *)atlasName
{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName];
    int number = (int)atlas.textureNames.count;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i< number; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%@_%d", atlasName, i];
        [array addObject:[atlas textureNamed:fileName]];
    }
    return array;
}


@end
