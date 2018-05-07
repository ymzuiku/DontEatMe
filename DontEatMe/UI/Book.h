//
//  Book.h
//  DontEatMe
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BookData.h"

@interface Book : SKSpriteNode

@property (nonatomic) BookData *bookData;
@property (nonatomic) BOOL isMiddle;
@property (nonatomic) SKSpriteNode *lawn;
@property (nonatomic) int dontChangeTopbar;
@property (nonatomic) BOOL isPlayCloseAnime;

-(id)initWithChangeBackgound:(BOOL)isChangeBackground;
-(void)moveWindow:(void (^)())block;
-(void)hiddenJellyGoldTip:(NSString *)jellyName;
-(void)closeBlock:(void (^)())block;

@end
