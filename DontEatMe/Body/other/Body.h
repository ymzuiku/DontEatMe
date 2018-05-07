//
//  Body.h
//  DontEatMe
//
//  Created by pringlesfox on 9/1/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "Body.h"
#import "HPBar.h"
#import "SkillBar.h"
#import "CDBar.h"
#import "BindingBuff.h"
#import "DizzyBuff.h"
#import "IceBuff.h"
#import "PoisonBuff.h"
#import "SleepBuff.h"
#import "SlowBuff.h"
#import "SnailBuff.h"
#import "ShieldBuff.h"
#import "CureBuff.h"
#import "BoomBuff.h"
#import "AmokBuff.h"
#import "NormalChickenBuff.h"
#import "StaveBuff.h"
#import "FloorBuff.h"
#import "YodaBuff.h"
#import "DizzyLongBuff.h"
#import "RecoveryBuff.h"
#import "FlashBuff.h"


//@class HPBar,CDBar,BindingBuff,DizzyBuff,IceBuff,PoisonBuff,SleepBuff,SlowBuff,SnailBuff,ShieldBuff,CureBuff,
//AmokBuff,NormalChickenBuff, BoomBuff, StaveBuff, FloorBuff, YodaBuff, DizzyLongBuff, RecoveryBuff;

#define s_rest      @"s_rest"
#define s_move      @"s_move"
#define s_loadingSkill      @"loadingSkill"
#define s_attack    @"s_attack"
#define s_skill     @"s_skill"
#define s_die       @"s_die"
#define s_buff      @"anima"
#define s_ice       @"s_ice"
#define s_dizzy     @"s_dizzy"
#define s_poison    @"s_poison"
#define s_slow      @"s_slow"
#define s_binding   @"s_binding"
#define s_sleep     @"s_sleep"
#define s_snail     @"s_snail"
#define s_changeColor @"s_changeColor"
#define s_firstMove    @"s_firstMove"
#define s_fastMove     @"s_fastMove"
#define s_defence   @"s_defence"

@interface Body : SKSpriteNode

//base value

@property   NSString* myName;
@property   CGRect boxRect;  //设定挨打碰撞体
@property   CGRect attackRect; //设定攻击碰撞体
@property   CGRect defBoxRect;
@property   CGRect defAttackRect;
@property   BOOL isCanNotCoill;
@property   HPBar *hpBar;
@property   SkillBar *skillBar;
@property   CDBar *cdBar;
@property   int defaultHP;
@property   int nowHP;
@property   int skillCD;
@property   int attack;
@property   int pace;
@property   float paceRate;
@property   int idNumber;
@property   int targetIDNumber;
@property   NSArray *canNotChangeStatus;
@property   NSString *nowStatus;
@property   BOOL isSkillCDing;
@property   BOOL isChangeColoring;
@property   NSString *dropObj;
@property   NSString *dropMoreObj;
@property   BOOL beCollied;

//base textures string

@property   NSString *texString_hpBar;
@property   NSString *texString_rest;
@property   NSString *texString_rest_B;
@property   NSString *texString_move;
@property   NSString *texString_move_B;
@property   NSString *texString_move_C;
@property   NSString *texString_attack;
@property   NSString *texString_attack_B;
@property   NSString *texString_attack_C;
@property   NSString *texString_attack_D;
@property   NSString *texString_attack_E;
@property   NSString *texString_skill;
@property   NSString *texstring_skill_B;
@property   NSString *texstring_skill_C;

@property   SKAction *soundAction_attackA;
@property   SKAction *soundAction_attackB;
@property   SKAction *soundAction_restA;
@property   SKAction *soundAction_restB;
@property   SKAction *soundAction_moveA;
@property   SKAction *soundAction_moveB;
@property   SKAction *soundAction_weaponDown;
@property   SKAction *soundAction_skillA;
@property   SKAction *soundAction_skillB;
@property   SKAction *soundAction_skillC;
@property   SKAction *soundAction_changeHPA;
@property   SKAction *soundAction_changeHPB;

//zPosition
@property float zPositionAdjust;         //02_27

// P_otherProperty
@property   Body *attackBody;
@property   UIColor *theChangeColor;

//base anime value
@property   float speedMove;
@property   float speedAttack;
@property   float speedRest;
@property   float speedSkill;
@property   float defSpeedMove;
@property   float defSpeedAttack;
@property   float defSpeedRest;
@property   float defSpeedSkill;

@property   SKAction *attackAction;
@property   SKAction *moveAction;
@property   SKAction *restAction;
@property   SKAction *skillAction;

