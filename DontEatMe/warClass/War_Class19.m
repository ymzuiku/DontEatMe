//
//  War_Class19.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class19.h"

@implementation War_Class19

-(void)createDate
{
    //大大鸡 紧张
    //勺子,洋葱,木盆,咸鱼
    self.c_name = @"Level 19";
    self.c_scene = @"snow";
    self.nextMusicTime = self.gap*11;
    self.c_music = music_land1;
    self.c_prize = @"gem.energy.A";
    self.classType = bigChicken;
    self.manaType = manaInfinity;
    self.gap = 24;
    self.c_chickens = @[
                        //-------------------------- a
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(0.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(2.5, 8)),},
                        
                        //-------------------------- b
                        @{@"chickenType": @[ck(0, c_spoon, 1, nil)],
                          @"time": @10,
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 2, nil)],
                          @"time": @(self.gap*1),
                          },
                        
                        @{@"chickenType": @[ck(3, c_wooden, 3, nil)],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(1, c_fish, 0, nil),
                                            ck(4, c_spoon, 4, nil)],
                          @"time": @(self.gap*3),
                          },
                        
                        @{@"chickenType": @[ck(2, c_spoon, 0, nil),],
                          @"time": @(self.gap*4),
                          },
                        
                        @{@"chickenType": @[ck(0, c_beer, 0, nil),],
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),],
                          @"time": @(self.gap*6),
                          },
                        
                        @{@"chickenType": @[ck(3, c_fish, 0, nil),
                                            ck(2, c_wooden, 0, nil),],
                          @"time": @(self.gap*7),
                          },
                        
                        @{@"chickenType": @[ck(1, c_fish, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*9),
                          },
                        
                        @{@"chickenType": @[ck(0, c_fish, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_wooden, 0, nil),],
                          @"time": @(self.gap*11),
                          //
                          },
                        ];
}


@end
