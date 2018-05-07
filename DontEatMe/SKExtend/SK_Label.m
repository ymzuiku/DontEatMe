//
//  SK_Label.m
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "SK_Label.h"

@implementation SK_Label
{
    NSString *_text;
}
@synthesize text = _text;

+(id)createLabelWithFont:(NSString *)aFont line:(int)aLine size:(float)aSize color:(UIColor *)aColor
{
    return [[SK_Label alloc] initWithFont:aFont line:aLine size:aSize color:aColor horizontal:SKLabelHorizontalAlignmentModeLeft];;
}


+(id)createLabelWithFont:(NSString *)aFont line:(int)aLine size:(float)aSize color:(UIColor *)aColor horizontal:(SKLabelHorizontalAlignmentMode)align
{
    return [[SK_Label alloc] initWithFont:aFont line:aLine size:aSize color:aColor horizontal:align];
}

-(id)initWithFont:(NSString *)aFont line:(int)aLine size:(float)aSize color:(UIColor *)aColor horizontal:(SKLabelHorizontalAlignmentMode)align
{
    if (self = [super initWithColor:[UIColor clearColor] size:CGSizeMake(100, 100)]) {
        _myfont = aFont;
        _myLine = aLine;
        _mySize = aSize;
        _myColor = aColor;
        _myAlign = align;
    }
    return self;
}

-(void)setIcon:(SKTexture *)icon
{
    SKSpriteNode *iconSprite = [SKSpriteNode spriteNodeWithTexture:icon];
    iconSprite.name = @"icon";
    if (_myAlign == SKLabelHorizontalAlignmentModeLeft) {
        iconSprite.position = CGPointMake(-_mySize*0.6, 0);
    }
    else if (_myAlign == SKLabelHorizontalAlignmentModeRight) {
        iconSprite.position = CGPointMake(_mySize*0.6, 0);
    }
    else if (_myAlign == SKLabelHorizontalAlignmentModeCenter) {
        iconSprite.position = CGPointMake(-_mySize*0.6-self.text.length/2*_mySize, 0);
        iconSprite.anchorPoint = CGPointMake(1, 0.5);
    }
    [self addChild:iconSprite];
}


-(void)setText:(NSString *)text
{
    _text = text;
    [self enumerateChildNodesWithName:@"label" usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
    
    if (_myLine == 0) {
        [self zeroLineText:text];
        return;
    }
    else if (_myLine < 0) {
        NSArray *array = [text componentsSeparatedByString:@"*"];
        [self createLabel:array labelName:@"label"];
        return;
    }
    
    NSMutableArray *strArray = [NSMutableArray array];
    NSString *surplus = text;
    
    int number = (int)(text.length+_myLine-1)/_myLine;
    
    for (int i = 0; i < number; i++) {
        
        int line = _myLine;
        NSString *str;
        
        if (surplus.length <= _myLine) {
            str = surplus;
            [strArray addObject:str];
            [self createLabel:strArray labelName:@"label"];
            return;
        }
        
        NSString *tempStr = [surplus substringToIndex:_myLine+1];
        if ([tempStr hasSuffix:@"？"] || [tempStr hasSuffix:@"，"] || [tempStr hasSuffix:@"。"]|| [tempStr hasSuffix:@"！"]
            || [tempStr hasSuffix:@" "] || [tempStr hasSuffix:@"-"] || [tempStr hasSuffix:@"?"] || [tempStr hasSuffix:@","]
            || [tempStr hasSuffix:@"."] || [tempStr hasSuffix:@"!"] || [tempStr hasSuffix:@"'"]) {
            line = _myLine+1;
        }else {
            line = _myLine;
        }
        
        str = [surplus substringToIndex:line];
        surplus = [surplus substringFromIndex:line];
        [strArray addObject:str];
    }
    [self createLabel:strArray labelName:@"label"];
    
}

-(void)zeroLineText:(NSString *)aString
{
    NSMutableArray *strArray = [NSMutableArray array];
    [strArray addObject:aString];
    [self createLabel:strArray labelName:@"label"];
}

-(void)createLabel:(NSArray *)array labelName:(NSString *)labelName;
{
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:_myfont];
        label.name = labelName;
        label.text = obj;
        label.fontColor = _myColor;
        label.fontSize = _mySize;
        label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        label.horizontalAlignmentMode = _myAlign;
        float h = _mySize;
        float a = _mySize/3;
        float num;
        float count = array.count;
        
        if (_myAlign == SKLabelHorizontalAlignmentModeCenter) {
            self.anchorPoint = CGPointMake(0.5, 0.5);
        }
        else if (_myAlign == SKLabelHorizontalAlignmentModeLeft) {
            self.anchorPoint = CGPointMake(0, 0.5);
        }
        else if (_myAlign == SKLabelHorizontalAlignmentModeRight) {
            self.anchorPoint = CGPointMake(1, 0.5);
        }
        
        if (array.count%2 == 0) {
            num = (int)(idx - count/2);
            label.position = CGPointMake(0, -(num*h+(num+1)*a+a));
        }
        
        else {
            num = idx - (count+1)/2;
            label.position = CGPointMake(0, -(num*h+(num+1)*a+h));
        }
        [self addChild:label];
    }];
}


@end
