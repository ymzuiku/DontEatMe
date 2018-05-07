//
//  War_Class5.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class5.h"
#import "Stump.h"
#import "StudyTip.h"
#import "CreateJelly.h"

@implementation War_Class5

-(void)createStump
{
    Stump *stump1 = [[Stump alloc] initWithNumber:12];
    [self.props addChild:stump1];
//    Stump *stump2 = [[Stump alloc] initWithNumber:10];
//    [self.props addChild:stump2];
//    Stump *stump3 = [[Stump alloc] initWithNumber:14];
//    [self.props addChild:stump3];
    
    [super createStump];
}

-(void)createDate
{
    self.randomLine = 0;
    self.c_name = iString(@"class5");
    self.c_scene = @"greed";
     self.c_particle = @"Rain";                  //@"Rain" @"Snow" @"Send" @"Tree"
    self.nextMusicTime = self.gap*10.5;
    self.c_music = music_land1;
    self.c_prize = @"gem.energy.A";
    
    self.c_chickens = @[
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil)],
                          @"time": @2,
                          },
                        
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil)],
                          @"time": @(self.gap),
                          },
                        
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil),
                                            ck(0, c_wooden, 0, @"gold.1")],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(1, c_spoon, 0, nil),],
                                            
                          @"time": @(self.gap*3.9),
                          },
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil)],
                          @"time": @(self.gap*4.5),
                          },
                        
                        @{@"chickenType": @[ck(2, c_spoon, 0, nil),],
                          @"time": @(self.gap*4.5),
                          },
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(3, c_beer, 0, @"gold.1"),
                                            ck(2, c_spoon, 0, nil),],
                          @"time": @(self.gap*5.7),
                          },
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(3, c_wooden, 0, @"gold.1"),],
                          @"time": @(self.gap*6.9),
                          },
                        
                        @{@"chickenType": @[ck(3, c_wooden, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),],
                          @"time": @(self.gap*8.1),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_spoon, 0, nil),],
                          @"time": @(self.gap*9.0),
                          },
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(0, c_spoon, 0, nil),
                                            ck(2, c_wooden, 0, nil),],
                          @"time": @(self.gap*9.9),
                          },
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(0, c_spoon, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(3, c_beer, 0, nil),
                                           ],
                          @"time": @(self.gap*11.2),
                          },
                        @{@"chickenType": @[ck(3, c_spoon, 0, nil),
                                            ck(0, c_spoon, 0, nil),
                                            ck(1, c_spoon, 0, nil),
                                            ck(3, c_spoon, 0, @"gold.1"),
                                            ck(1, c_spoon, 0, nil),
                                            ck(3, c_spoon, 0, @"gold.1"),
                                            ck(4, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, nil),],
                          @"time": @(self.gap*12.5),
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


@end
