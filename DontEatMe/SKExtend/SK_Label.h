//
//  SK_Label.h
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SK_Label : SKSpriteNode

+(id)createLabelWithFont:(NSString *)aFont line:(int)aLine size:(float)aSize color:(UIColor *)aColor;
+(id)createLabelWithFont:(NSString *)aFont line:(int)aLine size:(float)aSize color:(UIColor *)aColor horizontal:(SKLabelHorizontalAlignmentMode)align;


@property (nonatomic) NSString *text;
@property (nonatomic) SKTexture *icon;
@property SKLabelHorizontalAlignmentMode myAlign;
@property float mySize;
@property int myLine;
@property NSString *myfont;
@property UIColor *myColor;

@end