//buff value
@property   BindingBuff *bindingBuff;
@property   DizzyBuff *dizzyBuff;
@property   IceBuff *iceBuff;
@property   PoisonBuff *poisonBuff;
@property   SleepBuff *sleepBuff;
@property   SlowBuff *slowBuff;
@property   SnailBuff *snailBuff;
@property   ShieldBuff *shieldBuff;
@property   CureBuff *cureBuff;
@property   BoomBuff *boomBuff;
@property   StaveBuff *staveBuff;
@property   AmokBuff *amokBuff;
@property   NormalChickenBuff *normalChickenBuff;
@property   YodaBuff *yodaBuff;
@property   DizzyLongBuff *dizzyLoingBuff;
@property   RecoveryBuff *recoveryBuff;
@property   FlashBuff *flashBuff;

@property   BOOL haveBuffSkill;
@property   float haveDizzy_time;
@property   float haveDizzy_random;
@property   float haveBinding_time;
@property   float haveBinding_attack;
@property   float haveIce_time;
@property   float haveIce_attackSpeed;
@property   float havePoison_time;
@property   float havePoison_attack;
@property   float haveSleep_time;
@property   float haveSlow_time;
@property   float haveSlow_moveSpeed;
@property   float haveSlow_attackSpeed;
@property   float haveSnail_time;
@property   float haveSnail_changeHPRate;
@property   float haveShield_time;
@property   float haveShield_hp;
@property   float haveShield_noDieTime;
@property   float haveCure_time;
@property   float haveCure_rate;
@property   float haveBoom_time;
@property   float haveBoom_hurt;
@property   float haveStave_time;
@property   float haveStave_hurt;
@property   float haveAmok_time;
@property   float haveAmok_speed;
@property   float haveNormalChicken_time;
@property   float haveFloor_time;
@property   float haveFloor_hurt;
@property   float haveYoda_time;
@property   float haveYoda_hurt;
@property   float haveDizzyLong_time;
@property   float haveRecovery_time;
@property   float haveRecovery_miniCD;
@property   float haveRecovery_hurt;
@property   float haveFlash_time;
@property   float haveFlash_hurt;

//clear static
+(void)clearStatic;

//sit func
-(void)sitDefaultHP:(int)hp;

//init func

-(void)createInit;
-(void)startup;

//seting status func

-(void)pause;
-(void)goon;
-(void)addHpBar:(CGPoint)pos name:(NSString *)name;
-(void)addSkillBar:(CGPoint)pos name:(NSString *)name skillTime:(float)skillTime;
-(void)addCDBar:(CGPoint)pos name:(NSString *)name beginName:(NSString *)beginName;
-(void)reloadRect;

//base anime func

-(void)useAttack;
-(void)useAttack:(NSArray *)notChangeArray;
-(void)useSkill;
-(void)useSkill:(NSArray *)notChangeArray;
-(void)useMove;
-(void)useMove:(NSArray *)notChangeArray;
-(void)useRest;
-(void)useRest:(NSArray *)notChangeArray;
-(void)reloadAllSpeed;
-(void)reloadStartSkill;

//remove hp func

-(void)useDie;
-(void)useDieBase;
-(BOOL)changCanStatusRun:(NSString *)s_beBuff;
-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker;
-(void)beSkillWithAttacker:(Body *)attacker;

//负面buff
-(void)beBuff_ice:(float)time attackSpeed:(float)attackSpeed;
-(void)beBuff_dizzy:(float)time random:(int)random;
-(void)beBuff_dizzyLong:(float)time;
-(void)beBuff_poison:(float)time attack:(float)value;
-(void)beBuff_slow:(float)time moveSpeed:(float)value attackSpeed:(float)valueB;
-(void)beBuff_binding:(float)time attack:(float)value;
-(void)beBuff_sleep:(float)time;
-(void)beBuff_snail:(float)time changeHPRate:(float)value;
-(void)beBuff_normalChicken;
-(void)beBuff_Boom:(float)time hurt:(float)theHurt;
-(void)beBuff_Flash:(float)time hurt:(float)theHurt;
-(void)beBuff_Yoda:(float)time hurt:(float )theHurt;
-(void)beBuff_Stave:(float)time hurt:(float)theHurt;
-(void)beBuff_Floor:(float)time hurt:(float)theHurt;

//增益buff
-(void)beBuff_Shield:(float)time shieldHP:(int)shieldHP noDieTime:(float)noDieTime;
-(void)beBuff_Cure:(float)time hp:(float)addHPRate;
-(void)beBuff_Amok:(float)time speed:(float)speed;
-(void)beBuff_recovery:(float)time miniCD:(float)miniCD hurt:(int)hurt;

//附加功能
-(void)beColliedBy:(Body *)body;
-(void)resetZPostion;

@end
