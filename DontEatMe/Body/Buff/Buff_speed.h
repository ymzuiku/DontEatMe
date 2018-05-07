//
//  BuffOfSpeed.h
//  DontEatMe
//
//  Created by ym on 15/1/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "Buff.h"

@interface Buff_speed : Buff

@property   NSString *animeRestString;
@property   NSString *animeCreateString;
@property   NSString *animeDieString;
@property   UIColor *changeColor;
@property   float changeColorTime;


-(void)createDifferent;

@end
