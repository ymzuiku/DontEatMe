//
//  War_Class61.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class61.h"

@implementation War_Class61

-(void)createDate
{
    //大大鸡
    self.c_name = @"Level 61";
    self.c_scene = @"lava";
    self.nextMusicTime = self.gap*24.5;
    self.c_music = music_land6;
    self.c_prize = @"map.6.win";
    
    self.c_chickens = @[
                        //-------------------------- a1
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        //-------------------------- a2
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        //-------------------------- 1
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil)],
                          @"time": @0,},
                        
                        //-------------------------- 2
                        @{@"chickenType": @[ck(2, c_spoon, 0, nil)],
                          @"time": @(self.gap),},
                        
                        //-------------------------- 3
                        @{@"chickenType": @[ck(3, c_wooden, 0, nil)],
                          @"time": @(self.gap*2),},
                        
                        //-------------------------- 4
                        @{@"chickenType": @[ck(1, c_wooden, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(3, c_spoon, 0, nil),],
                          @"time": @(self.gap*3.5),},
                        
                        //-------------------------- 5
                        @{@"chickenType": @[ck(2, c_spoon, 0, nil),
                                            ck(3, c_fireMagic, 0, nil),],
                          @"time": @(self.gap*4.5),},
                        
                        //-------------------------- 6
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),],
                          @"time": @(self.gap*5.5),},
                        
                        //-------------------------- 7
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(1, c_fireMagic, 0, nil),],
                          @"time": @(self.gap*6.5),},
                        //-------------------------- 8
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(3, c_iron, 0, nil),
                                            ck(1, c_spoon, 0, nil),],
                          @"time": @(self.gap*7.5),},
                        
                        //-------------------------- 9
                        @{@"chickenType": @[ck(0, c_iron, 0, nil),
                                            ck(1, c_iron, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_saw, 0, nil),
                                            ck(4, c_iron, 0, nil),],
                          //
                          @"time": @(self.gap*8.8),},
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_fire, 0, nil),],
                          @"time": @(self.gap*9.8),
                          },
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(1, c_iron, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_saw, 0, nil),
                                            ck(4, c_iron, 0, nil),],
                          //
                          @"time": @(self.gap*10.8),},
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_fire, 0, nil),],
                          @"time": @(self.gap*11.8),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_fish, 0, @"gold.1"),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(2, c_saw, 0, nil),
                                            ck(3, c_fish, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*13.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(2, c_saw, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*14.8),
                          },
                        
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(0, c_fish, 0, @"gold.1"),
                                            ck(1, c_beer, 0, nil),
                                            ck(4, c_saw, 0, @"gold.1"),
                                            ck(4, c_beer, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(3, c_saw, 0, nil),
                                            ],
                          @"time": @(self.gap*15.9),
                          },
                        
                        @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, @"gold.1"),
                                            ck(3, c_onion, 0, nil),
                                            ck(4, c_saw, 0, @"gold.1"),
                                            ck(3, c_beer, 0, nil),
                                            ck(2, c_fire, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(1, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*16.8),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(0, c_fish, 0, @"gold.1"),
                                            ck(1, c_fire, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(4, c_beer, 0, @"gold.1"),
                                            ck(3, c_fire, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(2, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*18.8),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(0, c_fish, 0, @"gold.1"),
                                            ck(1, c_fire, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(4, c_beer, 0, @"gold.1"),
                                            ck(3, c_fire, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(2, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*20.2),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(0, c_fish, 0, @"gold.1"),
                                            ck(1, c_fire, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(4, c_beer, 0, @"gold.1"),
                                            ck(3, c_fire, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(2, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*22.3),
                           //
                          },
                        
                        @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_onion, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_iron, 0, nil),
                                            ck(4, c_fire, 0, nil),
                                            ck(3, c_wooden, 0, @"gold.1"),
                                            ck(4, c_spoon, 0, nil),
                                            ck(2, c_fire, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(4, c_iron, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, @"gold.1"),
                                            ck(1, c_beer, 0, nil),
                                            ck(1, c_fire, 0, @"gold.1"),],
                          @"time": @(self.gap*24.5),
                          },
                        ];
}


@end
