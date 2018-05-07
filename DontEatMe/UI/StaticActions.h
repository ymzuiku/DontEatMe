//
//  StaticActions.h
//  DontEatMe
//
//  Created by ym on 14/9/6.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Atlas_Static(name)             [[StaticActions single] newAtlas:name]

@interface StaticActions : NSObject

+(StaticActions *)single;
-(void)loadAtlas:(void (^) ())block;
-(NSArray *)newAtlas:(NSString *)atlasName;
-(NSArray *)preload_home;
-(NSArray *)preload_map;
-(NSArray *)preload_game:(int)n;
-(NSArray *)loadJellyChickenAtlas:(NSArray *)array;
-(void)clearActions;

@property (nonatomic) SKAction *actionBig;
@property (nonatomic) SKAction *actionWater;
@property (nonatomic) SKAction *actionDown;
@property (nonatomic) SKAction *actionWait;
@property (nonatomic) SKAction *actionSpringUpWindow;
@property (nonatomic) SKAction *actionSpringDownWindow;
@property (nonatomic) SKAction *actionSpringRightInWindow;
@property (nonatomic) SKAction *actionSpringLeftOutWindow;
@property (nonatomic) SKAction *actionVerticalDown;

@property (nonatomic) NSMutableDictionary *staticAtlas;
@property (nonatomic) SKAction *sound_buttonA;
@property (nonatomic) SKAction *sound_buttonB;
@property (nonatomic) SKAction *sound_buttonC;
@property (nonatomic) SKAction *sound_buttonD;
@property (nonatomic) SKAction *sound_gold;
@property (nonatomic) SKAction *sound_cook;
@property (nonatomic) SKAction *sound_egg;
@property (nonatomic) SKAction *sound_win;
@property (nonatomic) SKAction *sound_pickTouch_0;
@property (nonatomic) SKAction *sound_getUp;
@property (nonatomic) SKAction *sound_bananaAttack;
@property (nonatomic) SKAction *sound_woodenBasinChangeHP0;
@property (nonatomic) SKAction *sound_woodenBasinChangeHP1;
@property (nonatomic) SKAction *sound_woodenBasinChangeHP2;
@property (nonatomic) SKAction *sound_ironBasinChangeHP0;
@property (nonatomic) SKAction *sound_ironBasinChangeHP1;
@property (nonatomic) SKAction *sound_normalChangeHP0;
@property (nonatomic) SKAction *sound_normalChangeHP1;
@property (nonatomic) SKAction *sound_normalChangeHP2;
@property (nonatomic) SKAction *sound_normalChangeHP3;
@property (nonatomic) SKAction *sound_normalChangeHP4;
@property (nonatomic) SKAction *sound_normalChangeHP5;
@property (nonatomic) SKAction *sound_normalChangeHP6;
@property (nonatomic) SKAction *sound_beNormal;
@property (nonatomic) SKAction *sound_chickenAttack0;
@property (nonatomic) SKAction *sound_chickenAttack1;
@property (nonatomic) SKAction *sound_chickenAttack2;
@property (nonatomic) SKAction *sound_chickenAttack3;
@property (nonatomic) SKAction *sound_basinChickenAttack0;
@property (nonatomic) SKAction *sound_basinChickenAttack1;
@property (nonatomic) SKAction *sound_basinChickenAttack2;
@property (nonatomic) SKAction *sound_createJelly;



@end
