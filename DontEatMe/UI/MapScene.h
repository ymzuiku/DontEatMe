//
//  MapScene.h
//  DontEatMe
//
//  Created by ym on 14/9/5.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TopBar.h"

@interface MapScene : SKScene

-(id)initIsWin:(int)isWin_;
+(id)createMapWithWin:(int)isWin;
-(void)createAGame:(int)number classString:(NSString *)classString;
-(void)createStoryWithNumber:(int)number string:(NSString *)string block:(void (^)())block;
-(void)moveBarShow;
-(void)moveBarHidden;

@property (nonatomic) SK_ScrollView *sv;
@property (nonatomic) BOOL isBottomMove;
@property (nonatomic) TopBar *topBar;

@end
