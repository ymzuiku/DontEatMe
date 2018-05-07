//
//  FurChicken.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "FurChicken.h"
#import "FireBall.h"

@implementation FurChicken
{
    SKNode *games;
    int fireballLine0;
    int fireballLine1;
    int fireballLine2;
    int fireballLine3;
    int fireballLine4;
    int maxFireBallLine;
    
    Body *tempAttackBody;
}

-(id)init

{
    if (self = [super initWithTexture:Atlas(@"chicken_fur_move")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.attack = 100;
    self.myName = @"fur";
    self.texString_attack = @"chicken_fur_attackA";
    self.texString_move = @"chicken_fur_move";
    self.texString_rest = @"chicken_fur_rest";
    self.texString_skill = @"chicken_fur_attackB";
    
}

-(void)startup
{
    self.isStartup = 1;
    [self sitDefaultHP:3000];
    [self fireBallTimer];
    [self useMove];
}

-(void)useMove
{
    self.defAttackRect = CGRectMake(-513,0,114*9,-96);
    if (![self.nowStatus isEqualToString:s_move]) {
         [super useMove];
    }
}

-(void)useAttack
{
    if (tempAttackBody.position.x == self.position.x && tempAttackBody.nowHP > 0) {
        self.speedAttack = 1.5;
        [self useAttack1];
    }else{
        [self useMoveTo];
    }
}

-(void)useAttack1
{
        if (self.isSkillCDing == NO) {
            [self useSkill];
            return;
        }
        if ([self changCanStatusRun:s_attack]) {
            NSLog(@"is here3");
            return;
        }
        self.canNotChangeStatus = @[s_attack,s_skill];
    SKAction *animate = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey*1.2/self.speedAttack resize:YES restore:NO];
    SKAction *runBlock1 = [SKAction runBlock:^{
                    NSLog(@"is here4");
                    [tempAttackBody changeHP:self.attack attacker:self];
                }];
    SKAction *group = [SKAction group:@[runBlock1, animate]];
    SKAction *complet = [SKAction runBlock:^{
        [super useMove];
    }];

    SKAction *attackAction = [SKAction sequence:@[group,complet]];
    [self runAction:attackAction withKey:s_attack];
}


-(void)moveAway
{
    self.position = CGPointMake(self.position.x, self.position.y+400);
}

-(void)useMoveTo
{
    if (![self changCanStatusRun:@"s_moveTo"]) {
        return;
    }
    self.canNotChangeStatus = @[@"s_moveTo", s_attack];
    if (self.position.x == tempAttackBody.position.x) {
        return;
    }
    if (![tempAttackBody isEqual:self.attackBody]) {
        tempAttackBody = self.attackBody;
    }
    SKAction *moveTo_animation = [SKAction animateWithTextures:Atlas(self.texString_move) timePerFrame:oneKey*0.7*self.speedMove resize:YES restore:NO];
    SKAction *moveTo_repAnimation = [SKAction repeatActionForever:moveTo_animation];
    
    SKAction *moveTo_action = [SKAction moveTo:CGPointMake(tempAttackBody.position.x, tempAttackBody.position.y+50) duration:fabs(tempAttackBody.position.x - self.position.x)/114];
    SKAction *moveTo_actionEndBlock = [SKAction runBlock:^{
//        [self useMove];
        [self useAttack];
    }];
    SKAction *moveTo_seq = [SKAction sequence:@[moveTo_action,moveTo_actionEndBlock]];
    SKAction *moveTo_group = [SKAction group:@[moveTo_repAnimation,moveTo_seq]];
    [self runAction:moveTo_group withKey:@"s_moveTo"];
}

-(void)useAttackWtihFireball
{
    if (![self changCanStatusRun:@"s_fireBall"]) {
        return;
    }
    self.canNotChangeStatus = @[@"s_fireBall",s_attack,@"s_moveTo"];
    if ([self actionForKey:self.nowStatus]) {
        [self removeActionForKey:self.nowStatus];
    }
    SKAction *furAttack_fireBall1 = [SKAction animateWithTextures:[Atlas(self.texString_skill) subarrayWithRange:NSMakeRange(0,17)] timePerFrame:oneKey resize:YES restore:NO];
    SKAction *furAttack_fireBall2 = [SKAction animateWithTextures:[Atlas(self.texString_skill) subarrayWithRange:NSMakeRange(18,14)] timePerFrame:oneKey resize:YES restore:NO];
    SKAction *furAttack_fireBall3 = [SKAction animateWithTextures:[Atlas(self.texString_skill) subarrayWithRange:NSMakeRange(32,47)] timePerFrame:oneKey resize:YES restore:NO];
    SKAction *furAttack_fireBall2_rep = [SKAction repeatAction:furAttack_fireBall2 count:5];
    SKAction *furAttack_endBlock = [SKAction runBlock:^{
        if (!games) {
            ViewController *vc = [ViewController single];
            games = vc.gameScene.war.chickenBullets;
        }
        FireBall *fireball = [[FireBall alloc] initWithPosition:self.position zPosition:1999];
        fireball.damage = self.attack+7;
        [games addChild:fireball];
    }];
    SKAction *furAttack_endBlockB = [SKAction runBlock:^{
        self.canNotChangeStatus = @[];
        [self clearLineNumber];
        [self useMove];
     }];
    SKAction *furAttackB_move = [SKAction moveTo:CGPointMake(maxFireBallLine*114+114, self.position.y+94*1) duration:0.5];
    SKAction *furAttack_seq = [SKAction sequence:@[furAttackB_move,furAttack_fireBall1,furAttack_endBlock,furAttack_fireBall2_rep,furAttack_fireBall3,furAttack_endBlockB]];
    [self runAction:furAttack_seq withKey:@"s_fireBall"];
}

-(void)fireBallTimer
{
    SKAction *fireBall_wait = [SKAction waitForDuration:50];
    SKAction *fBlock = [SKAction runBlock:^{
        [self countAramy];
    }];
    SKAction *fireball_endBlock = [SKAction runBlock:^{
        
        [self useAttackWtihFireball];
    }];
    SKAction *wait1 = [SKAction waitForDuration:1];
    SKAction *fireBall_seq = [SKAction sequence:@[fireBall_wait,fBlock,wait1,fireball_endBlock]];
    [self runAction:[SKAction repeatActionForever:fireBall_seq] withKey:@"fireBallTimer"];
}

-(void)countAramy
{
    ViewController *vc = [ViewController single];
    for (Jelly *temp in vc.gameScene.war.jellys.children) {
        if (temp.lineOfJellyOn == 0) {
            fireballLine0 += 1;
        }else if (temp.lineOfJellyOn == 1) {
            fireballLine1 += 1;
        }else if (temp.lineOfJellyOn == 2) {
            fireballLine2 += 1;
        }else if (temp.lineOfJellyOn == 3) {
            fireballLine3 += 1;
        }else if (temp.lineOfJellyOn == 4) {
            fireballLine4 += 1;
        }
    }
    if (fireballLine0 < fireballLine1) {
        maxFireBallLine = 1;
    }else if (fireballLine1 < fireballLine2) {
        maxFireBallLine = 2;
    }else if (fireballLine2 < fireballLine3) {
        maxFireBallLine = 3;
    }else if (fireballLine3 < fireballLine4) {
        maxFireBallLine = 4;
    }else{
        maxFireBallLine = 0;
    }
}

-(void)clearLineNumber
{
    fireballLine0 = 0;
    fireballLine1 = 0;
    fireballLine2 = 0;
    fireballLine3 = 0;
    fireballLine4 = 0;
}

@end
