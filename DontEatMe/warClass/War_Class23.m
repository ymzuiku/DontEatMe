//
//  War_Class23.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class23.h"

@implementation War_Class23

-(void)createDate
{
    //勺子,洋葱,铁盆,长枪,咸鱼
    self.c_name = @"Level 23";
    self.c_scene = @"snow";
    self.nextMusicTime = self.gap*11.5;
    self.c_music = music_land1;
    self.c_prize = @"cook.2.win";
    
    
    
    self.c_chickens = @[
                        //-------------------------- a
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(0.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(2.5, 8)),},
                        
                        //-------------------------- b
                        @{@"chickenType": @[ck(1, c_sleep, 0, nil)],
                          @"time": @0,
                          },
                        
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil)],
                          @"time": @(self.gap*0.7),
                          },
                        
                        @{@"chickenType": @[ck(1 , c_wooden, 0, nil)],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(1, c_iron, 0, nil),
                                            ck(4, c_wooden, 0, nil)],
                          @"time": @(self.gap*3),
                          },
                        
                        @{@"chickenType": @[ck(1, c_bore, 0, nil),],
                          @"time": @(self.gap*4),
                          },
                        
                        @{@"chickenType": @[ck(3, c_wooden, 0, nil),],
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[ck(3, c_bore, 0, nil),],
                          @"time": @(self.gap*5.8),
                          },
                        
                        @{@"chickenType": @[ck(3, c_fish, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*6),
                          },
                        
                        @{@"chickenType": @[ck(1, c_fish, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*7),
                          },
                        
                        @{@"chickenType": @[ck(0, c_fish, 0, nil),
                                            ck(4, c_bore, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_bore, 0, nil),],
                          @"time": @(self.gap*8.5),
                          //
                          },
                        @{@"chickenType": @[ck(0, c_fish, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_bore, 0, nil),
                                            ck(2, c_bore, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_bore, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ],
                          @"time": @(self.gap*9.5),
                          },
                        @{@"chickenType": @[ck(0, c_fish, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_fish, 0, nil),
                                            ck(2, c_bore, 0, nil),
                                            ck(4, c_bore, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ],
                          @"time": @(self.gap*10.5),
                          },
                        @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ],
                          @"time": @(self.gap*11.5),
                          },


                        
                        ];
}


@end
