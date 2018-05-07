//
//  SnailBuff.m
//  DontEatMe
//
//  Created by ym on 15/1/20.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "SnailBuff.h"

@implementation SnailBuff
{
    Body *body;
    NSString *defString_move;
    NSString *defString_attack;
    NSString *defString_rest;
    int defAttack;
    BOOL tempIsSkillCDing;
    CGRect bodyDefAttackRect;
    
    SKAction *checkSnailSeq;
}
-(id)initWithBody:(Body *)aBody
{
    if (self = [super initWithBody:aBody]) {
        body = aBody;
        defString_attack = body.texString_attack;
        defString_move = body.texString_move;
        defString_rest = body.texString_rest;
        defAttack = body.attack;
    }
    return self;
}

-(void)beginBuff
{
    [super beginBuff];
    self.hidden = NO;
    if (![self actionForKey:@"anime"]) {
        [body removeActionForKey:body.nowStatus];
        SKAction *animeEmpty = [SKAction animateWithTextures:Atlas(@"chicken_snail_empty") timePerFrame:oneKey resize:YES restore:NO];
        [body runAction:animeEmpty withKey:@"empty"];

        SKAction *anime = [SKAction animateWithTextures:Atlas(@"chicken_snail_create") timePerFrame:oneKey resize:YES restore:YES];
        [self runAction:anime withKey:@"anime"];
        
        SKAction *wait = [SKAction waitForDuration:anime.duration/2];
        SKAction *block = [SKAction runBlock:^{
            [body removeActionForKey:@"empty"];
            body.texString_move = @"chicken_snail_move";
            body.texString_attack = @"chicken_snail_attack";
            body.texString_rest = @"chicken_snail_rest";
            body.attack *= 0.2;
            tempIsSkillCDing = body.isSkillCDing;
            body.isSkillCDing = YES;
            bodyDefAttackRect = body.defAttackRect;
            body.defAttackRect = CGRectMake(-30, -50, 60, 45);
            body.moveAction = nil;
            body.attackAction = nil;
            body.restAction = nil;
            
            self.moveSpeed = 0.5;
            if (![body actionForKey:s_die]) {
                [body reloadAllSpeed];
                body.canNotChangeStatus = @[];
                if (body.dizzyLoingBuff.isBuffing == YES || body.dizzyBuff.isBuffing == YES) {
                    [body useRest];
                }else{
                    [body useMove];
                }
            }else{
                return;
            }
        }];
        SKAction *seq = [SKAction sequence:@[wait, block]];
        [self runAction:seq withKey:@"anime"];
        self.zPosition = 1;
    }
    
    //持续时间
    [self removeActionForKey:@"wait"];
    SKAction *wait = [SKAction waitForDuration:self.time];
    SKAction *block = [SKAction runBlock:^{
        [self clearBuff];
    }];
    SKAction *seq = [SKAction sequence:@[wait, block]];
    [self runAction:seq withKey:@"wait"];
}

-(void)clearBuff
{
    [super clearBuff];
    [self removeActionForKey:@"anime"];
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"chicken_snail_cancel") timePerFrame:oneKey resize:YES restore:NO];
    [self runAction:anime completion:^{
        self.hidden = YES;
    }];
    
    body.texString_move = defString_move;
    body.texString_attack = defString_attack;
    body.texString_rest = defString_rest;
    body.attack = defAttack;
    body.isSkillCDing = tempIsSkillCDing;
    body.moveAction = nil;
    body.attackAction = nil;
    body.restAction = nil;
    body.defAttackRect = bodyDefAttackRect;

    self.moveSpeed = 0.5;
    [body reloadAllSpeed];
    body.canNotChangeStatus = @[];
    if (body.dizzyLoingBuff.isBuffing == YES) {
        [body useRest];
    }else{
        [body useMove];
    }
}

//-(void)checkSnailTimer
//{
//    if (!checkSnailSeq) {
//        SKAction *wait = [SKAction waitForDuration:1.0];
//        SKAction *doBlock = [SKAction runBlock:^{
//            if (body.dizzyLoingBuff.isBuffing == NO) {
//                [self clearBuff];
//            }
//        }];
//        checkSnailSeq = [SKAction sequence:@[wait,doBlock]];
//    }
//    [self runAction:[SKAction repeatActionForever:checkSnailSeq] withKey:@"checkSnail"];
//}

-(void)removeFromParent
{
    [self clearBuff];
    body = nil;
    [super removeFromParent];
}

@end
