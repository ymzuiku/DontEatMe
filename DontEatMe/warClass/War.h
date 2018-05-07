//
//  War.h
//  DontEatMe
//
//  Created by ym on 14/7/6.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//




#import <Foundation/Foundation.h>
@class StudyTip, Prop, Stump, Rock, Floor, Button, ButtonBomb, Bounce, BlueBird, YellowBird, Cloud, Meteorite, SpoonChicken, OnionChicken, FishChicken, IronBasinChicken, WoodenBasinChicken, FatChicken, BombChicken, BeerChicken, FireChicken,
    SawChicken, WeedChicken, YodaChicken, RifleChicken, MacheteChicken, MaidChicken, RobotBoss, FurChicken, RifleBullet, RobotBullet, FireBall,
GuageBar, PickNode, MoreChickensHummer;

#import "Grid.h"
#import "ChickenInClass.h"
#import "Jelly.h"
#import "Chicken.h"
#import "GuageBar.h"


#import <SpriteKit/SpriteKit.h>

enum classType{
    basic,
    bigChicken,
    miniChicken,
    infinityMana,
};

enum manaType {
    manaBasic,
    manaInfinity,
};


@interface War : SKSpriteNode

-(void)createInit;
-(void)reviveGame;
-(void)createTheGame;
-(void)startChicken;
-(void)beginTheGame;
-(void)createDate;
-(void)createStump;
-(void)goonGame;
-(void)pauseGame;
-(void)whistleOneBird;
-(void)rootUpdate;
-(void)moreChickensHammer;
-(void)winCallBack;
-(void)collied;
-(Chicken *)createOneChickenWithName:(NSString *)name;

@property (nonatomic) NSString *c_name;
@property (nonatomic) NSString *c_scene;
@property (nonatomic) NSString *c_particle;
@property (nonatomic) NSString *c_music;
@property (nonatomic) NSArray *c_chickens;
@property (nonatomic) int c_mana;
@property (nonatomic) NSString *c_prize;
@property (nonatomic) int birdFlyLoopTime;
@property (nonatomic) int isGameIn;

@property (nonatomic) SKNode *downObjs;
@property (nonatomic) SKNode *jellys;
@property (nonatomic) SKNode *chickens;
@property (nonatomic) SKNode *jellysBullets;
@property (nonatomic) SKNode *chickenBullets;
@property (nonatomic) SKNode *props;
@property (nonatomic) GuageBar *guageBar;
@property (nonatomic) int birdFlyNumber;
@property (nonatomic) int isStopBridRoop;
@property (nonatomic) int randomLine;
@property (nonatomic) int classType;
@property (nonatomic) int manaType;
@property (nonatomic) float gap;
@property (nonatomic) BOOL isStartPlayTheGame;
@property (nonatomic) float nextMusicTime;

@end
