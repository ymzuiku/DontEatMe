//
//  MapJelly.h
//  DontEatMe
//
//  Created by ymMac on 14-8-4.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MapJelly : SK_Button

-(id)initWithLine:(SK_PSD *)line_;
-(void)moveTo:(int)number lineIdx:(int)lineIdx isLost:(int)isLost_;

@end
