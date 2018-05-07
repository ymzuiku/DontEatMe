//
//  War_Class6.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class6.h"

@implementation War_Class6

-(void)createDate
{
    //小紧张
    self.c_name = @"Level 6";
    self.c_scene = @"greed";
    self.nextMusicTime = self.gap*11.9;
    self.c_music = music_land2;
    self.c_prize = @"cook.2.win";
    self.c_particle = @"Tree";
    self.c_chickens = @[//-------------------------- b
                        @{@"chickenType": @[ck(1, c_spoon, 0, @"gold.1")],
                          @"time": @2,
                          },
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil)],
                          @"time": @(self.gap),
                          },
                        
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil),
                                            ck(0, c_wooden, 0, @"gold.1")],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_spoon, 0, nil)],
                          @"time": @(self.gap*3.8),
                          },
                        
                        @{@"chickenType": @[ck(2, c_wooden, 0, nil),],
                          @"time": @(self.gap*4.5),
                          },
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(3, c_beer, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),],
                          @"time": @(self.gap*5.5),
                          },
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(0, c_wooden, 0, @"gold.1"),],
                          @"time": @(self.gap*6.5),
                          },
                        
                        @{@"chickenType": @[ck(3, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),],
                          @"time": @(self.gap*7.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*8.5),
                          },
                        
                        @{@"chickenType": @[
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(1, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*9.5),
                          },
                        
//                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
//                                            ck(2, c_onion, 0, nil),
//                                            ck(3, c_wooden, 0, @"gold.1"),
//                                            ck(0, c_beer, 0, nil),
//                                            ck(2, c_wooden, 0, nil),],
//                          @"time": @(self.gap*10.2),
//                          },
                        @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_beer, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),],
                          @"time": @(self.gap*10.5),
                          },
                        @{@"chickenType": @[ck(1, c_wooden, 0, nil),
                                            ck(0, c_spoon, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(2, c_wooden, 0, @"gold.1"),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_beer, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),],
                          @"time": @(self.gap*11.9),
                          },
                        
                        
                        //-------------------------- a
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(0.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(2.5, 8)),},
                        
                        ];
}


@end
