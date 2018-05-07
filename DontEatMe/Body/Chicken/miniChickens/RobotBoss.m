//
//  RobotBoss.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "RobotBoss.h"
#import "RobotBullet.h"
#import "MiniRobotBullet.h"

@implementation RobotBoss
{
    SKNode *jellyInGames;
    SKNode *bulletsInGames;
    int saySomeThing;
    Body *targetJelly;
    CGPoint targetPoint;
    CGPoint tempTarget;
    int leftOrRight;
    SKSpriteNode *leftArm;
    SKSpriteNode *rightArm;
    NSArray *middleAttackAnimaA;
    NSArray *middleAttackAnimaB;
    
    SKAction *moveTo_UD_Ani;
    SKAction *moveTo_LR_Ani;
    SKAction *tempAction1;
    SKAction *tempAction2;
    int randomNumb;
    int stopUseAttack;
    
    int middleAttackReady;
    int bigSkillReady;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"chicken_robot_move_down")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    self.myName = @"robot";
    
    self.texString_attack_B = @"chicken_robot_attack_leftArm";
    self.texString_attack_C = @"chicken_robot_attack_rightArm";
    self.texString_attack_D = @"chicken_robot_attack_leftBody";
    self.texString_attack_E = @"chicken_robot_attack_rightBody";
    self.texString_move = @"chicken_robot_move_down";
    self.texString_move_B = @"chicken_robot_move_left";
    self.texString_move_C = @"chicken_robot_move_right";
    self.texString_rest = @"chicken_robot_rest";
    self.texString_skill = @"chicken_robot_attack_middle";
    self.zPositionAdjust = 100;
//    self.defAttackRect = CGRectMake(-513,96*7,114*9,-96*14);
    [self sitDefaultHP:30000];
    self.attack = 8000;
}

-(void)startup
{
    [super startup];
    self.isStartup = 1;
    stopUseAttack = 1;
    if (leftArm == nil) {
        leftArm = [[SKSpriteNode alloc] initWithTexture:Atlas(self.texString_attack_B)[0]];
        leftArm.name = @"leftArm";
        [self addChild:leftArm];
        leftArm.position = CGPointMake(-115,-37);
    }
    if (rightArm == nil) {
        rightArm = [[SKSpriteNode alloc] initWithTexture:Atlas(self.texString_attack_C)[0]];
        rightArm.name = @"rightArm";
        [self addChild:rightArm];
        rightArm.position = CGPointMake(85,-43);
    }
    self.defAttackRect = CGRectMake(-513,96*3,114*9,-96*6);
    ViewController *vc = [ViewController single];
    jellyInGames = vc.gameScene.war.jellys;
    bulletsInGames = vc.gameScene.war.chickenBullets;
    self.canNotChangeStatus = @[s_rest,s_attack,@"miniRobotAttack",@"attackTarget"];
    self.hpBar.position = CGPointMake(hpPosX, hpPosY-13);
    [self middleAttackTimer];
    [self bigSkillTimer];
    [self checkStatesTimer];
    [self useMove];
}

-(void)reloadRect
{
    self.attackRect = CGRectMake(self.position.x+self.defAttackRect.origin.x, self.position.y+self.defAttackRect.origin.y, self.defAttackRect.size.width, self.defAttackRect.size.height);
    self.boxRect = CGRectMake(self.position.x+self.defBoxRect.origin.x, self.position.y+self.defBoxRect.origin.y, self.defBoxRect.size.width, self.defBoxRect.size.height);
    if (self.position.y < ih-150 && saySomeThing == 0) {
            [self useBigenRest];
            self.isSkillCDing = NO;
            saySomeThing = 1;
    }
}

-(void)useBigenRest
{
    if (![self changCanStatusRun:@"s_bigenRest"]) {
        return;
    }
    self.canNotChangeStatus = @[s_rest,s_move,s_attack,@"miniRobotAttack",@"attackTarget"];
    
    if (!self.restAction) {
        SKAction *rest = [SK_Actions animateWithTextures:Atlas(self.texString_rest) timePerFrame:oneKey/self.speedRest resize:YES restore:NO];
        self.restAction = [SKAction repeatActionForever:rest];
    }
    [self runAction:self.restAction withKey:@"s_bigenRest"];
    
    // test
    SKAction *wait = [SKAction waitForDuration:5];
    SKAction *stopBlock = [SKAction runBlock:^{
        [self useBigenRestOver];
    }];
    SKAction *stopSeq = [SKAction sequence:@[wait,stopBlock]];
    [self runAction:stopSeq];
}

