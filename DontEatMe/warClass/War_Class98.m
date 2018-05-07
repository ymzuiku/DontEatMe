//
//  War_Class98.m
//  DontEatMe
//
//  Created by ym on 14-10-4.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class98.h"
#import "Stump.h"
@implementation War_Class98

-(void)createDate
{
    ////树墩
    //勺子,洋葱,木盆,铁盆,醉酒
    self.c_name = @"Level 98";
    self.c_scene = @"greed";
    self.nextMusicTime = 900;
    self.c_music = music_land2;
    self.c_prize = @"jellyPro.7.win";
    
    self.c_chickens = @[
                        //-------------------------- b
                        @{@"chickenType": @[ck(11, c_fish, 0, @"gold.1")],
                          @"time": @0,
                          },
                        
                        @{@"chickenType": @[ck(14, c_spoon, 0, nil)],
                          @"time": @(self.gap),
                          },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, @"gold.1")],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(3, c_wooden, 0, nil),
                                            ck(3, c_rifle, 0, nil)],
                          @"time": @(self.gap*3),
                          },
                        
                        @{@"chickenType": @[ck(2, c_spoon, 0, nil),
                                            ck(0, c_spoon, 0, nil),],
                          @"time": @(self.gap*4),
                          },
                        
                        @{@"chickenType": @[ck(2, c_wooden, 0, @"gold.1"),
                                            ck(0, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[ck(3, c_fish, 0, nil),],
                          @"time": @(self.gap*4),
                          },
                        
                        @{@"chickenType": @[ck(2, c_rifle, 0, @"gold.1"),
                                            ck(4, c_fish, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*7),
                          },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(1, c_fish, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          @"time": @(self.gap*8),
                          },
                        
                        @{@"chickenType": @[ck(4, c_fish, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),
                                            ck(2, c_spoon, 0, nil),],
                          @"time": @(self.gap*9),
                          },
                        
                        @{@"chickenType": @[ck(1, c_fish, 0, nil),
                                            ck(0, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(1, c_spoon, 0, nil),
                                            ck(0, c_fish, 0, @"gold.1"),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(2, c_onion, 0, @"gold.1"),
                                            ck(4, c_spoon, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(0, c_spoon, 0, nil),
                                            ck(1, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(1, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*10.2),
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

-(void)createStump
{
    Stump *stump1 = [[Stump alloc] initWithNumber:12];
    [self.props addChild:stump1];
    
    Stump *stump2 = [[Stump alloc] initWithNumber:13];
    [self.props addChild:stump2];
}



@end
