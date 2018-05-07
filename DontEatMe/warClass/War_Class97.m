//
//  War_Class97.m
//  DontEatMe
//
//  Created by ym on 14-10-11.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class97.h"
#import "Stump.h"

@implementation War_Class97

-(void)createDate
{
    self.c_name = @"Level 99";
    self.c_scene = @"greed";
    self.nextMusicTime = 900;
    self.c_music = music_land5;
    self.c_prize = @"jelly.1.win";
    self.manaType = manaInfinity;
    //self.c_initChickens = @[c_wooden,c_beer, c_onion ,c_bomb,c_fat,c_fire,c_fish,c_fur,c_iron,c_machete,c_maid,c_normal,c_rifle,c_saw,c_snail,c_spoon,c_weed,c_wooden,c_yoda];
    
    NSDictionary *dic_0 = @{@"chickenType": @[ck(2, c_machete, 0, @"gold.1")],
                            @"time": @0,
                            };
    
    NSDictionary *dic_1 = @{@"chickenType": @[ck(2, c_spoon, 0, nil),
                                              ck(2, c_spoon, 0, nil)],
                            @"time": @24,
                            @"music": @"0",
                            };
    
    self.c_chickens = @[dic_0, dic_1];
}

@end
