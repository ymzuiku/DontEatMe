//
//  War_Class14.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class14.h"

@implementation War_Class14

-(void)createDate
{
    //炸弹
    //勺子,洋葱,铁盆,长枪
    self.c_name = @"Level 14";
    self.c_scene = @"snow";
    self.nextMusicTime = self.gap*12.9;
    self.c_music = music_land2;
    self.c_prize = @"gem.boom.B";
    self.c_particle = @"Snow";
    self.c_chickens = @[
                        //-------------------------- a
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(0.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(2.5, 8)),},
                        
                        //-------------------------- b
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil)],
                          @"time": @0,
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil)],
                          @"time": @(self.gap),
                          },
                        
                        @{@"chickenType": @[ck(3, c_wooden, 0, nil)],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(1, c_fish, 0, nil)],
                          @"time": @(self.gap*3.2),
                          },
                        
                        @{@"chickenType": @[ck(0, c_weed, 0, @"gold.1"),
                                            ck(4, c_beer, 0, nil),],
                          @"time": @(self.gap*4.3),
                          },
                        
                        @{@"chickenType": @[ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(1, c_beer, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(2, c_beer, 0, @"gold.1"),
                                            ck(0, c_spoon, 0, nil),],
                          @"time": @(self.gap*5),
                          },

                        
                        @{@"chickenType": @[ck(3, c_beer, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_weed, 0, nil),],
                          @"time": @(self.gap*5.9),
                          },
                        
                        @{@"chickenType": @[ck(4, c_beer, 0, @"gold.1"),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(3, c_beer, 0, nil),],
                          @"time": @(self.gap*7.6),
                          },
                        
                        @{@"chickenType": @[ck(1, c_fish, 0, nil),
                                            ck(0, c_wooden, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_weed, 0, @"gold.1"),
                                            ck(0, c_beer, 0, nil),
                                            ck(4, c_fish, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*8.7),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_fish, 0, nil),
                                            ck(2, c_iron, 0, nil),
                                            ck(3, c_fish, 0, nil),
                                            ck(3, c_fish, 0, nil),],
                          @"time": @(self.gap*10.7),
                          },

                        @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(1, c_fish, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_beer, 0, @"gold.1"),
                                            ck(1, c_fish, 0, nil),
                                            ck(4, c_beer, 0, @"gold.1"),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_fish, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(2, c_fish, 0, @"gold.1"),
                                            ck(0, c_wooden, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*11.9),
                          //
                          },
                        
                        ];
}


@end
