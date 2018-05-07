//
//  Bullet.m
//  AtlasTesing
//
//  Created by Tie Muer on 12/9/13.
//  Copyright (c) 2013 ym. All rights reserved.
//

#import "Bullet.h"

static SKAction *bulletMove;
static SKAction *bulletBlowUp;

@implementation Bullet
{
    NSArray *bulletTextureArray;
    StaticActions *sa;
    int nowThrough;
    int theEmptyIdNumber;
}

-(void)removeFromParent
{
    [self removeActionForKey:@"soundChangeHP"];
    [super removeFromParent];
    
}

- (id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_violent_bullet")[0]]) {
        self.bullet = bullet_banana;
        self.isThrough = 0;
        self.name = @"jellyBullet";
        sa = [StaticActions single];
       [self setScale:0.6];
        
        self.speed = 1;
    }
    return self;
}

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        self.bullet = bullet_banana;
        self.isThrough = 0;
        self.name = @"jellyBullet";
        sa = [StaticActions single];
        [self setScale:0.6];
        
        self.speed = 1;
    }
    return self;
}

-(void)attackBody:(Body *)body
{
    if (self.isThrough == -1) {
        return;
    }
    if (CGRectIntersectsRect(self.boxRect, body.boxRect)) {
        if (self.isThrough == 0 && theEmptyIdNumber != body.idNumber) {
            theEmptyIdNumber = body.idNumber;
            [body changeHP:self.attack attacker:self];
            [self animationBlowUp:body.myName];
            self.isThrough = -1;
            
            if (self.dropObj) {
                body.dropMoreObj = self.dropObj;
            }
        }
        else if (self.isThrough > 0 && theEmptyIdNumber != body.idNumber) {
            theEmptyIdNumber = body.idNumber;
            [body changeHP:self.attack attacker:self];
            self.isThrough = 0;
            self.attack *= 0.4;
            [self setScale:0.4];
        }
    }
}

- (void)animationMove
{
    if (bulletMove == nil) {
        SKAction *actionBulletMove = [SKAction moveByX:0 y:1136 duration:1.65]; //1.65
        SKAction *dieBlock = [SKAction runBlock:^{
            [self removeFromParent];
        }];
        bulletMove = [SKAction sequence:@[actionBulletMove,dieBlock]];
    }
    [self runAction:bulletMove withKey:@"move"];
}

-(void)animationBlowUp:(Body *)body
{
    self.defBoxRect = CGRectMake(0, 0, -1, -1);
    if ([self actionForKey:@"blowUp"]) {
        return;
    }
    if ([self actionForKey:@"move"]) {
        [self removeActionForKey:@"move"];
    }
    if (bulletBlowUp == nil) {
        SKAction *anime = [SKAction animateWithTextures:Atlas(@"jelly_violent_bullet")  timePerFrame:oneKey];
        SKAction *wait = [SKAction waitForDuration:1.5];
        bulletBlowUp = [SKAction sequence:@[anime, wait]];
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

#pragma mark -Other

@end
