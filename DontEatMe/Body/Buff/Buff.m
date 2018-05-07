//
//  Buff.m
//  DontEatMe
//
//  Created by ym on 15/1/20.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "Buff.h"
#import "Body.h"

@implementation Buff
{
    BOOL isColoring;
    Body *theBody;
}

-(id)initWithBody:(Body *)aBody
{
    if (self = [super init]) {
        theBody = aBody;
        self.moveSpeed = 1;
        self.attackSpeed = 1;
        self.skillSpeed = 1;
        
    }
    return self;
}

-(void)beginBuff
{
    self.isBuffing = YES;
}

-(void)clearBuff
{
    self.isBuffing = NO;
}

-(void)changeColorIn:(UIColor *)color blend:(float)blend time:(float)time body:(Body *)aBody;
{
    if (isColoring == YES) {
        return;
    }
    isColoring = YES;
    aBody.isChangeColoring = YES;
    SKAction *changeColor = [SKAction colorizeWithColor:color colorBlendFactor:blend duration:time];
    [aBody runAction:changeColor];
}

-(void)changeColorOutWithBody:(Body *)aBody
{
    isColoring = NO;
    aBody.isChangeColoring = NO;
    SKAction *changeColor = [SKAction colorizeWithColor:aBody.color colorBlendFactor:0 duration:0.1];
    [aBody runAction:changeColor];
}


@end
