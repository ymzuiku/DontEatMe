//
//  Jelly.h
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "Body.h"

@interface Jelly : Body

@property   int isTouchKill;
@property   BOOL reflection;
@property   BOOL isGemA;
@property   BOOL isGemB;
@property   int gridNumber;
@property   int isCallBackMana;
@property   SKTexture *gemTexture;
@property   BOOL isNotAtlas_Static;
@property   int lineOfJellyOn;

//clear static
+(void)clearStatic;
-(void)changeGem;

@end
