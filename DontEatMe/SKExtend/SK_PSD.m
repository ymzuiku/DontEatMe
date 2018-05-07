//
//  PSDLayer.m
//  PSFrameToSpriteKit
//
//  Created by ymMac on 14-8-3.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "SK_PSD.h"


@implementation SK_PSD
{
    NSString *grounName;
    NSMutableArray *jsonArray;
    CGSize layerSize;
    CGRect layerRect;
    NSArray *loadNums;
}

-(void)removeFromParent
{
    [self removeAllChildren];
    [super removeFromParent];
}

+(id)createOneAltasWithPath:(NSString *)path name:(NSString *)name atlasName:(NSString *)atlasName
{
    return [[SK_PSD alloc] initOneAltasWithPath:path name:name atlasName:atlasName];
}
-(id)initOneAltasWithPath:(NSString *)path name:(NSString *)name atlasName:(NSString *)atlasName
{
    if (self = [super initWithTexture:Atlas(atlasName)[0]]) {
        NSArray *array = [self loadJsonWithName:[NSString stringWithFormat:@"%@/layers.json", path]];
        layerSize = CGSizeMake([array[0][@"layerFrame"][@"width"] floatValue],
                               [array[0][@"layerFrame"][@"height"] floatValue]);
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            if ([obj[@"name"] isEqualToString:name]) {
                NSArray *tempArray = [obj objectForKey:@"children"];
                
                [tempArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
                    if ([[dic objectForKey:@"name"] isEqualToString:atlasName]) {
                        float tempX = [dic[@"image"][@"frame"][@"x"] floatValue];
                        float tempY = [dic[@"image"][@"frame"][@"y"] floatValue];
                        float endX = tempX+self.size.width/2;
                        float endY = layerSize.height-(tempY+self.size.height/2);
                        self.position = CGPointMake(endX, endY);
                        self.zPosition = 0.01-idx/1000.0;
                    }
                }];
            }
        }];
    }
    return self;
}

+(id)createOneSpriteWithPath:(NSString *)path name:(NSString *)name spriteName:(NSString *)spriteName
{
    return [[SK_PSD alloc] initOneSpriteWithPath:path name:name spriteName:spriteName];
}
-(id)initOneSpriteWithPath:(NSString *)path name:(NSString *)name spriteName:(NSString *)spriteName
{
    NSString *imageString = [NSString stringWithFormat:@"%@/images/%@", path, spriteName];
    if (self = [super initWithImageNamed:imageString]) {
        NSArray *array = [self loadJsonWithName:[NSString stringWithFormat:@"%@/layers.json", path]];
        layerSize = CGSizeMake([array[0][@"layerFrame"][@"width"] floatValue],
                               [array[0][@"layerFrame"][@"height"] floatValue]);
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            if ([obj[@"name"] isEqualToString:name]) {
                NSArray *tempArray = [obj objectForKey:@"children"];
                
                [tempArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
                    if ([[dic objectForKey:@"name"] isEqualToString:spriteName]) {
                        float tempX = [dic[@"image"][@"frame"][@"x"] floatValue];
                        float tempY = [dic[@"image"][@"frame"][@"y"] floatValue];
                        float endX = tempX+self.size.width/2;
                        float endY = layerSize.height-(tempY+self.size.height/2);
                        self.position = CGPointMake(endX, endY);
                        self.zPosition = 0.01-idx/1000.0;
                    }
                }];
            }
        }];
    }
    return self;
}

