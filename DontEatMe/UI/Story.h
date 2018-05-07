//
//  Story.h
//  DontEatMe
//
//  Created by ymMac on 14-8-10.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Story : SKSpriteNode

+(id)createWithNumber:(int)number string:(NSString *)string;
-(id)initWithNumber:(int)number string:(NSString *)string;
-(void)event:(void(^)())block;
-(void)modoTouch;

@end
