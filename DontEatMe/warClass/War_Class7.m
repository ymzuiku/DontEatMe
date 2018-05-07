//
//  War_Class7.m
//  DontEatMe
//
//  Created by ym on 14/12/1.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "War_Class7.h"
#import "Story.h"
#import "stump.h"

@implementation War_Class7
{
    int isSpoonSay;
}

-(void)createDate
{
    //无限能量
    self.c_name = @"Level 7";
    self.c_scene = @"greed";
    self.nextMusicTime = self.gap*3;
    self.c_music = music_land1;
    self.c_prize = @"whistle.1.win";
    self.classType = miniChicken;
    self.manaType = manaInfinity;
    self.gap = 14;
    self.c_chickens = @[
                        
                        @{@"chickenType": @[
                                  ck(2, c_sleep, 0, nil),
                                  ],
                          @"time": @(self.gap*0.3),
                          },
                        @{@"chickenType": @[
                                  ck(2, c_spoon, 0, nil),
                                  ck(2, c_wooden, 0, nil),
                                  ck(3, c_beer, 0, nil),
                                  ck(4, c_wooden, 0, nil),
                                  ck(4, c_spoon, 0, nil),
                                  
                                  ],
                          @"time": @(self.gap*3),
                          },
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(1, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1")],
                          @"time": @(self.gap*4),
                          },
                        
                        
                        
                        //                        //-------------------------- b
                        @{@"chickenType": @[ck(4, c_spoon, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(1, c_spoon, 0, nil),
                                            ck(1, c_spoon, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1")],
                          @"time": @(self.gap*5),
                          },
                        @{@"chickenType": @[ck(0, c_bomb, 0, nil),
                                            ck(3, c_bomb, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_bomb, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1")],
                          @"time": @(self.gap*5.5),
                          },
                        
                        
                        @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(4, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(1, c_spoon, 0, nil),
                                            ck(0, c_beer, 0, nil),],
                          @"time": @(self.gap*6),
                          },
                        @{@"chickenType": @[ck(0, c_bomb, 0, nil),
                                            ck(3, c_bomb, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_bomb, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1")],
                          @"time": @(self.gap*6.5),
                          },
                        
                        
                        @{@"chickenType": @[ck(3, c_wooden, 0, nil),
                                            ck(4, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(1, c_spoon, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(3, c_wooden, 0, nil),],
                          @"time": @(self.gap*7),
                          },
                        
                        @{@"chickenType": @[ck(0, c_bomb, 0, nil),
                                            ck(3, c_bomb, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_bomb, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1")],
                          @"time": @(self.gap*7.5),
                          },
                        
                        
                        @{@"chickenType": @[ck(1, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(2, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(1, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_spoon, 0, nil),
                                            ck(0, c_wooden, 0, @"gold.1"),],
                          @"time": @(self.gap*8),
                          },
                        
                        @{@"chickenType": @[ck(0, c_bomb, 0, nil),
                                            ck(3, c_bomb, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(4, c_bomb, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(2, c_spoon, 0, @"gold.1")],
                          @"time": @(self.gap*8.5),
                          },
                        
                        @{@"chickenType": @[ck(2, c_onion, 0, nil),
                                            ck(0, c_spoon, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_spoon, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_spoon, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_spoon, 0, nil),
                                            ],
                          @"time": @(self.gap*9),
                          },
                        
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(3, c_bomb, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(3, c_beer, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_onion, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_bomb, 0, nil),
                                            ],
                          @"time": @(self.gap*9.5),
                          },
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_wooden, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_bomb, 0, nil),
                                            ],
                          @"time": @(self.gap*10.5),
                          },
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_wooden, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*11),
                          },
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_wooden, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*13),
                          },
                        @{@"chickenType": @[ck(4, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*15),
                          },
                        @{@"chickenType": @[ck(4, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*15),
                          },

                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_wooden, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*16),
                          },
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_wooden, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*16),
                          },

                        @{@"chickenType": @[ck(4, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*17),
                          },
                        @{@"chickenType": @[ck(4, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*17),
                          },

                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_wooden, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*18),
                          },
                        @{@"chickenType": @[ck(2, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_wooden, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*18),
                          },

                        @{@"chickenType": @[ck(4, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*19),
                          },
                        @{@"chickenType": @[ck(4, c_bomb, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(3, c_bomb, 0, @"gold.1"),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_bomb, 0, nil),
                                            ck(0, c_onion, 0, nil),
                                            ck(1, c_bomb, 0, nil),
                                            ck(1, c_wooden, 0, nil),
                                            ck(2, c_beer, 0, nil),
                                            ck(4, c_wooden, 0, nil),
                                            ck(0, c_beer, 0, nil),
                                            ck(1, c_wooden, 0, @"gold.1"),
                                            ck(2, c_beer, 0, nil),
                                            ],
                          @"time": @(self.gap*19),
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


-(void)beginTheGame  //选完果冻
{
    [super beginTheGame];
    ViewController *vc = [ViewController single];
    SKAction *wait0 = [SKAction waitForDuration:self.gap*0.7];
    SKAction *block0 = [SKAction runBlock:^{
        Story *story = [Story createWithNumber:-1 string:iString(@"c7")];
        story.zPosition = 3000;
        [vc.gameScene addChild:story];
    }];
    [self runAction:[SKAction repeatAction:[SKAction sequence:@[wait0, block0]] count:1]];
    
    ClassCenter *cc = [ClassCenter singleton];
    isSpoonSay = 0;
    if (vc.gameScene.isAgainClass == 1) {
        isSpoonSay = 1;
    }
    SKAction *updateDownMana = [SKAction waitForDuration:1];
    SKAction *updateDownManaBlock = [SKAction runBlock:^{
        if (cc.startNumber == 1 && isSpoonSay == 0) {
            cc.startNumber = 3;
            isSpoonSay = 3;
            self.chickens.speed = 0;
            // !!!创建教程1
            SKAction *wait = [SKAction waitForDuration:2];
            SKAction *block = [SKAction runBlock:^{
                Story *story = [Story createWithNumber:-1 string:iString(@"c7b")];
                story.zPosition = 3000;
                [story event:^{
                    SKAction *fadeOut = [SKAction fadeOutWithDuration:1.5];
                    [self.chickens runAction:fadeOut];
                    self.isGameIn = 2;
                    [vc.gameScene.touchLayer closeTouchUI];
                    [vc.gameScene downObject:self.c_prize pos:CGPointMake(iw/2, ih/2+260)];
                }];
                [vc.gameScene addChild:story];
            }];
            SKAction *seq = [SKAction sequence:@[wait, block]];
            [self runAction:seq];
        }
    }];
    [self runAction:[SKAction repeatAction:[SKAction sequence:@[updateDownMana, updateDownManaBlock]] count:999]];
}

-(void)collied
{
    if (self.isGameIn == 2) {
        return;
    }
    [super collied];
}

@end
