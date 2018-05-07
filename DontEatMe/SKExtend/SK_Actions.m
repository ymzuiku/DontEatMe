//
//  SK_ActionLibrary.m
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "SK_Actions.h"

@implementation SK_Actions
{
    void (^myBlock)();
}

-(void)middleBlock:(void (^)())block
{
    myBlock = block;
}

+(id)actionAnime:(NSArray *)array repeat:(int)number;
{
    SKAction *anime = [SKAction animateWithTextures:array timePerFrame:0.042 resize:YES restore:NO];
    if (number == 0) {
        SKAction *rep = [SKAction repeatActionForever:anime];
        return rep;
    }
    else if (number == -1) {
        SKAction *animeBack = [anime reversedAction];
        SKAction *seq = [SKAction sequence:@[anime, animeBack]];
        return seq;
    }
    else if (number == -2) {
        SKAction *animeBack = [anime reversedAction];
        SKAction *seq = [SKAction sequence:@[anime, animeBack]];
        SKAction *rep = [SKAction repeatActionForever:seq];
        return rep;
    }
    else if (number == 1) {
        return anime;
    }
    else {
        SKAction *rep = [SKAction repeatAction:anime count:number];
        return rep;
    }
}

+(id)actionBig
{
    SKAction *b1 = [SKAction scaleBy:1*1.45 duration:0.042*1.5];
    SKAction *b2 = [SKAction scaleBy:1/1.45*0.78 duration:0.042*2.1];
    SKAction *b3 = [SKAction scaleBy:1/0.78*1.06 duration:0.042*1.9];
    SKAction *b4 = [SKAction scaleBy:1/1.06 duration:0.042*1.5];
    SKAction *seq = [SKAction sequence:@[b1, b2, b3, b4]];
    return seq;
}

+(id)actionMiniBig
{
    SKAction *b1 = [SKAction scaleBy:1*1.05 duration:0.042*1.5];
    SKAction *b2 = [SKAction scaleBy:1/1.05*0.95 duration:0.042*2.1];
    SKAction *b3 = [SKAction scaleBy:1/0.95 duration:0.042*1.9];
    SKAction *b4 = [SKAction scaleBy:1 duration:0.042*1.5];
    SKAction *seq = [SKAction sequence:@[b1, b2, b3, b4]];
    return seq;
}

+(id)actionMiniRote;
{
    SKAction *b1 = [SKAction rotateToAngle:iPI(1.45) duration:0.042*1.5];
    SKAction *b2 = [SKAction rotateToAngle:iPI(1/1.45*0.78) duration:0.042*1.5];
    SKAction *b3 = [SKAction rotateToAngle:iPI(1/0.78*1.06) duration:0.042*1.5];
    SKAction *b4 = [SKAction rotateToAngle:iPI(1/1.06) duration:0.042*1.5];
    SKAction *seq = [SKAction sequence:@[b1, b2, b3, b4]];
    return seq;
}

+(id)actionLeftRight:(float)value;
{
    SKAction *b1 = [SKAction moveByX:20*value y:0 duration:0.042*1.5];
    SKAction *b2 = [SKAction moveByX:-16*value y:0 duration:0.042*2.1];
    SKAction *b3 = [SKAction moveByX:7*value y:0 duration:0.042*1.9];
    SKAction *b4 = [SKAction moveByX:-11*value y:0 duration:0.042*1.5];
    
    SKAction *seq = [SKAction sequence:@[b1, b2, b3, b4]];
    return seq;
}

+(id)actionWaterOnes
{
    SKAction *action0 = [self waterSubAction:0.8];
    SKAction *action1 = [self waterSubAction:1];
    SKAction *sequence = [SKAction sequence:@[action0, action1]];
    SKAction *rep = [SKAction repeatAction:sequence count:1];
    return rep;
}

