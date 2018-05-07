//
//  Chicken.m
//  DontEatMe
//
//  Created by pringlesfox on 9/2/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//



#import "Chicken.h"

@implementation Chicken
{
    SK_Label *levelLabel;
}

-(void)createInit
{
    [super createInit];
    self.hidden = YES;
    self.isStartup = 0;
    self.name = @"chicken";
    self.texString_hpBar = @"chicken_hp_mini";
    self.texString_normalRest = @"chicken_normal_move";
    self.texString_normalMove = @"chicken_normal_move";
    self.texString_normalAttack = @"chicken_normal_attack";
    StaticActions *sa = [StaticActions single];
    
    self.soundAction_normalAttack = sa.sound_chickenAttack0;
    self.soundAction_attackA = sa.sound_chickenAttack1;
    self.soundAction_attackB = sa.sound_chickenAttack2;
    self.soundAction_changeHPA = sa.sound_normalChangeHP0;
    self.soundAction_changeHPB = sa.sound_normalChangeHP1;
    self.haveNormalChicken_time = 0;
    
    self.theChangeColor = [UIColor orangeColor];
    self.defBoxRect = CGRectMake(-30, -50, 60, 45);
    self.defAttackRect = CGRectMake(-30, -50, 60, 45);
    self.attack = 100;
    self.skillCD = 5;
    [self sitDefaultHP:150];
    self.pace = -15+((arc4random() % 4) + 1);
}

-(void)startup
{
    [super startup];
	self.hidden = NO;
    self.isStartup = 1;
    [self useMove];
}

-(void)sitLevel:(int)level
{
    self.level = level;
    if (!levelLabel && self.level > 0) {
        levelLabel = [SK_Label createLabelWithFont:font_Helvetica_Bold line:12 size:20 color:rgb(0xb94f33, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        levelLabel.position = CGPointMake(hpPosX, hpPosY+21);
        [self addChild:levelLabel];
    }
    else if (self.level < 1) {
        [levelLabel removeFromParent];
    }
    
    if (self.level == 1) {
        [self setScale:1.25];
        self.defaultHP *= 3;
        self.attack *= 1.5;
        NSString *levelStr = [NSString stringWithFormat:@"%@ Lvl.1", self.myName];
        levelLabel.text = iString(levelStr);
        self.boxRect = CGRectMake(-30, -50-10, 60, 45);
    }
    else if (self.level == 2) {
        [self setScale:1.5];
        self.defaultHP *= 6;
        self.attack *= 3;
        NSString *levelStr = [NSString stringWithFormat:@"%@ Lvl.2", self.myName];
        levelLabel.text = iString(levelStr);
        self.boxRect = CGRectMake(-30, -50-15, 60, 45);
    }
    else if (self.level == 3) {
        [self setScale:1.75];
        self.defaultHP *= 9;
        self.attack *= 4.5;
        NSString *levelStr = [NSString stringWithFormat:@"%@ Lvl.3", self.myName];
        levelLabel.text = iString(levelStr);
        self.boxRect = CGRectMake(-30, -50-25, 60, 45);
    }
    else if (self.level == 4) {
        [self setScale:2];
        self.defaultHP *= 12;
        self.attack *= 6;
        NSString *levelStr = [NSString stringWithFormat:@"%@ Lvl.4", self.myName];
        levelLabel.text = iString(levelStr);
        self.boxRect = CGRectMake(-30, -50-40, 60, 45);
    }
}

-(void)chickenCoilDown
{
    int pixValue = (self.position.x < 320)?114:-114;
    SKAction *moveLeft = [SKAction moveToX:self.position.x+pixValue duration:5.0];
    moveLeft.timingMode = SKActionTimingEaseOut;
    [self runAction:moveLeft];
}


#pragma mark 基础动画
-(void)useRest
{
    if (![self changCanStatusRun:s_rest]) {
        return;
    }
    self.canNotChangeStatus = @[s_rest,s_attack,s_move];
    
    if (!self.restAction) {
        SKAction *rest = [SK_Actions animateWithTextures:Atlas(self.texString_move) timePerFrame:oneKey/self.speedRest resize:YES restore:NO];
        self.restAction = [SKAction repeatActionForever:rest];
    }
    [self runAction:self.restAction withKey:s_rest];
}

-(void)useDie
{
    self.isCanNotCoill = YES;
    if (![self changCanStatusRun:s_die]) {
        return;
    }
    self.canNotChangeStatus = @[s_move, s_rest, s_attack, s_die, s_dizzy, s_ice, s_slow,
                                s_sleep, s_skill, s_poison, s_snail];
    [self useDieBase];
}

-(void)useDieBase
{
    self.hidden = YES;
    self.defBoxRect = CGRectMake(0, 0, -1, -1);
    for (SKNode *node in self.children) {
        [node removeFromParent];
    }
    SKAction *beginDieBlock = [SKAction runBlock:^{
        self.hidden = NO;
    }];
    SKAction *die = [SKAction animateWithTextures:Atlas(@"chicken_buff_die2") timePerFrame:oneKey resize:YES restore:NO];
    SKAction *completion = [SKAction runBlock:^{
        [super useDie];
    }];
    SKAction *seq = [SKAction sequence:@[beginDieBlock,die, completion]];
    [self runAction:seq withKey:s_die];
    if (![self.dropObj isEqualToString:@"0"]) {
        ViewController *vc = [ViewController single];
        [vc.gameScene downObject:self.dropObj pos:self.position];
    }
}

-(void)useMove
{
    if (![self changCanStatusRun:s_move]) {
        return;
    }
    self.canNotChangeStatus = @[s_move];
    if (!self.moveAction) {
        SKAction *anime = [SKAction animateWithTextures:Atlas(self.texString_move) timePerFrame:oneKey*0.6/self.speedMove resize:YES restore:NO];
        SKAction *move = [SKAction moveByX:0 y:(float)self.pace*self.paceRate duration:(47/2-6)*oneKey*0.6/self.speedMove];
        SKAction *wait = [SKAction waitForDuration:oneKey*0.6*12/self.speedMove];
        SKAction *seq = [SKAction sequence:@[move, wait, move]];  //必须让anima的总时间和sequence的总时间相等
        SKAction *group = [SKAction group:@[anime, seq]];
        SKAction *miniWait = [SKAction waitForDuration:0.2];
        SKAction *reptGroup = [SKAction repeatActionForever:group];
        self.moveAction = [SKAction sequence:@[miniWait, reptGroup]];
    }
    [self runAction:self.moveAction withKey:s_move];
}

-(void)beColliedBy:(Body *)body
{
    if (![body.myName isEqualToString:@"stump"]) {
        return;
    }
    if (self.beCollied == true) {
        return;
    }
    self.beCollied = true;
    SKAction *moveByCollied = [SKAction moveByX:0 y: 60 duration:0.2];
    SKAction *seqEndBlock = [SKAction runBlock:^{
        [self resetZPostion];
        self.beCollied = false;
    }];
    SKAction *moveByColliedSeq =  [SKAction sequence:@[moveByCollied,seqEndBlock]];
    [self runAction:moveByColliedSeq withKey:@"moveByCollied"];
}

@end
