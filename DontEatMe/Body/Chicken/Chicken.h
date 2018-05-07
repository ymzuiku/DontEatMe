//
//  Chicken.h
//  DontEatMe
//
//  Created by pringlesfox on 9/2/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#define hpPosX     0
#define hpPosY     66

#import "Body.h"

@interface Chicken : Body

@property   float waitStartTime;
@property   int isWin;
@property   int level;

@property   NSString *texString_drop;
@property   NSString *texString_normalMove;
@property   NSString *texString_normalAttack;
@property   NSString *texString_normalRest;
@property   SKAction *soundAction_normalAttack;
@property   int isStartup;

-(void)chickenCoilDown;
-(void)sitLevel:(int)level;
@end
