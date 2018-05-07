//
//  War_Class2001.m
//  DontEatMe
//
//  Created by ym on 15/3/5.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "War_Class2001.h"

@implementation War_Class2001

-(void)winCallBack
{
    NSLog(@"2001 winCallBack");
    [[UserCenter dic] objectForKey:@"mineList"][1] = @(YES);
    [UserCenter save];
    [super winCallBack];
}

-(void)createDate
{
    self.c_name = @"Level 55";
    self.c_scene = @"blue";
    self.nextMusicTime = 900;
    self.c_music = music_land5;
    self.c_prize = @"gold.30.win";
    self.manaType = manaInfinity;
    [[ViewController single].gameScene changeMana:500];
    
    self.c_chickens = @[
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        @{@"chickenType": @[ck(0, c_smart, 0, nil),],
                          @"time": @(0),},
                        
                        @{@"chickenType": @[ck(2, c_maid, 0, nil),],
                          @"time": @(10),},
                        
                        @{@"chickenType": @[ck(2, c_smart, 0, nil)],
                          @"time": @(self.gap),},
                        
                        @{@"chickenType": @[ck(3, c_beer, 0, nil)],
                          @"time": @(self.gap*2),},
                        
                        @{@"chickenType": @[ck(1, c_yoda, 0, nil),
                                            ck(4, c_flashMagic, 0, nil),
                                            ck(3, c_smart, 0, nil),],
                          @"time": @(self.gap*3.5),},
                        
                        @{@"chickenType": @[ck(2, c_shadow, 0, nil),
                                            ck(3, c_shadow, 0, nil),],
                          @"time": @(self.gap*4.5),},
                        
                        @{@"chickenType": @[ck(0, c_smart, 0, nil),
                                            ck(2, c_fireMagic, 0, nil),],
                          @"time": @(self.gap*5.5),},
                        
                        @{@"chickenType": @[ck(3, c_iron, 0, nil),
                                            ck(4, c_maid, 0, nil),
                                            ck(1, c_iron, 0, nil),],
                          @"time": @(self.gap*6.5),},
                        @{@"chickenType": @[ck(0, c_smart, 0, nil),
                                            ck(3, c_onion, 0, nil),
                                            ck(1, c_smart, 0, nil),],
                          @"time": @(self.gap*7.5),},
                        
                        @{@"chickenType": @[ck(0, c_iron, 0, nil),
                                            ck(1, c_smart, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_smart, 0, nil),
                                            ck(4, c_iron, 0, nil),],
                          //
                          @"time": @(self.gap*8.8),},
                        
                        @{@"chickenType": @[ck(3, c_yoda, 0, nil),
                                            ck(4, c_iron, 0, nil),],
                          //
                          @"time": @(self.gap*8.8),},
                        
                        
                        @{@"chickenType": @[ck(1, c_smart, 0, nil),
                                            //                                            ck(4, c_wooden, 0, nil),
                                            //                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_fire, 0, nil),],
                          @"time": @(self.gap*8),
                          },
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            //                                            ck(1, c_iron, 0, nil),
                                            //                                            ck(2, c_onion, 0, nil),
                                            //                                            ck(3, c_saw, 0, nil),
                                            ck(4, c_iron, 0, nil),],
                          //
                          @"time": @(self.gap*9.8),},
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            //                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_fire, 0, nil),],
                          @"time": @(self.gap*8),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            //                                            ck(3, c_beer, 0, nil),
                                            //                                            ck(4, c_wooden, 0, nil),
                                            //                                            ck(0, c_fish, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_saw, 0, nil),
                                            ck(3, c_fish, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*10.8),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            //                                            ck(3, c_beer, 0, nil),
                                            //                                            ck(4, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_saw, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*9.8),
                          },
                        
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(3, c_saw, 0, nil),
                                            ],
                          @"time": @(self.gap*11.3),
                          },
                        
                        @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(3, c_onion, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(2, c_fire, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*11.9),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(1, c_fire, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(3, c_fire, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*13.3),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(1, c_fire, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(3, c_fire, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*14.6),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(1, c_fire, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(4, c_saw, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(3, c_fire, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_saw, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*15.6),
                          },
                        
                        @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_iron, 0, nil),
                                            ck(4, c_fire, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(2, c_fire, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(4, c_iron, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(1, c_fire, 0, nil),],
                          @"time": @(self.gap*16.5),
                          //
                          },
                        ];
}


@end