-(void)useBigenRestOver
{
    stopUseAttack = 0;
    self.canNotChangeStatus = @[@"s_bigenRest"];
    [self removeActionForKey:@"s_bigenRest"];
    if (self.attackBody == nil) {
        [self useMove];
    }
}

-(void)useAttack
{
    if (stopUseAttack == 1) {
        return;
    }
    if (![self changCanStatusRun:@"attackTarget"]) {
        return;
    }
    self.canNotChangeStatus = @[@"attackTarget"];
    [self makeTarget];
    [self runAction:[self useMoveToBase] completion:^{
        [self attackTarget];
    }];
}
#pragma mark robotBrain

-(void)checkStatesTimer
{
    SKAction *wait = [SKAction waitForDuration:5];
    SKAction *checkstates = [SKAction runBlock:^{
    }];
    SKAction *seq = [SKAction sequence:@[wait,checkstates]];
    [self runAction:[SKAction repeatActionForever:seq]];
}

-(void)middleAttackTimer
{
    SKAction *wait_MiddleAttack = [SKAction waitForDuration:20];
    SKAction *doBlock_MiddleAttack = [SKAction runBlock:^{
//        stopUseAttack = 1;
        middleAttackReady = 1;
    }];
    SKAction *seq_MiddleAttackTimer = [SKAction sequence:@[wait_MiddleAttack,doBlock_MiddleAttack]];
    [self runAction:[SKAction repeatActionForever:seq_MiddleAttackTimer] withKey:@"middleAttackTimer"];  //
}

-(void)bigSkillTimer
{
    SKAction *wait_BigSkill = [SKAction waitForDuration:60];
    SKAction *doBlock_bigSkill = [SKAction runBlock:^{
//        stopUseAttack = 1;
        bigSkillReady = 1;
    }];
    SKAction *seq_BigSkillTimer = [SKAction sequence:@[wait_BigSkill,doBlock_bigSkill]];
    [self runAction:[SKAction repeatActionForever:seq_BigSkillTimer] withKey:@"bigSkillTimer"];
    
}



#pragma mark makeTarget { }

-(void)makeTarget
{
    if ([self.attackBody.myName isEqualToString:@"xiaowei"] && jellyInGames.children.count > 1) {
        targetPoint = CGPointMake(350, self.position.y+200);
        return;
    }else if ([self.attackBody.myName isEqualToString:@"xiaowei"] && jellyInGames.children.count == 1) {
        targetPoint = CGPointMake(350, 700);
        [self useMoveToBase];
        return;
    }
    targetJelly = self.attackBody;
    if (targetJelly.position.x > self.position.x) {
        tempTarget = targetJelly.position;
        targetPoint = CGPointMake(targetJelly.position.x-114, targetJelly.position.y+200);
        leftOrRight = 1;
    }else if (targetJelly.position.x < self.position.x) {
        tempTarget = targetJelly.position;
        targetPoint = CGPointMake(targetJelly.position.x+114, targetJelly.position.y+200);
        leftOrRight = 2;
    }
}

#pragma mark useMoveTo { }

-(SKAction *)useMoveTo
{
    [self makeTarget];
     return [self useMoveToBase];
}

-(SKAction *)useMoveToBase
{
    tempAction1 = [self moveLiftOrRight];
    tempAction2 = [self moveUpOrDown];
    SKAction *LRBlock = [SKAction runBlock:^{
        [self runAction:tempAction1 withKey:@"killMoveLR"];
    }];
    SKAction *UDBlock = [SKAction runBlock:^{
        [self runAction:tempAction2 withKey:@"killMoveUD"];
    }];
    
    SKAction *wait1 = [SKAction waitForDuration:tempAction1.duration];
    SKAction *wait2 = [SKAction waitForDuration:tempAction2.duration];
    SKAction *seq = [SKAction sequence:@[LRBlock,wait1,UDBlock,wait2]];
    return seq;
}