+(NSArray *)createPostionsWithPath:(NSString *)path name:(NSString *)name;
{
    NSMutableArray *endArray = [NSMutableArray array];
    NSMutableArray *backArray = [NSMutableArray array];
    NSString *paths  = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/layers.json", path] ofType:nil];
    NSString *string = [[NSString alloc] initWithContentsOfFile:paths encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    CGSize bigSize = CGSizeMake([array[0][@"layerFrame"][@"width"] floatValue],
                                [array[0][@"layerFrame"][@"height"] floatValue]);
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"name"] isEqualToString:name]) {
            NSArray *tempArray = [obj objectForKey:@"children"];
            
            [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [backArray addObject:tempArray[tempArray.count - idx -1]];
            }];
            
            [backArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
                float tempX = [dic[@"image"][@"frame"][@"x"] floatValue];
                float tempY = [dic[@"image"][@"frame"][@"y"] floatValue];
                float tempW = [dic[@"image"][@"frame"][@"width"] floatValue];
                float tempH = [dic[@"image"][@"frame"][@"height"] floatValue];
                float endX = tempX+tempW/2;
                float endY = bigSize.height-(tempY+tempH/2);
                CGPoint pos = CGPointMake(endX, endY);
                [endArray addObject:[NSValue valueWithCGPoint:pos]];
            }];
        }
    }];
    return endArray;
}


//创建多个sprite
+(id)createWithPath:(NSString *)path name:(NSString *)name
{
    return [[SK_PSD alloc] initWithPath:path name:name loadNumbers:nil];
}

+(id)createWithPath:(NSString *)path name:(NSString *)name loadNumbers:(NSArray *)loadNumbers
{
    return [[SK_PSD alloc] initWithPath:path name:name loadNumbers:loadNumbers];
}

BOOL debug = isDebug;
-(id)initWithPath:(NSString *)path name:(NSString *)name loadNumbers:(NSArray *)loadNumbers;
{
    grounName = path;
    jsonArray = [NSMutableArray array];
    NSArray *array;
    loadNums = loadNumbers;
    /*
    if (iPhone5) array = [self loadJsonWithName:[NSString stringWithFormat:@"%@/layers640x1136.json", grounName]];
    else if (!iPhone5) array = [self loadJsonWithName:[NSString stringWithFormat:@"%@/layers640x960.json", grounName]];
    */ //未来用作适应各种分辨率
    
    array = [self loadJsonWithName:[NSString stringWithFormat:@"%@/layers.json", grounName]];

    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"name"] isEqualToString:name]) {
            NSArray *tempArray = [obj objectForKey:@"children"];
            [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [jsonArray addObject:tempArray[tempArray.count - idx -1]];
            }];
        }
    }];
    
    layerSize = CGSizeMake([array[0][@"layerFrame"][@"width"] floatValue],
                           [array[0][@"layerFrame"][@"height"] floatValue]);

    if ([jsonArray[0][@"name"] hasSuffix:@"#"]) {
        float tempWidth = [jsonArray[0][@"image"][@"frame"][@"width"] floatValue];
        float tempHeight = [jsonArray[0][@"image"][@"frame"][@"height"] floatValue];
        
        UIColor *color;
        if (debug) {
            color = rgb(0x0036ff, 0.33);
        }else {
            color = [UIColor clearColor];
        }
        if (self = [super initWithColor:color size:CGSizeMake(tempWidth, tempHeight)]) {
            
        }
    }
    else {
        NSString *imageString = [NSString stringWithFormat:@"%@/%@", grounName, jsonArray[0][@"image"][@"path"]];
        if (self = [super initWithImageNamed:imageString]) {

        }
    }
    
    self.name = name;
    float tempX = [jsonArray[0][@"image"][@"frame"][@"x"] floatValue];
    float tempY = [jsonArray[0][@"image"][@"frame"][@"y"] floatValue];
    float endX = tempX+self.size.width/2;
    float endY = layerSize.height-(tempY+self.size.height/2);
    self.position = CGPointMake(endX, endY);
    [self createSomeSprite];

    if (!iPhone5) {
        CGPoint temp = self.position;
        self.position = CGPointMake(temp.x, temp.y-(1136-960));
    }
    
    [jsonArray removeAllObjects];
    jsonArray = nil;
    return self;
}

-(NSArray *)loadJsonWithName:(NSString *)name
{
    NSString *path  = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return array;
}

