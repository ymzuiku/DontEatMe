//
//  SK_ActionLibrary.h
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKExtendHeader.h"

enum {
    ActionBig = 0,
    ActionMiniBig,
    ActionLeftRight,
    ActionWater,
    
};

@interface SK_Actions : SKAction

+(id)actionAnime:(NSArray *)array repeat:(int)number;
+(id)actionLeftRight:(float)value;
+(id)actionBig;
+(id)actionMiniBig;
+(id)actionMiniRote;
+(id)actionWater;
+(id)actionWaterMiddleQuick;
+(id)actionWaterOnes;
+(id)actionVerticalDown;
+(id)actionDown;
+(id)actionWait;
+(id)actionSpringUpWindow;
+(id)actionSpringDownWindow;
+(id)actionSpringRightInWindow;
+(id)actionSpringLeftOutWindow;
-(void)middleBlock:(void (^)())block;
+(id)actionHammer;
+(SKAction *)jump:(float)hight timeRate:(float)time;

@end
