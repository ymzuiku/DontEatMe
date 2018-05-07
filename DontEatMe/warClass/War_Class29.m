//
//  War_Class29.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class29.h"

@implementation War_Class29

-(void)createDate
{
    //弹簧 
    self.c_name = @"Level 29";
    self.c_scene = @"desert";
    self.nextMusicTime = self.gap*12;
    self.c_music = music_land1;
    self.c_prize = @"gold.15.win";
    
    
    
    self.c_chickens = @[
                        //-------------------------- a
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(0.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(1.5, 8)),},
                        
                        @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                          @"time": @(self.gap*skRand(2.5, 8)),},
                        
                        //-------------------------- b
                        @{@"chickenType": @[ck(1, c_mini, 0, nil)],
                          @"time": @0,
                          },
                        
                        @{@"chickenType": @[ck(3, c_mini, 0, @"gold.1")],
                          @"time": @(self.gap*1.0),
                          },
                        @{@"chickenType": @[ck(4, c_mini, 0, nil)],
                          @"time": @(self.gap*1.5),
                          },
                        
                        @{@"chickenType": @[ck(4, c_wooden, 0, nil)],
                          @"time": @(self.gap*2),
                          },
                        
                        @{@"chickenType": @[ck(0, c_beer, 0, @"gold.1"),
                                            ck(4, c_spoon, 0, nil)],
                          @"time": @(self.gap*3.5),
                          },
                        
                        @{@"chickenType": @[ck(2, c_beer, 0, nil),],
                          @"time": @(self.gap*4),
                          },
                        
                        @{@"chickenType": @[ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[ck(2, c_beer, 0, nil),],
                          @"time": @(self.gap*5),
                          },
                        
                        @{@"chickenType": @[ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(2, c_fire, 0, @"gold.1"),],
                          @"time": @(self.gap*6),
                          },
                        
                        @{@"chickenType": @[ck(3, c_iron, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_spoon, 0, nil),
                                            ck(3, c_fire, 0, @"gold.1"),],
                          @"time": @(self.gap*7),
                          },
                        
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, @"gold.1"),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_fire, 0, nil),],
                          @"time": @(self.gap*8),
                          },
                        @{@"chickenType": @[ck(0, c_fish, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(3, c_beer, 0, @"gold.1"),
                                            ck(3, c_bore, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*9.3),
                          },
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_fish, 0, @"gold.1"),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_fish, 0, @"gold.1"),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(0, c_wooden, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            
                                            ck(0, c_wooden, 0, nil),],
                          @"time": @(self.gap*10.3),
                          },
                        
                        
                        @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(1, c_bore, 0, @"gold.1"),
                                            ck(1, c_onion, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(3, c_wooden, 0, @"gold.1"),
                                            ck(4, c_spoon, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(3, c_bore, 0, @"gold.1"),
                                            ck(2, c_fish, 0, @"gold.1"),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(1, c_fire, 0, @"gold.1"),],
                          @"time": @(self.gap*11),
                         
                          },
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(1, c_beer, 0, nil),
                                            ck(2, c_bore, 0, @"gold.1"),
                                            ck(3, c_onion, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(3, c_wooden, 0, @"gold.1"),
                                            ck(4, c_spoon, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(3, c_bore, 0, @"gold.1"),
                                            ck(2, c_fish, 0, @"gold.1"),
                                            ck(1, c_beer, 0, @"gold.1"),
                                            ck(1, c_fire, 0, @"gold.1"),],
                          @"time": @(self.gap*12),
                          //
                          },

                        ];
}


@end
