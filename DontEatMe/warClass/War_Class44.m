//
//  War_Class44.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class44.h"

@implementation War_Class44

-(void)createDate
{
    self.c_name = @"Level 44";
    self.c_scene = @"forest";
    self.nextMusicTime = self.gap*15.1;
    self.c_music = music_land5;
    self.c_prize = @"cook.2.win";
    
    
    
    self.c_chickens = @[
                        //-------------------------- a1
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        //-------------------------- a2
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        //-------------------------- 1
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil)],
                          @"time": @0,},
                        
                        //-------------------------- 2
                        @{@"chickenType": @[ck(2, c_iron, 0, nil)],
                          @"time": @(self.gap),},
                        
                        //-------------------------- 3
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil)],
                          @"time": @(self.gap*2),},
                        
                        //-------------------------- 4
                        @{@"chickenType": @[ck(1, c_wooden, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(3, c_spoon, 0, nil),],
                          @"time": @(self.gap*3.5),},
                        
                        //-------------------------- 5
                        @{@"chickenType": @[ck(2, c_spoon, 0, nil),
                                            ck(3, c_spoon, 0, nil),],
                          @"time": @(self.gap*4.5),},
                        
                        //-------------------------- 6
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),],
                          @"time": @(self.gap*5.5),},
                        
                        //-------------------------- 7
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(1, c_spoon, 0, nil),],
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
                          @"time": @(self.gap*9.2),
                          },
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(1, c_iron, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_saw, 0, nil),
                                            ck(4, c_iron, 0, nil),],
                          //
                          @"time": @(self.gap*10),},
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_fire, 0, nil),],
                          @"time": @(self.gap*10.6),
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
                          @"time": @(self.gap*11.6),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(2, c_saw, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*12.8),
                          },
                        
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_fish, 0, @"gold.1"),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, @"gold.1"),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(0, c_wooden, 0, nil),
                                            ck(3, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*13.9),
                          },
                        
                        
                        @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_onion, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(3, c_wooden, 0, @"gold.1"),
                                            ck(4, c_spoon, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, @"gold.1"),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            
                                            ck(1, c_fire, 0, @"gold.1"),],
                          @"time": @(self.gap*15.1),
                          //
                          },
                        ];
}


@end