+(id)actionWater
{
    SKAction *action0 = [self waterSubAction:2];
    SKAction *action1 = [self waterSubAction:3];
    SKAction *sequence = [SKAction sequence:@[action0, action1]];
    SKAction *rep = [SKAction repeatActionForever:sequence];
    return rep;
}

+(id)actionWaterMiddleQuick
{
    SKAction *action0 = [self waterSubAction:1.2];
    SKAction *action1 = [self waterSubAction:1.6];
    SKAction *sequence = [SKAction sequence:@[action0, action1]];
    SKAction *rep = [SKAction repeatActionForever:sequence];
    return rep;
}

+(SKAction *)waterSubAction:(float)value
{
    SKAction *wait = [SKAction waitForDuration:0.3/3*value];
    SKAction *roteUp = [SKAction rotateByAngle:iPI(-0.6) duration:0.3*3*value];
    SKAction *moveUp = [SKAction moveByX:0 y:10 duration:0.3*4*value];
    SKAction *roteDown = [SKAction rotateByAngle:iPI(0.6) duration:0.3*4*value];
    SKAction *moveDown = [SKAction moveByX:0 y:-10 duration:0.3*5*value];
    SKAction *seq = [SKAction sequence:@[wait, roteUp, moveUp, roteDown, moveDown]];
    seq.timingMode = SKActionTimingEaseInEaseOut;
    return seq;
}

+(id)actionVerticalDown
{
    float key = 0.042, py = 186.8;
    
    SKAction *f1 = [SKAction fadeInWithDuration:0.01];
    SKAction *p1 = [SKAction moveTo:CGPointMake(0, py-0) duration:0.000001];
    SKAction *p2 = [SKAction moveTo:CGPointMake(0, py-45) duration:key*4];
    SKAction *p3 = [SKAction moveTo:CGPointMake(0, py-99.6) duration:key*4];
    SKAction *p4 = [SKAction moveTo:CGPointMake(0, py-186.5) duration:key*5];
    SKAction *p5 = [SKAction moveTo:CGPointMake(0, py-194.7) duration:key*2];
    SKAction *p6 = [SKAction moveTo:CGPointMake(0, py-183.0) duration:key*4];
    SKAction *p7 = [SKAction moveTo:CGPointMake(0, py-188.0) duration:key*4];
    SKAction *p8 = [SKAction moveTo:CGPointMake(0, py-185.9) duration:key*4];
    SKAction *p9 = [SKAction moveTo:CGPointMake(0, 0) duration:key*4];
    SKAction *ppp = [SKAction sequence:@[p1,f1, p2, p3, p4, p5, p6, p7, p8, p9]];
    
    SKAction *r1 = [SKAction rotateToAngle:iPI(-87) duration:0.000001];
    SKAction *r2 = [SKAction rotateToAngle:iPI(0) duration:key*13];
    SKAction *rrr = [SKAction sequence:@[r1, r2]];
    
    SKAction *t1 = [SKAction fadeOutWithDuration:0.01];
    SKAction *t2 = [SKAction fadeInWithDuration:key*10];
    SKAction *ttt = [SKAction sequence:@[t1, t2]];
    
    SKAction *group = [SKAction group:@[ppp, rrr, ttt]];
    return group;
}

