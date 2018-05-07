//
//  QuitAlert.h
//  DontEatMe
//
//  Created by ym on 14-5-3.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface QuitAlert : SKSpriteNode

-(void)cancel:(void (^)())block;

@end
