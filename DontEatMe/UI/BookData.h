//
//  BookData.h
//  DontEatMe
//
//  Created by ym on 15/6/3.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BookData : SKSpriteNode

-(id)initWithDic:(NSDictionary *)theDic isHave:(int)theIsHave;
-(void)closeBlock:(void (^) ())block;

@end