+(id)actionDown
{
    float key = 0.042,
    px = 188.5, py = 186.8;
    
    SKAction *f1 = [SKAction fadeInWithDuration:0.01];
    SKAction *p1 = [SKAction moveTo:CGPointMake(-px+51.5, +py-126.5) duration:0.000001];
    SKAction *p2 = [SKAction moveTo:CGPointMake(-px+72.6, +py-101.5) duration:key*4];
    SKAction *p3 = [SKAction moveTo:CGPointMake(-px+143, +py-99.6) duration:key*4];
    SKAction *p4 = [SKAction moveTo:CGPointMake(-px+188.5, +py-186.5) duration:key*5];
    SKAction *p5 = [SKAction moveTo:CGPointMake(-px+188.1, +py-194.7) duration:key*2];
    SKAction *p6 = [SKAction moveTo:CGPointMake(-px+188.7, +py-183.0) duration:key*4];
    SKAction *p7 = [SKAction moveTo:CGPointMake(-px+188.4, +py-188.0) duration:key*4];
    SKAction *p8 = [SKAction moveTo:CGPointMake(-px+188.5, +py-185.9) duration:key*4];
    SKAction *p9 = [SKAction moveTo:CGPointMake(0, 0) duration:key*4];
    SKAction *ppp = [SKAction sequence:@[p1,f1, p2, p3, p4, p5, p6, p7, p8, p9]];
    
    SKAction *r1 = [SKAction rotateToAngle:iPI(-87) duration:0.000001];
    SKAction *r2 = [SKAction rotateToAngle:iPI(0) duration:key*13];
    SKAction *rrr = [SKAction sequence:@[r1, r2]];
    
    SKAction *s1 = [SKAction scaleBy:0.5 duration:0.01];
    SKAction *s2 = [SKAction scaleBy:2 duration:key*13];
    SKAction *sss = [SKAction sequence:@[s1, s2]];
    
    SKAction *t1 = [SKAction fadeOutWithDuration:0.01];
    SKAction *t2 = [SKAction fadeInWithDuration:key*10];
    SKAction *ttt = [SKAction sequence:@[t1, t2]];
    
    SKAction *group = [SKAction group:@[ppp, sss, rrr, ttt]];
    return group;
}

+(id)actionWait
{
    float key = 0.042;
    SKAction *p1 = [SKAction moveByX:0.5 y:9 duration:key*17];
    SKAction *p2 = [SKAction moveByX:0 y:0 duration:key*25];
    SKAction *p3 = [SKAction moveByX:-0.5 y:-9 duration:key*23];
    SKAction *ppp = [SKAction sequence:@[p1, p2, p3]];
    ppp.timingMode = SKActionTimingEaseIn;
    
    SKAction *r1 = [SKAction rotateToAngle:iPI(5) duration:key*17];
    SKAction *r2 = [SKAction rotateToAngle:iPI(-3.2) duration:key*27];
    SKAction *r3 = [SKAction rotateToAngle:iPI(0) duration:key*23];
    SKAction *rrr = [SKAction sequence:@[r1, r2, r3]];
    
    SKAction *group = [SKAction group:@[rrr, ppp]];
    SKAction *rep = [SKAction repeatActionForever:group];
    return rep;
}

+(id)actionSpringUpWindow
{
    float v = iPhone5 ? 1 : 960/1136.0;
    float t = -0.2;
    SKAction *p1 = [SKAction moveTo:CGPointMake(0, ih/2-505*v) duration:0.042*(8+t)];
    SKAction *p2 = [SKAction moveTo:CGPointMake(0, ih/2-587.7*v) duration:0.042*(5+t)];
    SKAction *p3 = [SKAction moveTo:CGPointMake(0, ih/2-555.8*v) duration:0.042*(3+t)];
    SKAction *p4 = [SKAction moveTo:CGPointMake(0, ih/2-572.5*v) duration:0.042*(5+t)];
    SKAction *p5 = [SKAction moveTo:CGPointMake(0, ih/2-565.9*v) duration:0.042*(4+t)];
    SKAction *p6 = [SKAction moveTo:CGPointMake(0, ih/2-568.9*v) duration:0.042*(5+t)];
    SKAction *p7 = [SKAction moveTo:CGPointMake(0, 0) duration:0.042*(6+t)];
    SKAction *ppp = [SKAction sequence:@[p1, p2, p3, p4, p5, p6, p7]];
    return ppp;
}

