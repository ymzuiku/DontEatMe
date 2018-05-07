//
//  War_Class3.m
//  DontEatMe
//
//  Created by ym on 14/9/12.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "War_Class4.h"
#import "StudyTip.h"
#import "CreateJelly.h"
#import "ShieldJelly.h"

@implementation War_Class4
{
    int tipNumber;
    int isTipJellySoUp;
}

-(void)createDate
{
    self.c_name = iString(@"class4");
    self.c_scene = @"island";
    self.nextMusicTime = self.gap*8.5;
    self.c_music = music_land2;
    self.c_prize = @"map.1.win";
    
    NSDictionary *dic0 = @{@"chickenType": @[ck(12, c_beer, 0, nil)],
                           @"time": @2,};
    
    NSDictionary *dic1 = @{@"chickenType": @[ck(2, c_wooden, 0, nil)],
                           @"time": @(self.gap*1.6),
                           };
    
    NSDictionary *dic2 = @{@"chickenType": @[ck(1, c_wooden, 0, nil)],
                           @"time": @(self.gap*2.5),
                           };
    
    NSDictionary *dic3 = @{@"chickenType": @[ck(0, c_beer, 0, @"gold.1"),
                                             ],
                           @"time": @(self.gap*3),
                           };
    
    NSDictionary *dic4 = @{@"chickenType": @[ck(2, c_spoon, 0, nil),
                                             ck(1, c_wooden, 0, @"gold.1"),
                                             ],
                           @"time": @(self.gap*3.8),
                           };
    
    NSDictionary *dic5 = @{@"chickenType": @[ck(0, c_beer, 0, nil),
                                            ck(3, c_wooden, 0, nil),
                                            ck(2, c_onion, 0, @"gold.1"),
                                             ],
                           @"time": @(self.gap*4.8),
                           };
    
    NSDictionary *dic6 = @{@"chickenType": @[ck(0, c_spoon, 0, nil),
                                             ck(4, c_wooden, 0, @"gold.1"),
                                             ck(1, c_spoon, 0, nil),],
                           @"time": @(self.gap*6),
                           };
    
    NSDictionary *dic7 = @{@"chickenType": @[
                                                ck(0, c_beer, 0, nil),
                                                ck(4, c_wooden, 0, @"gold.1"),
                                                ck(3, c_wooden, 0, @"gold.1"),
                                                ck(2, c_spoon, 0, nil),
                                            ],
                           @"time": @(self.gap*7),
                           };
    
    NSDictionary *dic8 = @{@"chickenType": @[ck(4, c_spoon, 0, @"gold.1"),
                                             ck(2, c_spoon, 0, nil),
                                             ck(2, c_beer, 0, @"gold.1"),
                                             ck(3, c_wooden, 0, nil),
                                             ck(1, c_spoon, 0, nil),],
                           @"time": @(self.gap*8.5),
                           };
    
    NSDictionary *prop1 = @{@"cloud":@[@[@(skRand(1, 5)),@0]],
                            @"time": @(self.gap*skRand(1.5, 9)),};

    self.c_chickens = @[dic0,dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8, prop1];
}

-(void)beginTheGame  //选完果冻
{
    [super beginTheGame];
    
    ViewController *vc = [ViewController single];
    
    SKAction *waitFadeInA = [SKAction waitForDuration:4];
    SKAction *fadeinAlphaA = [SKAction fadeAlphaTo:1 duration:3];
    SKAction *seqForFadeInA = [SKAction sequence:@[waitFadeInA,fadeinAlphaA]];
    
    Grid *grid = [GridArray getGridArray][12];
    [CreateJelly addJellyWithName:@"iceThin" pos:CGPointMake(grid.position.x+5, grid.position.y-48) gird:grid array:[GridArray getGridArray] games:vc.gameScene.war.jellys];
    Grid *grid1 = [GridArray getGridArray][17];
    Body *iceThinJelly = grid.nodeInGrid;
    iceThinJelly.alpha = 0;
    [iceThinJelly runAction:seqForFadeInA];
    
    SKAction *waitFadeInB = [SKAction waitForDuration:18];
    SKAction *fadeinAlphaB = [SKAction fadeAlphaTo:1 duration:3];
    SKAction *seqForFadeInB = [SKAction sequence:@[waitFadeInB,fadeinAlphaB]];
    
    [CreateJelly addJellyWithName:@"shield" pos:CGPointMake(grid1.position.x+5, grid1.position.y-48) gird:grid1 array:[GridArray getGridArray] games:vc.gameScene.war.jellys];
    ShieldJelly *shieldJelly = (ShieldJelly *)grid1.nodeInGrid;
    shieldJelly.isCding = 1;
    shieldJelly.alpha = 0;
    [shieldJelly runAction:seqForFadeInB completion:^{
        shieldJelly.isCding = 0;
    }];
   
}



@end
