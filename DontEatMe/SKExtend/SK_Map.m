//
//  SKEMapTexture.m
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "SK_Map.h"

@implementation SK_Map
{
    float tempWidth, tempHeight, lastWidth, lastHeight;
}

+(id)createMapWithAtlasName:(NSString *)name size:(CGSize)size;
{
    return [[SK_Map alloc] initWithAtlasName:name size:size];
}

-(id)initWithAtlasName:(NSString *)name size:(CGSize)size;
{
    
    if (self = [super initWithColor:[UIColor clearColor] size:size]) {
        NSArray *atlasArray = [self arrayFormAtlasName:name];
        [atlasArray enumerateObjectsUsingBlock:^(SKTexture *obj, NSUInteger idx, BOOL *stop) {
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:obj];
            tempWidth += lastWidth;
            if (tempWidth > size.width) {
                tempWidth = 0;
                tempHeight +=lastHeight;
            }
            sprite.position = CGPointMake(tempWidth, tempHeight);
            sprite.anchorPoint = CGPointMake(0, 0);
            [self addChild:sprite];
            lastWidth = sprite.size.width;
            lastHeight = sprite.size.height;
        }];
    }
    return self;
}

-(NSArray *)arrayFormAtlasName:(NSString *)atlasName
{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName];
    [atlas preloadWithCompletionHandler:^{ }];
    
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:atlas.textureNames.count];
    for (int i = 0; i< atlas.textureNames.count; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%@_%d", atlasName, i];
        [frames addObject:[atlas textureNamed:fileName]];
    }
    
    atlas = nil;
    return frames;
}

@end