+(id)actionSpringDownWindow
{
    float v = iPhone5 ? 1 : 960/1136.0;

    SKAction *p1 = [SKAction moveTo:CGPointMake(0, ih/2-505*v) duration:0.042*4];
    SKAction *p2 = [SKAction moveTo:CGPointMake(0, -ih) duration:0.042*9];
    p2.timingMode = SKActionTimingEaseOut;
    SKAction *ppp = [SKAction sequence:@[p1, p2]];
    return ppp;
}

+(id)actionSpringRightInWindow
{
    //5,9,13,15,18,21,25,28,31
    SKAction *p1 = [SKAction moveTo:CGPointMake(iw, 0) duration:0.0001];
    SKAction *p2 = [SKAction moveTo:CGPointMake(-125.3, 0) duration:0.042*6];
    SKAction *p3 = [SKAction moveTo:CGPointMake(0, 0) duration:0.042*2.5];
    SKAction *p4 = [SKAction moveTo:CGPointMake(35.9, 0) duration:0.042*1];
    SKAction *p5 = [SKAction moveTo:CGPointMake(11.1, 0) duration:0.042*2];
    SKAction *p6 = [SKAction moveTo:CGPointMake(-10.3, 0) duration:0.042*2];
    SKAction *p7 = [SKAction moveTo:CGPointMake(0, 0) duration:0.042*3];
    SKAction *p8 = [SKAction moveTo:CGPointMake(2.8, 0) duration:0.042*2];
    SKAction *p9 = [SKAction moveTo:CGPointMake(0, 0) duration:0.042*2];
    p2.timingMode = SKActionTimingEaseIn;
    SKAction *ppp = [SKAction sequence:@[p1, p2, p3, p4, p5, p6, p7, p8, p9]];
    return ppp;
}

+(id)actionSpringLeftOutWindow
{
    SKAction *p1 = [SKAction moveTo:CGPointMake(20, 0) duration:0.042*3.5];
    SKAction *p2 = [SKAction moveTo:CGPointMake(-iw, 0) duration:0.042*6];
    p2.timingMode = SKActionTimingEaseOut;
    SKAction *ppp = [SKAction sequence:@[p1, p2]];
    return ppp;
}

+(id)actionHammer
{
    //def 80度
    SKAction *r1 = [SKAction rotateToAngle:0 duration:0.042*5];
    SKAction *r2 = [SKAction rotateToAngle:iPI(2.7) duration:0.042*1];
    SKAction *r3 = [SKAction rotateToAngle:iPI(-1.1) duration:0.042*2];
    SKAction *r4 = [SKAction rotateToAngle:iPI(0.6) duration:0.042*1];
    SKAction *r5 = [SKAction rotateToAngle:iPI(-0.4) duration:0.042*2];
    SKAction *r6 = [SKAction rotateToAngle:iPI(0.2) duration:0.042*2];
    SKAction *r7 = [SKAction rotateToAngle:iPI(-0.1) duration:0.042*2];
    SKAction *r8 = [SKAction rotateToAngle:iPI(0) duration:0.042*1];
    SKAction *wait = [SKAction waitForDuration:1.5];
    SKAction *seq = [SKAction sequence:@[r1, r2, r3, r4, r5, r6, r7, r8, wait]];
    return seq;
}

+(SKAction *)jump:(float)hight timeRate:(float)time
{
    SKAction *down0 = [SKAction moveByX:0 y:15*hight duration:0.1*time];
    SKAction *down1 = [SKAction moveByX:0 y:-15*hight duration:0.1*time];
    SKAction *down2 = [SKAction moveByX:0 y:5*hight duration:0.1*time];
    SKAction *down3 = [SKAction moveByX:0 y:-5*hight duration:0.1*time];
    down0.timingMode = SKActionTimingEaseOut;
    down1.timingMode = SKActionTimingEaseIn;
    down2.timingMode = SKActionTimingEaseOut;
    down3.timingMode = SKActionTimingEaseIn;
    SKAction *seq = [SKAction sequence:@[down0, down1, down2, down3]];
    return seq;
}

@end
