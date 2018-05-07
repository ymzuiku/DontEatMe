//
//  War_Class15.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class15.h"
#import "ButtonBomb.h"
#import "Button.h"
#import "StudyTip.h"

@implementation War_Class15

-(void)createStump
{

    ButtonBomb *buttonBomb1 = [[ButtonBomb alloc] initWithNumber:31];
    [self addChild:buttonBomb1];
    
    ButtonBomb *buttonBomb2 = [[ButtonBomb alloc] initWithNumber:32];
    [self addChild:buttonBomb2];
    
    ButtonBomb *buttonBomb3 = [[ButtonBomb alloc] initWithNumber:33];
    [self addChild:buttonBomb3];
    
    Button *button = [[Button alloc] initWithNumber:12];
    [self.props addChild:button];
}

-(void)createDate
{
    //小紧张
    //勺子,洋葱,铁盆,胖子,长枪
    self.c_name = @"Level 15";
    self.c_scene = @"snow";
    self.nextMusicTime = self.gap*13.9;
    self.c_music = music_land1;
    self.c_prize = @"cook.2.win";
    self.randomLine = 0;

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
                          @"time": @5,
                          },
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil)],
                          @"time": @(self.gap),
                          },
                        
                        @{@"chickenType": @[ck(3, c_wooden, 0, nil)],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_spoon, 0, nil)],
                          @"time": @(self.gap*3.2),
                          },
                        
                        @{@"chickenType": @[ck(2, c_iron, 0, nil),
                                            ck(4, c_beer, 0, nil),],
                          @"time": @(self.gap*4.3),
                          },
                        
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_spoon, 0, nil),],
                          @"time": @(self.gap*5.4),
                          },
                        
                        @{@"chickenType": @[ck(4, c_beer, 0, @"gold.1"),
                                            ck(3, c_beer, 0, nil),
                                            ck(2, c_maid, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(4, c_beer, 0, nil),],
                          @"time": @(self.gap*7),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(0, c_beer, 0, @"gold.1"),
                                            ck(0, c_weed, 0, nil),],
                          @"time": @(self.gap*8.0),
                          },
                        
                        @{@"chickenType": @[
                                            ck(0, c_iron, 0, nil),
                                            ck(0, c_fish, 0, nil),
                                            ck(2, c_beer, 0, @"gold.1"),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_maid, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(4, c_fish, 0, nil),
                                            ],
                          @"time": @(self.gap*9.7),
                          },
                        @{@"chickenType": @[
                                            ck(2, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(0, c_weed, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(1, c_fish, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ],
                          @"time": @(self.gap*11),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_iron, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_fish, 0, nil),],
                          @"time": @(self.gap*12.5),
                          },
                        
                        @{@"chickenType": @[
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_fish, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(1, c_fish, 0, @"gold.1"),
                                            ck(1, c_spoon, 0, nil),
                                            ck(4, c_iron, 0, @"gold.1"),
                                            ck(4, c_fish, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(2, c_fish, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, @"gold.1"),
                                            ck(1, c_wooden, 0, nil),
                                            ],
                          @"time": @(self.gap*13.9),
                          //
                          },
                        
                        ];
}


@end
