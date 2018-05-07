//
//  War_Class8.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class8.h"
#import "StudyTip.h"
#import "PickNode.h"
#import "stump.h"

@implementation War_Class8
{
    int isTouchWhistleButton;
    PickNode *pick;
}

//-(void)createStump
//{
//    Stump *stump1 = [[Stump alloc] initWithNumber:37];
//    stump1.isCantBeTouch = 1;
//    [self.props addChild:stump1];
//    stump1.position = CGPointMake(stump1.position.x, stump1.position.y+20);
//    Stump *stump2 = [[Stump alloc] initWithNumber:35];
//    stump2.isCantBeTouch = 1;
//    [self.props addChild:stump2];
//    stump2.position = CGPointMake(stump2.position.x, stump2.position.y+20);
//    Stump *stump3 = [[Stump alloc] initWithNumber:39];
//    stump3.isCantBeTouch = 1;
//    [self.props addChild:stump3];
//    stump3.position = CGPointMake(stump3.position.x, stump3.position.y+20);
//    Stump *stump4 = [[Stump alloc] initWithNumber:36];
//    stump4.isCantBeTouch = 1;
//    [self.props addChild:stump4];
//    stump4.position = CGPointMake(stump4.position.x, stump4.position.y+20);
//    Stump *stump5 = [[Stump alloc] initWithNumber:38];
//    stump5.isCantBeTouch = 1;
//    [self.props addChild:stump5];
//    stump5.position = CGPointMake(stump5.position.x, stump5.position.y+20);
//    [super createStump];
//}

