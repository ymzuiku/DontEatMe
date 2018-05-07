//
//  RifleBullet.m
//  AtlasTesing
//
//  Created by pringlesfox on 4/23/14.
//  Copyright (c) 2014 ym. All rights reserved.
//

#import "RifleBullet.h"

@implementation RifleBullet
{
    SKAction *bulletMove;
    SKAction *bulletBlowUp;
}

-(void)removeFromParent
{
    bulletBlowUp = nil;
    bulletMove = nil;
    [super removeFromParent];
}

- (id)initWithPosition:(CGPoint)bodyPosition zPosition:(float)zPos
{
    if (self = [super initWithTexture:AtlasNum(@"chicken_rifle_bullet", 0)]) {
        self.zPosition = zPos-1;
        
        self.position = bodyPosition;
        self.boxRect = CGRectMake(-10, -10, 20, 20);
        self.attackRect = CGRectMake(self.position.x, self.position.y, 114, 94);
        self.damage = 10;
        self.name = @"chickenBullet";
        self.bullet = 4;
        bulletBlowUp = [SKAction animateWithTextures:Atlas(@"chicken_rifle_bullet")  timePerFrame:0.042];
        [self animationMove];
    }
    return self;
    
}

-(int)attack:(CGRect)pirateCollinRect
{
    return self.damage;
}

-(void)attackBody:(Body *)body
{
    if (CGRectIntersectsRect(self.boxRect, body.boxRect)) {
        if (self.targetIDNumber != body.idNumber) {                                   //碰撞结构要改动
            self.targetIDNumber = body.idNumber;
            if([body.myName isEqualToString:@"iceThin"] || [body.myName isEqualToString:@"iceThick"] || [body.myName isEqualToString:@"iceMist"] || [body.myName isEqualToString:@"iceThorn"]){
                [body changeHP:350 attacker:self];
            }else{
                [body changeHP:self.damage attacker:self];
            }
            
            [self animationBlowUp];
        }else{
            return;
        }
    }
}
- (void)animationMove
{
    if (bulletMove == nil) {
        SKAction *bulletMoveAnimat = [SKAction moveByX:0 y:-1400 duration:1.5];
        SKAction *dieBlock = [SKAction runBlock:^{
            [self removeFromParent];
        }];
        bulletMove =[SKAction sequence:@[bulletMoveAnimat,dieBlock]];
    }
    [self runAction:bulletMove withKey:@"move"];
}

- (void)animationBlowUp
{
    self.defBoxRect = CGRectMake(0, 0, -1, -1);
    if ([self actionForKey:@"move"]) {
        [self removeActionForKey:@"move"];
    }
    [self runAction:bulletBlowUp completion:^{
        [self removeFromParent];
    }];
}

-(void)dealloc
{
    bulletMove = nil;
    bulletBlowUp = nil;
}

@end
