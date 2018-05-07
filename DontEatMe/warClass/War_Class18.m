//
//  War_Class18.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class18.h"
#import "ButtonBomb.h"
#import "Button.h"

@implementation War_Class18

-(void)createStump
{
//    ButtonBomb *buttonBomb0 = [[ButtonBomb alloc] initWithNumber:25];
//    [self addChild:buttonBomb0];
//    buttonBomb0.zPosition = 1136 -buttonBomb0.position.y;
//    
//    ButtonBomb *buttonBomb1 = [[ButtonBomb alloc] initWithNumber:26];
//    [self addChild:buttonBomb1];
//    buttonBomb1.zPosition = 1136 -buttonBomb0.position.y;
//    
//    ButtonBomb *buttonBomb2 = [[ButtonBomb alloc] initWithNumber:27];
//    [self addChild:buttonBomb2];
//    buttonBomb2.zPosition = 1136 -buttonBomb0.position.y;
//    
//    ButtonBomb *buttonBomb3 = [[ButtonBomb alloc] initWithNumber:28];
//    [self addChild:buttonBomb3];
//    buttonBomb3.zPosition = 1136 -buttonBomb0.position.y;
//    
//    ButtonBomb *buttonBomb4 = [[ButtonBomb alloc] initWithNumber:29];
//    [self addChild:buttonBomb4];
//    buttonBomb4.zPosition = 1136 -buttonBomb0.position.y;
//
//    Button *button1 = [[Button alloc] initWithNumber:11];
//    [self.props addChild:button1];
//    
//    Button *button2 = [[Button alloc] initWithNumber:13];
//    [self.props addChild:button2];
}


-(void)createDate
{
    //炸弹
    //勺子,洋葱,木盆,铁盆,咸鱼
    self.c_name = @"Level 18";
    self.c_scene = @"snow";
    self.nextMusicTime = self.gap*13.5;
    self.c_music = music_land2;
    self.c_prize = @"jelly.slow.win";
    
    self.c_chickens = @[
                        //-------------------------- a
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(0.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(2.5, 8)),},
                        
                        //-------------------------- b
                        @{@"chickenType": @[ck(3, c_mini, 0, nil)],
                          @"time": @0,
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil)],
                          @"time": @(self.gap*0.6),
                          },
                        
                        @{@"chickenType": @[ck(1 , c_wooden, 0, nil)],
                          @"time": @(self.gap*1.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_fish, 0, nil),
                                            ck(4, c_spoon, 0, nil)],
                          @"time": @(self.gap*3),
                          },
                        
                        @{@"chickenType": @[ck(2, c_spoon, 0, nil),],
                          @"time": @(self.gap*4),
                          },
                        
                        @{@"chickenType": @[
                                            ck(3, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ],
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil),],
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[
                                            ck(4, c_wooden, 0, nil),
                                            ck(3, c_fish, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ],
                          @"time": @(self.gap*6),
                          },
                        
                        @{@"chickenType": @[ck(1, c_fish, 0, nil),
                                            ck(4, c_wooden, 0, nil),],
                          @"time": @(self.gap*7),
                          },
                        
                        @{@"chickenType": @[
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(0, c_spoon, 0, nil),
                                            ck(3, c_spoon, 0, nil),],
                          @"time": @(self.gap*8.5),
                        },
                        @{@"chickenType": @[ck(3, c_fish, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ],
                          @"time": @(self.gap*9.5),
                        },
                        @{@"chickenType": @[
                                            ck(3, c_maid, 0, nil),
                                            ],
                          @"time": @(self.gap*9.8),
                          },

                        @{@"chickenType": @[ck(2, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_onion, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          @"time": @(self.gap*10.5),
                        },

                        @{@"chickenType": @[ck(4, c_fish, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(3, c_wooden, 0, nil),
//                                            ck(2, c_maid, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ],
                          @"time": @(self.gap*11.5),
                          },
                        @{@"chickenType": @[
                                            ck(2, c_maid, 0, nil),
                                            ],
                          @"time": @(self.gap*11.7),
                          },

                        @{@"chickenType": @[ck(0, c_fish, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(0, c_wooden, 0, nil),
                                            ],
                          @"time": @(self.gap*13.5),
                          },
                        ];
}


@end
