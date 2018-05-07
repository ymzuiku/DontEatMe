//
//  War_Class73.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class73.h"

@implementation War_Class73

-(void)createDate
{
    self.c_name = @"Level A2";
    self.c_scene = @"snow";
    self.nextMusicTime = 900;
    self.c_music = @"greedWorld.mp3";
    self.c_prize = @"cook.2.win";
    NSLog(@"73");
    self.c_chickens = @[
                        //--------------------------
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(0.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(2.5, 8)),},
                        
                        //-------------------------- b
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ],
                          @"time": @0,
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil)],
                          @"time": @(self.gap),
                          },
                        
                        @{@"chickenType": @[ck(3, c_wooden, 0, nil)],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_spoon, 0, nil)],
                          @"time": @(self.gap*3),
                          },
                        
                        @{@"chickenType": @[ck(2, c_fish, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*4),
                          },
                        
                        @{@"chickenType": @[ck(0, c_bore, 0, nil),
                                            ck(1, c_wooden, 0, nil),],
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ],
                          
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[ck(3, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_machete, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*6),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_machete, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*7),
                          },
                        
                        @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_machete, 0, nil),
                                            ck(4, c_iron, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(3, c_bore, 0, nil),
                                            ck(3, c_wooden, 0, nil),],
                          @"time": @(self.gap*8.5),
                          //
                          },
                        
                        @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(1, c_mini, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_spoon, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),],
                          @"time": @(self.gap*9.5),
                          },
                        ];
}


@end