-(void)createDate
{
    //勺子,洋葱,铁盆,醉酒
    self.c_name = @"Level 8";
    self.c_scene = @"greed";
    self.nextMusicTime = self.gap*11.5;
    self.c_music = music_land2;
    self.c_prize = @"jelly.boom.win";
    
    self.c_chickens = @[
                        //-------------------------- b
                        @{@"chickenType": @[ck(3, c_spoon, 0, @"gold.1")],
                          @"time": @0,
                          },
                        
                        @{@"chickenType": @[ck(2, c_spoon, 0, nil)],
                          @"time": @(self.gap),
                          },
                        
                        @{@"chickenType": @[ck(3, c_wooden, 0, @"gold.1")],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, nil)],
                          @"time": @(self.gap*3),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(0, c_mini, 0, nil),],
                          @"time": @(self.gap*4),
                          },
                        
                        @{@"chickenType": @[
                                        ck(4, c_spoon, 0, nil),],
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[ck(3, c_wooden, 0, nil),
                                            ck(0, c_mini, 0, @"gold.1"),],
                          @"time": @(self.gap*6),
                          },
                        
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(4, c_mini, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),],
                          @"time": @(self.gap*7),
                          },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*8),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*9.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*10.5),
                          },
                        
                        @{@"chickenType": @[
                                            ck(0, c_wooden, 0, nil),
                                            ck(4, c_bomb, 0, @"gold.1"),
                                            ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, @"gold.1"),
                                            ck(2, c_wooden, 0, nil),
                                            ],
                          @"time": @(self.gap*11.5),
                          },
                        
                        @{@"chickenType": @[
                                            ck(0, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(3, c_wooden, 0, @"gold.1"),
                                            ck(3, c_onion, 0, nil),
                                            ck(4, c_beer, 0, @"gold.1"),
                                            ck(4, c_spoon, 0, nil),
                                            ],
                          @"time": @(self.gap*12.5),
                          },
                        
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*13.5),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*14.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*15.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*16.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*17.5),
                          },
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                                ck(4, c_mini, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),],
                              @"time": @(self.gap*18.5),
                              },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*19.5),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*20.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*21.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*22.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*23.5),
                          },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*24.5),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*25.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*26.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*27.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*28.5),
                          },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*29.5),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*30.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*31.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*32.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*33.5),
                          },@{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                                ck(4, c_mini, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),],
                              @"time": @(self.gap*34.5),
                              },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*35.5),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*36.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*37.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*38.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*39.5),
                          },@{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                                ck(4, c_mini, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),],
                              @"time": @(self.gap*40.5),
                              },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*41.5),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*42.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*43.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*44.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*45.5),
                          },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*46.5),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*47.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*48.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*49.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*50.5),
                          },
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                                ck(4, c_mini, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),],
                              @"time": @(self.gap*51.5),
                              },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*52.5),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*53.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*54.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*55.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*56.5),
                          },
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                                ck(4, c_mini, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),],
                              @"time": @(self.gap*57.5),
                              },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*58.5),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*59.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*60.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*61.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*62.5),
                          },@{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                                ck(4, c_mini, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),],
                              @"time": @(self.gap*63.5),
                              },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*64.5),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*65.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*66.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*67.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*68.5),
                          },@{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                                ck(4, c_mini, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),],
                              @"time": @(self.gap*69),
                              },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*70),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*71),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*72.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*73.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*74.5),
                          },@{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                                ck(4, c_mini, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),],
                              @"time": @(self.gap*75.5),
                              },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*76),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*77),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*78),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*79),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*80.5),
                          },@{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                                ck(4, c_mini, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),],
                              @"time": @(self.gap*81),
                              },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*82),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*83),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*84),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*85.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*86.5),
                          },@{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                                ck(4, c_mini, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),],
                              @"time": @(self.gap*87),
                              },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*88),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*89.5),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*90.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*91.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*92.5),
                          },@{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                                ck(4, c_mini, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),],
                              @"time": @(self.gap*93),
                              },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_spoon, 0, nil),
                                            ck(4, c_bomb, 0, nil),],
                          @"time": @(self.gap*94),
                          },
                        
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1"),],
                          @"time": @(self.gap*95),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_mini, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          //
                          @"time": @(self.gap*96.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(4, c_bomb, 0, @"gold.1"),
                                  ck(0, c_wooden, 0, nil),
                                  ck(2, c_wooden, 0, @"gold.1"),
                                  ck(2, c_wooden, 0, nil),
                                  ],
                          @"time": @(self.gap*97.5),
                          },
                        
                        @{@"chickenType": @[
                                  ck(0, c_wooden, 0, nil),
                                  ck(1, c_beer, 0, @"gold.1"),
                                  ck(3, c_wooden, 0, @"gold.1"),
                                  ck(3, c_onion, 0, nil),
                                  ck(4, c_beer, 0, @"gold.1"),
                                  ck(4, c_spoon, 0, nil),
                                  ],
                          @"time": @(self.gap*98.5),
                          },
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(4, c_mini, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),],
                          @"time": @(self.gap*99.5),
                          },
                        
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(4, c_mini, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),],
                          @"time": @(self.gap*100.5),
                          },
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(4, c_mini, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),],
                          @"time": @(self.gap*101.5),
                          },
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(4, c_mini, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),],
                          @"time": @(self.gap*102.5),
                          },

                        
                        //-------------------------- a
                        @{@"cloud":@[@[@(skRand(1, 4)),@0]],
                          @"time": @(self.gap*skRand(0.5, 9)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 4)),@0]],
                          @"time": @(self.gap*skRand(1.5, 9)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 4)),@0]],
                          @"time": @(self.gap*skRand(2.5, 9)),},
                        
                        ];
}

-(void)beginTheGame
{
    [super beginTheGame];
    SKAction *wait1 = [SKAction waitForDuration:3];
    SKAction *block1 = [SKAction runBlock:^{
        pick = [[PickNode alloc] init];
        pick.position = CGPointMake(iw-80, 50);
        pick.zPosition = 2010;
        [self addChild:pick];
        pick.xScale = -0.75;
    }];
    SKAction *seq1 = [SKAction sequence:@[wait1, block1]];
    [self runAction:seq1];
    
    SKAction *wait2 = [SKAction waitForDuration:2];
    SKAction *block2 = [SKAction runBlock:^{
        if (self.birdFlyNumber > 1) {
            [pick removeFromParent];
        }
    }];
    SKAction *seq2 = [SKAction sequence:@[wait2, block2]];
    [self runAction:[SKAction repeatAction:seq2 count:30]];
    
}




@end
