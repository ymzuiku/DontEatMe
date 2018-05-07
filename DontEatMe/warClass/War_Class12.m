//
//  War_Class12.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class12.h"

@implementation War_Class12

-(void)createDate
{
    //树墩
    //勺子,洋葱,铁盆,胖子
    self.c_name = @"Level 12";
    self.c_scene = @"greed";
    self.nextMusicTime = self.gap*9.5;
    self.c_music = music_land1;
    self.c_prize = @"map.2.win";
    
    self.c_chickens = @[
                        //-------------------------- a
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(0.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(2.5, 8)),},
                        
                        //-------------------------- b
                        @{@"chickenType": @[
                                  ck(2, c_spoon, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, @"gold.1"),
                                  ],
                          @"time": @0,
                          },
                        
                        @{@"chickenType": @[ck(3, c_spoon, 0, @"gold.1")],
                          @"time": @(self.gap),
                          },
                        
                        @{@"chickenType": @[ck(1, c_wooden, 0, nil)],
                          @"time": @(self.gap*2.3),
                          },
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(4, c_spoon, 0, nil)],
                          @"time": @(self.gap*3),
                          },
                        
                        @{@"chickenType": @[ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*4),
                          },
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(0, c_maid, 0, nil),],
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[ck(2, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),],
                          @"time": @(self.gap*5.3),
                          },
                        
                        @{@"chickenType": @[ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(3, c_beer, 0, nil),
                                            ck(3, c_beer, 0, nil),],
                          @"time": @(self.gap*6.3),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(1, c_spoon, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),],
                          @"time": @(self.gap*7),
                          },
                        
                        @{@"chickenType": @[ck(1, c_fish, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_fish, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(4, c_fish, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*7.9),
                          },
                        
                        @{@"chickenType": @[ck(2, c_onion, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(3, c_fish, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(4, c_beer, 0, nil),],
                          @"time": @(self.gap*8.9),
                          //
                          },
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_iron, 0, @"gold.1"),
                                            ck(2, c_maid, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_fish, 0, nil),],
                          @"time": @(self.gap*9.7),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(3, c_iron, 0, nil),
                                            ck(0, c_iron, 0, nil),
                                            ck(1, c_onion, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),],
                          @"time": @(self.gap*10.5),
                          },
                        
                        
                        ];
}


@end