-(SKAction *)moveLiftOrRight
{
    float moveToX;
    moveToX = targetPoint.x - self.position.x+57;
    
    if (moveToX > 0) {
        moveTo_LR_Ani = [SKAction animateWithTextures:Atlas(self.texString_move_C) timePerFrame:oneKey/self.speedMove resize:YES restore:NO];
        leftOrRight = 2;
    }else if (moveToX < 0) {
        moveTo_LR_Ani = [SKAction animateWithTextures:Atlas(self.texString_move_B) timePerFrame:oneKey/self.speedMove resize:YES restore:NO];
        leftOrRight = 1;
    }
    
    SKAction *moveTo_LR_Act = [SKAction moveToX:targetPoint.x duration:fabsf(moveToX)/174*oneKey*26];
    SKAction *moveTo_LR_repAni = [SKAction repeatActionForever:moveTo_LR_Ani];
    
    SKAction *wait = [SKAction waitForDuration:fabsf(moveToX)/174*oneKey*26];
    SKAction *killBlockMove_LR_repAni = [SKAction runBlock:^{
        [self removeActionForKey:@"killMoveLR"];
    }];
    SKAction *killSeq = [SKAction sequence:@[wait,killBlockMove_LR_repAni]];
    SKAction *moveLRGroup = [SKAction group:@[moveTo_LR_repAni,moveTo_LR_Act,killSeq]];
    return moveLRGroup;
}

-(SKAction *)moveUpOrDown
{
    float moveToY;
    moveToY = targetPoint.y - self.position.y;
    
    if (moveToY > 0) {
        moveTo_UD_Ani = [SKAction animateWithTextures:Atlas(self.texString_move) timePerFrame:oneKey/self.speedMove resize:YES restore:NO];
    }else if (moveToY < 0) {
        moveTo_UD_Ani = [[SKAction animateWithTextures:Atlas(self.texString_move) timePerFrame:oneKey/self.speedMove resize:YES restore:NO] reversedAction];
    }
    SKAction *moveTo_UD_Act = [SKAction moveToY:targetPoint.y duration:fabsf(moveToY)/192*oneKey*49];
    SKAction *moveTo_UD_repAni = [SKAction repeatActionForever:moveTo_UD_Ani];
    SKAction *wait = [SKAction waitForDuration:fabsf(moveToY)/192*oneKey*49];
    SKAction *killBlockMove_UD_repAni = [SKAction runBlock:^{
        [self removeActionForKey:@"killMoveUD"];
    }];
    SKAction *killSeq = [SKAction sequence:@[wait,killBlockMove_UD_repAni]];
    SKAction *moveUDGroup = [SKAction group:@[moveTo_UD_repAni,moveTo_UD_Act,killSeq]];
    return moveUDGroup;
}


#pragma mark useMoveBack { }

-(void)useMoveBack
{
    
}

#pragma mark useAttack { }

//-(void)attackTarget
//{
//    SKAction *attackTargetBlock = [SKAction runBlock:^{
//        if (tempTarget.x > self.position.x) {
//            [self attackUseRightArm];
//        }else if (tempTarget.x < self.position.x) {
//            [self attackUseLeftArm];
//        }
//    }];
//    [self runAction:attackTargetBlock withKey:@"attackTarget"];
//}

-(void)attackTarget
{
    if (tempTarget.x > self.position.x) {
        [self attackUseRightArm];
    }else if (tempTarget.x < self.position.x) {
        [self attackUseLeftArm];
    }
}

