//
//  FreeHighEnergy.h
//  DontEatMe
//
//  Created by ym on 14/11/27.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FreeHighEnergy : SKSpriteNode

-(id)initWithString:(NSString *)string block:(void (^)())block;
-(void)createPartique;

@end
