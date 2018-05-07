//
//  War_Class74.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class74.h"

@implementation War_Class74

-(void)createDate
{
    //炸弹
    self.c_name = @"Level A3";
    self.c_scene = @"fruit";
    self.nextMusicTime = self.gap*13.7;
    self.c_music = @"greedWorld.mp3";
    self.c_prize = @"gold.15.win";
    NSLog(@"74");
    self.c_chickens = @[
                        //-------------------------- a
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(0.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(2.5, 8)),},
                        
                        //-------------------------- b
                        @{@"chickenType": @[ck(0, c_spoon, 0, @"gold.1")],
                          @"time": @0,
                          },
                        
                        @{@"chickenType": @[ck(1, c_mini, 0, nil)],
                          @"time": @(self.gap),
                          },
                        
                        @{@"chickenType": @[ck(3, c_iron, 0, @"gold.1")],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil)],
                          @"time": @(self.gap*3),
                          },
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil)],
                          @"time": @(self.gap*3.5),
                          },
                        
                        @{@"chickenType": @[ck(3, c_wooden, 0, @"gold.1")],
                          @"time": @(self.gap*4.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_beer, 0, nil)],
                          @"time": @(self.gap*5.5),
                          },
                        
                        @{@"chickenType": @[ck(2, c_wooden, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(2, c_rifle, 0, nil),],
                          @"time": @(self.gap*4),
                          },
                        
                        @{@"chickenType": @[ck(0, c_machete, 0, nil),
                                            ck(3, c_bomb, 0, nil),],
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_bomb, 0, nil),
                                            ck(4, c_rifle, 0, @"gold.1"),],
                          @"time": @(self.gap*6),
                          },
                        
                        @{@"chickenType": @[ck(1, c_machete, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(3 , c_spoon, 0, nil),],
                          @"time": @(self.gap*7),
                          },
                        
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil),
                                            ck(5, c_wooden, 0, nil),
                                            ck(4, c_machete, 0, nil),],
                          @"time": @(self.gap*7),
                          },
                        
                        @{@"chickenType": @[ck(4, c_iron, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(4, c_machete, 0, nil),],
                          @"time": @(self.gap*9),
                          },
                        @{@"chickenType": @[ck(4, c_iron, 0, nil),
                                            ck(5, c_wooden, 0, nil),
                                            ck(1, c_machete, 0, nil),
                                            ck(3, c_onion, 0, @"gold.1"),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_rifle, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          @"time": @(self.gap*10.3),
                          },
                        
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(0, c_rifle, 0, @"gold.1"),
                                            ck(1, c_wooden, 0, nil),
                                            ck(1, c_machete, 0, nil),
                                            ck(2, c_onion, 0, @"gold.1"),
                                            ck(2, c_rifle, 0, nil),
                                            ck(3, c_machete, 0, nil),
                                            ck(3, c_rifle, 0, nil),],
                          @"time": @(self.gap*11.7),
                          },
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(3, c_rifle, 0, @"gold.1"),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_machete, 0, nil),
                                            ck(2, c_onion, 0, @"gold.1"),
                                            ck(4, c_rifle, 0, nil),
                                            ck(4, c_machete, 0, nil),
                                            ck(3, c_rifle, 0, nil),],
                          @"time": @(self.gap*12.7),
                          },
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil),
                                            ck(3, c_beer, 0, @"gold.1"),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_iron, 0, nil),
                                            ck(2, c_onion, 0, @"gold.1"),
                                            ck(0, c_wooden, 0, nil),
                                            ck(4, c_bomb, 0, nil),
                                            ck(0, c_rifle, 0, nil),],
                          @"time": @(self.gap*13.7),
                          },


                        ];
}


@end
