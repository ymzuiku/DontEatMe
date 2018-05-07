//
//  War_Class11.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class11.h"
#import "StudyTip.h"

@implementation War_Class11

-(void)createDate
{
    //无限能量 树墩 快乐
    //勺子,洋葱,铁盆,胖子
    self.c_name = @"Level 11";
    self.c_scene = @"greed";
    self.nextMusicTime = self.gap*8;
    self.c_music = music_land2;
    self.c_prize = @"cook.2.win";
    self.manaType = manaInfinity;
    
    self.c_chickens = @[
                        //-------------------------- a
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(0.5, 4)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@1]],
                          @"time": @(self.gap*skRand(1.5, 4)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@2]],
                          @"time": @(self.gap*skRand(2.5, 4)),},
                        
                        //-------------------------- b
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_spoon, 0, @"gold.1"),
                                            ck(2, c_spoon, 0, nil)],
                          @"time": @3,
                          },
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_iron, 0, nil),
                                            ck(3, c_iron, 0, @"gold.1"),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_iron, 0, nil),],
                          @"time": @(self.gap),
                          },
                        
                        @{@"chickenType": @[ck(3, c_beer, 0, nil),
                                            ck(4, c_fish, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_iron, 0, nil),
                                            ck(2, c_onion, 0, @"gold.1"),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_iron, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(1, c_fish, 0, @"gold.1"),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_fish, 0, nil),],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_iron, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_fish, 0, nil),
                                            ck(0, c_iron, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(2, c_iron, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(0, c_iron, 0, nil),],
                          @"time": @(self.gap*3),
                          },
                        
                        @{@"chickenType": @[ck(2, c_beer, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(2, c_iron, 0, nil),
                                            ck(3, c_beer, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_onion, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_iron, 0, nil),],
                          @"time": @(self.gap*4),
                          //
                          },
                        @{@"chickenType": @[ck(2, c_onion, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(0, c_wooden, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*5.5),
                          //
                          },
                        @{@"chickenType": @[ck(2, c_onion, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(1, c_fish, 0, @"gold.1"),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_fish, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(1, c_iron, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(0, c_wooden, 0, @"gold.1"),
                                            ck(1, c_fish, 0, nil),
                                            ck(2, c_wooden, 0, @"gold.1"),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_fish, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*7.5),
                          },
                        @{@"chickenType": @[ck(2, c_onion, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_spoon, 0, nil),
                                            ck(1, c_iron, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(0, c_wooden, 0, @"gold.1"),
                                            ck(1, c_spoon, 0, nil),
                                            ck(2, c_wooden, 0, @"gold.1"),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*9),
                          },
                        
                        ];
    
}




@end