-(void)attackUseLeftArm
{
    CGFloat originZposition;
    originZposition = leftArm.zPosition;
    leftArm.zPosition = targetJelly.zPosition+1; ;
    SKAction *leftArmAttack = [SKAction animateWithTextures:Atlas(self.texString_attack_B) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
    SKAction *leftBodyAttack = [SKAction animateWithTextures:Atlas(self.texString_attack_D) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
    SKAction *endBlock = [SKAction runBlock:^{
        leftArm.zPosition = originZposition; ;
        self.canNotChangeStatus = @[];
        if (bigSkillReady == 1) {
            [self useBigSkill];
        }else if (middleAttackReady == 1) {
            [self useMiddleAttack];
        }else{
            [self useMove];
        }
    }];
    SKAction *attackSeq = [SKAction sequence:@[leftBodyAttack,endBlock]];
    [self runAction:attackSeq];
    SKAction *leftArmAttackChangHP = [SKAction runBlock:^{
        if ([targetJelly.myName isEqualToString:@"xiaowei"]) {
            [self makeTarget];
        }else{
            [targetJelly changeHP:targetJelly.defaultHP*0.5 attacker:self];
        }
    }];
    SKAction *wait_ChangeHp = [SKAction waitForDuration:oneKey*19];
    SKAction *changeHpSeq = [SKAction sequence:@[wait_ChangeHp,leftArmAttackChangHP]];
    [self runAction:changeHpSeq];
    [leftArm runAction:leftArmAttack withKey:@"leftArm"];
}

-(void)attackUseRightArm
{
    CGFloat originZposition;
    originZposition = rightArm.zPosition;
    rightArm.zPosition = targetJelly.zPosition+1;
    SKAction *rightArmAttack = [SKAction animateWithTextures:Atlas(self.texString_attack_C) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
    SKAction *rightBodyAttack = [SKAction animateWithTextures:Atlas(self.texString_attack_E) timePerFrame:oneKey/self.speedAttack resize:YES restore:NO];
    SKAction *endBlock = [SKAction runBlock:^{
        rightArm.zPosition = originZposition;
        self.canNotChangeStatus = @[];
        if (bigSkillReady == 1) {
            [self useBigSkill];
        }else if (middleAttackReady == 1) {
            [self useMiddleAttack];
        }else{
            [self useMove];
        }
    }];
    SKAction *attackSeq = [SKAction sequence:@[rightBodyAttack,endBlock]];
    [self runAction:attackSeq];
    SKAction *rightArmAttackChangHP = [SKAction runBlock:^{
        if ([targetJelly.myName isEqualToString:@"xiaowei"]) {
            [self makeTarget];
        }else{
            [targetJelly changeHP:targetJelly.defaultHP*0.5 attacker:self];
        }
    }];
    SKAction *wait_ChangeHp = [SKAction waitForDuration:oneKey*19];
    SKAction *changeHpSeq = [SKAction sequence:@[wait_ChangeHp,rightArmAttackChangHP]];
    [self runAction:changeHpSeq];
    [rightArm runAction:rightArmAttack withKey:@"rightArm"];
}

#pragma mark useNormalState { }

//-(void)useNormalState:(NSString *)previousStates
//{
//    if([previousStates isEqualToString:@"attack"]) {
//        targetPoint = CGPointMake(320,900);
//        SKAction *moveBack = [self useMoveTo];
//        SKAction *moveBackEndBlock = [self useMoveTo];
//        SKAction *moveBackSeq = [SKAction sequence:@[moveBack,moveBackEndBlock]];
//        [self runAction:moveBackSeq completion:^{
////            [self useMove];
//        }];
//    }
//}

#pragma mark middleAttack { }

-(void)useMiddleAttack
{
    stopUseAttack = 1;
    [self middleAttack];
}

-(void)attackByBullet
{
    RobotBullet *robotBullet = [[RobotBullet alloc] initWithPosition:CGPointMake(self.position.x, self.position.y-60) zPosition:self.zPosition+1];
    [bulletsInGames addChild:robotBullet];
    [robotBullet animationMove];
}

-(void)middleAttack
{
    if (middleAttackAnimaA == nil) {
        middleAttackAnimaA = [Atlas(self.texString_skill) subarrayWithRange:NSMakeRange(0,14)];
    }
    if (middleAttackAnimaB == nil) {
        middleAttackAnimaB = [Atlas(self.texString_skill) subarrayWithRange:NSMakeRange(14,27)];
    }
    SKAction *anima_middleAttackA = [SKAction animateWithTextures:middleAttackAnimaA timePerFrame:oneKey*2 resize:YES restore:NO];
    SKAction *anima_middleAttackB = [SKAction animateWithTextures:middleAttackAnimaB timePerFrame:oneKey*2 resize:YES restore:NO];
    SKAction *actionBlock_middleAttack = [SKAction runBlock:^{
        [self attackByBullet];
    }];
    SKAction *wait_middleAttack = [SKAction waitForDuration:1];
    SKAction *endBlock_middleAttack = [SKAction runBlock:^{
        middleAttackReady = 0;
        stopUseAttack = 0;
        [self useMove];
    }];
    SKAction *seq = [SKAction sequence:@[anima_middleAttackA,actionBlock_middleAttack,anima_middleAttackB,wait_middleAttack,endBlock_middleAttack]];
    [self runAction:seq];
}

#pragma mark bigSkill { }

-(void)useBigSkill
{
    stopUseAttack = 1;
    [self miniRobotAttackPose];
    [self miniRobotMaker:[[MiniRobotBullet alloc] initWithPosition:self.position zPosition:self.zPosition+1]];
}

-(void)miniRobotMaker:(MiniRobotBullet *)miniRobotBullet
{
    SKAction *wait1 = [SKAction waitForDuration:0.1];
    SKAction *doBlock = [SKAction runBlock:^{
        if (randomNumb < 13) {
            randomNumb += 1;
        }else{
            randomNumb = 1;
        }
        MiniRobotBullet *robotBullet = [[MiniRobotBullet alloc] initWithPosition:CGPointMake(80*randomNumb+arc4random()%100 , 1134+arc4random()%50) zPosition:self.zPosition-1000];
        [bulletsInGames addChild:robotBullet];
        [robotBullet animationMove];
    }];
    SKAction *timerSeq = [SKAction sequence:@[wait1,doBlock]];
    SKAction *repTimerSeq = [SKAction repeatAction:timerSeq count:1000];
    [self runAction:repTimerSeq withKey:@"miniRobotAttack"];
    
}

-(void)miniRobotAttackPose
{
    int poseTimer = 3;
    int poseRepCount = 25;
    
    SKAction *attackPose1 = [[SKAction animateWithTextures:[Atlas(self.texString_attack_B) subarrayWithRange:NSMakeRange(46,8)] timePerFrame:oneKey*2 resize:YES restore:NO] reversedAction];
    SKAction *attackPose2 = [[SKAction animateWithTextures:[Atlas(self.texString_attack_B) subarrayWithRange:NSMakeRange(43,3)] timePerFrame:oneKey*poseTimer resize:YES restore:NO] reversedAction];
    SKAction *repAttackPoseL = [SKAction repeatAction:attackPose2 count:poseRepCount];
    SKAction *attackPose5 = [SKAction animateWithTextures:[Atlas(self.texString_attack_B) subarrayWithRange:NSMakeRange(47,8)] timePerFrame:oneKey*2 resize:YES restore:NO];
    SKAction *attackPoseSeqL = [SKAction sequence:@[attackPose1,repAttackPoseL,attackPose5]];
    [leftArm runAction:attackPoseSeqL withKey:@"attackPoseL"];
    
    SKAction *attackPose3 = [[SKAction animateWithTextures:[Atlas(self.texString_attack_C) subarrayWithRange:NSMakeRange(46,8)] timePerFrame:oneKey*2 resize:YES restore:NO] reversedAction];
    SKAction *attackPose4 = [[SKAction animateWithTextures:[Atlas(self.texString_attack_C) subarrayWithRange:NSMakeRange(43,3)] timePerFrame:oneKey*poseTimer resize:YES restore:NO] reversedAction];
    SKAction *repAttackPoseR = [SKAction repeatAction:attackPose4 count:poseRepCount];
    SKAction *attackPose6 = [SKAction animateWithTextures:[Atlas(self.texString_attack_C) subarrayWithRange:NSMakeRange(47,8)] timePerFrame:oneKey*2 resize:YES restore:NO];
    SKAction *attackPoseSeqR = [SKAction sequence:@[attackPose3,repAttackPoseR,attackPose6]];
    [rightArm runAction:attackPoseSeqR withKey:@"attackPoseR"];
    
    SKAction *bodyPose1 = [SKAction animateWithTextures:[Atlas(self.texString_attack_D) subarrayWithRange:NSMakeRange(0,27)] timePerFrame:oneKey resize:YES restore:NO];
    SKAction *bodyPoseWait = [SKAction waitForDuration:oneKey*poseTimer*3*poseRepCount];
    SKAction *bodyPose2 = [SKAction animateWithTextures:[Atlas(self.texString_attack_D) subarrayWithRange:NSMakeRange(28,26)] timePerFrame:oneKey resize:YES restore:NO];
    SKAction *bodyPoseRest = [SKAction animateWithTextures:Atlas(self.texString_rest) timePerFrame:oneKey resize:YES restore:NO];
    SKAction *repBodyPoseRest = [SKAction repeatAction:bodyPoseRest count:10];
    SKAction *stopMiniRobotAttackBlock = [SKAction runBlock:^{
        [self removeActionForKey:@"miniRobotAttack"];
    }];
    SKAction *miniRobotAttackBlock = [SKAction runBlock:^{
        bigSkillReady = 0;
        middleAttackReady = 0;
        stopUseAttack = 0;
        [self useMove];
    }];
    SKAction *bodyPoseSeq = [SKAction sequence:@[bodyPose1,bodyPoseWait,bodyPose2,stopMiniRobotAttackBlock,repBodyPoseRest,miniRobotAttackBlock]];
    [self runAction:bodyPoseSeq];
}

@end
