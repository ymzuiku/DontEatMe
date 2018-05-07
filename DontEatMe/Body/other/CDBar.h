//
//  CDBar.h
//  DontEatMe
//
//  Created by ym on 14/10/16.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CDBar : SKSpriteNode

@property float defaultAllTime;

@property BOOL isCding;
-(id)initWithName:(NSString *)name beginName:(NSString *)beginName_;
-(void)changeCDBar:(void (^)())block;


@end
