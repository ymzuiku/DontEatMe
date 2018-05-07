//
//  CreateJelly.m
//  DontEatMe
//
//  Created by pringlesfox on 9/12/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "CreateJelly.h"

#import "Jelly.h"
#import "ViolentJelly.h"
#import "EnergyJelly.h"
#import "HighEnergyJelly.h"
#import "BananaJelly.h"
#import "LaserJelly.h"
#import "BoxerJelly.h"
#import "DoubleJelly.h"
#import "Mauler.h"
#import "ShieldJelly.h"
#import "CureJelly.h"
#import "SnailJelly.h"
#import "SlowJelly.h"
#import "BoomJelly.h"
#import "DizzyJelly.h"
#import "AOEBombJelly.h"
#import "IceThinJelly.h"
#import "IceThickJelly.h"
#import "IceThornJelly.h"
#import "IceMistJelly.h"
#import "StromJelly.h"

@implementation CreateJelly

+(void)addJellyWithName:(NSString *)name pos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    if ([name isEqualToString:@"banana"]) [self createBananaJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"energy"]) [self createEnergyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"iceThin"]) [self createIceThinJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"boom"]) [self createBoomJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"boxer"]) [self createDragonJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"dizzy"]) [self createDizzyJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"double"]) [self createDoubleJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"aoeBoom"]) [self createAOEJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"highEnergy"]) [self createHighEnergyJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"iceMist"]) [self createIceMistJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"iceThick"]) [self createIceThickJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"cure"]) [self createCureJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"iceThorn"]) [self createIceThornJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"laser"]) [self createLaserJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"shield"]) [self createShieldJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"slow"]) [self createSlowJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"strom"]) [self createStromJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"violent"]) [self createViolentJellyUsePos:pos gird:myGrid array:gArray games:games];
    else if ([name isEqualToString:@"snail"]) [self createSnailJellyUsePos:pos gird:myGrid array:gArray games:games];
}

//------------------------------------  每个果冻的实例方法  ------------------------------------
+(void)createBananaJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    BananaJelly *jelly = [[BananaJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createViolentJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    ViolentJelly *jelly = [[ViolentJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createDoubleJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    DoubleJelly *jelly = [[DoubleJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createDragonJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    BoxerJelly *jelly = [[BoxerJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createLaserJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    LaserJelly *jelly = [[LaserJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}


+(void)createEnergyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    EnergyJelly *jelly = [[EnergyJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createHighEnergyJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    HighEnergyJelly *jelly = [[HighEnergyJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createShieldJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    ShieldJelly *jelly = [[ShieldJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createCureJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    CureJelly *jelly = [[CureJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createSnailJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    SnailJelly *jelly = [[SnailJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createSlowJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    SlowJelly *jelly = [[SlowJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createBoomJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    BoomJelly *jelly = [[BoomJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];

}

+(void)createDizzyJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    DizzyJelly *jelly = [[DizzyJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createAOEJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    AOEBombJelly *jelly = [[AOEBombJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}


+(void)createIceThinJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    IceThinJelly *jelly = [[IceThinJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createIceThickJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    IceThickJelly *jelly = [[IceThickJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createIceThornJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    IceThornJelly *jelly = [[IceThornJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

+(void)createIceMistJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    IceMistJelly *jelly = [[IceMistJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];

}

+(void)createStromJellyUsePos:(CGPoint)pos gird:(Grid *)myGrid array:(NSMutableArray*)gArray games:(SKNode *)games;
{
    StromJelly *jelly = [[StromJelly alloc] init];
    jelly.position = pos;
    jelly.zPosition = 1999 - jelly.position.y+jelly.zPositionAdjust;
    jelly.gridNumber = myGrid.number;
    myGrid.hasNode = 1;
    myGrid.nodeInGrid = jelly;
    [games addChild:jelly];
    [jelly startup];
}

@end
