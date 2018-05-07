//
//  SelectJellys.h
//  DontEatMe
//
//  Created by ym on 14/7/6.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BookData.h"
#import "TopBar.h"

@interface SelectJellys : SKSpriteNode

@property (nonatomic) BookData *bookData;
@property (nonatomic) int classNumber;

-(void)moveWindow;
-(void)hiddenJellyGoldTip:(NSString *)jellyName;
-(void)createInit;

@end
