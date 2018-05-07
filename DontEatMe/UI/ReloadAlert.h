//
//  ReloadAlert.h
//  DontEatMe
//
//  Created by ym on 14/12/27.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ReloadAlert : SKSpriteNode

-(void)cancel:(void (^)())block;

@end