-(void)createSomeSprite
{
    if (loadNums == nil) {
        [jsonArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            if (idx == 0) return;
            if ([[obj objectForKey:@"name"] hasSuffix:@"button"] || [[obj objectForKey:@"name"] hasSuffix:@"button#"]) {
                [self createButton:obj tag:(int)idx];
            }else {
                [self createImage:obj tag:(int)idx];
            }
        }];
        return;
    }
    
    //判断区间,只创建区间
    NSMutableArray *rangeArray = [NSMutableArray array];
    for (NSString *string in loadNums) {
        NSArray *subArray = [string componentsSeparatedByString:@"-"];
        [rangeArray addObject:subArray];
    }
    NSMutableArray *endArray = [NSMutableArray array];
    
    int jsonArrayCount = (int)jsonArray.count;
    for (int i = 0; i < jsonArrayCount; i++) {
        for (NSArray *array in rangeArray) {
            if (i >= [array[0] intValue] && i <= [array[1] intValue]) {
                [endArray addObject:@(i)];
            }
        }
    }
    _lineNumbers = endArray;
    [jsonArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) return;
        for (id a in endArray) {
            int num = [a intValue];
            
            if (idx == num+1) {
                if ([[obj objectForKey:@"name"] hasSuffix:@"button"] || [[obj objectForKey:@"name"] hasSuffix:@"button#"]) {
                    [self createButton:obj tag:(int)idx];
                }else {
                    [self createImage:obj tag:(int)idx];
                }
            }
        }
    }];
}


-(void)createImage:(NSDictionary *)dic tag:(int)tag_
{
    if ([dic[@"name"] hasSuffix:@"#"]) {
        float tempWidth = [dic[@"image"][@"frame"][@"width"] floatValue];
        float tempHeight = [dic[@"image"][@"frame"][@"height"] floatValue];
        
        UIColor *color;
        if (debug) {
            color = rgb(0x0036ff, 0.33);
        }else {
            color = [UIColor clearColor];
        }
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(tempWidth, tempHeight)];
        sprite.name = [dic objectForKey:@"name"];
        sprite.position = [self reloadPostion:dic];
        [self addChild:sprite];
    }
    else {
        NSString *imageString = [NSString stringWithFormat:@"%@/%@", grounName, dic[@"image"][@"path"]];
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:imageString]];
        sprite.name = [dic objectForKey:@"name"];
        sprite.position = [self reloadPostion:dic];
        [self addChild:sprite];
    }
}

-(void)createButton:(NSDictionary *)dic tag:(int)tag_
{
    if ([dic[@"name"] hasSuffix:@"#"]) {
        float tempWidth = [dic[@"image"][@"frame"][@"width"] floatValue];
        float tempHeight = [dic[@"image"][@"frame"][@"height"] floatValue];
        
        UIColor *color;
        if (debug) {
            color = rgb(0x0036ff, 0.33);
        }else {
            color = [UIColor clearColor];
        }
        
        SK_Button *button = [SK_Button spriteNodeWithColor:color size:CGSizeMake(tempWidth, tempHeight)];
        button.name = [dic objectForKey:@"name"];
        button.position = [self reloadPostion:dic];
        [button event:nil];
        [self addChild:button];
    }
    else {
        NSString *imageString = [NSString stringWithFormat:@"%@/%@", grounName, dic[@"image"][@"path"]];
        SK_Button *button = [SK_Button spriteNodeWithTexture:[SKTexture textureWithImageNamed:imageString]];
        button.name = [dic objectForKey:@"name"];
        button.position = [self reloadPostion:dic];
        [button event:nil];
        [self addChild:button];
    }

}

-(CGPoint)reloadPostion:(NSDictionary *)dic
{
    float x = [dic[@"image"][@"frame"][@"x"] floatValue];
    float y = [dic[@"image"][@"frame"][@"y"] floatValue];
    float width = [dic[@"image"][@"frame"][@"width"] floatValue];
    float height = [dic[@"image"][@"frame"][@"height"] floatValue];
    float endX = (x+width/2)-self.position.x;
    float endY = (layerSize.height-(y+height/2))-self.position.y;
    return CGPointMake(endX, endY);
}

@end
