//
//  MiniChicken.m
//  DontEatMe
//
//  Created by ym on 15/5/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "MiniChicken.h"

@implementation MiniChicken

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_miniChicken_move")[0]]) {
        
    }
    return self;
}


-(void)createInit
{
    [super createInit];
    self.hidden = NO;
    self.myName = @"mini";
    self.texString_attack = @"chicken_miniChicken_attack";
    self.texString_move = @"chicken_miniChicken_move";
    self.texString_rest = @"chicken_miniChicken_rest";
    self.isCanNotCoill = YES;
    [self sitDefaultHP:self.defaultHP*0.8];
    self.speedMove = self.speedMove*1.2;
}
	
-(void)startup
{
    [super startup];
    self.isCanNotCoill = NO;
    self.hpBar.position = CGPointMake(hpPosX+5, hpPosY-25);
}

-(void)flyDown
{
    float key = 0.042, py = 186.8;
    SKAction *f1 = [SKAction fadeInWithDuration:0.01];
    SKAction *p1 = [SKAction moveTo:CGPointMake(self.position.x, self.position.y+py-0) duration:0.000001];
    SKAction *p2 = [SKAction moveTo:CGPointMake(self.position.x, self.position.y+py-45) duration:key*4];
    SKAction *p3 = [SKAction moveTo:CGPointMake(self.position.x, self.position.y+py-99.6) duration:key*4];
    SKAction *p4 = [SKAction moveTo:CGPointMake(self.position.x, self.position.y+py-186.5) duration:key*5];
    SKAction *p5 = [SKAction moveTo:CGPointMake(self.position.x, self.position.y+py-194.7) duration:key*2];
    SKAction *p6 = [SKAction moveTo:CGPointMake(self.position.x, self.position.y+py-183.0) duration:key*4];
    SKAction *p7 = [SKAction moveTo:CGPointMake(self.position.x, self.position.y+py-188.0) duration:key*4];
    SKAction *p8 = [SKAction moveTo:CGPointMake(self.position.x, self.position.y+py-185.9) duration:key*4];
    SKAction *p9 = [SKAction moveTo:CGPointMake(self.position.x, self.position.y) duration:key*4];
    SKAction *ppp = [SKAction sequence:@[p1,f1, p2, p3, p4, p5, p6, p7, p8, p9]];
    
    SKAction *r1 = [SKAction rotateToAngle:iPI(-87) duration:0.000001];
    SKAction *r2 = [SKAction rotateToAngle:iPI(0) duration:key*13];
    SKAction *rrr = [SKAction sequence:@[r1, r2]];
    
    SKAction *group = [SKAction group:@[ppp, rrr]];
    
    [self runAction:group completion:^{
        [self startup];
    }];
}

@end
