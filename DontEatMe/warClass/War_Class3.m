//
//  War_Class2.m
//  DontEatMe
//
//  Created by ym on 14/9/12.
//  Copyright (c) 2014年 ym. All rights reserved.
//  woodenBasin ironBasin onion

#import "War_Class3.h"
#import "PickNode.h" 
#import "Story.h"
#import "CreateJelly.h"

@implementation War_Class3
{
    int isPickNumbel;
    PickNode *pick;
}

-(void)createDate
{
    self.c_name = iString(@"class3");
    self.c_scene = @"island";
    self.nextMusicTime = 900;
    self.c_music = music_land1;
    self.c_prize = @"jelly.shield.win";
    
    NSDictionary *dic0 = @{@"chickenType": @[ck(12, c_beer, 0, @"gold.1")],
                            @"time": @2,
                            };
    
    NSDictionary *dic1 = @{@"chickenType": @[ck(1, c_spoon, 0, @"gold.1")],
                           @"time": @(self.gap*1.1),
                           };
    
    NSDictionary *dic2 = @{@"chickenType": @[ck(0, c_spoon, 0, nil)],
                           @"time": @(self.gap*2.1),
                           };
    
    NSDictionary *dic3 = @{@"chickenType": @[
                                             ck(2, c_wooden, 0, @"gold.1"),],
                           @"time": @(self.gap*3.2),
                           };
    
    NSDictionary *dic4 = @{@"chickenType": @[ck(3, c_spoon, 0, nil),
                                             ck(1, c_wooden, 0, nil),],
                           @"time": @(self.gap*4.6),
                           };
    
    NSDictionary *dic5 = @{@"chickenType": @[ck(0, c_wooden, 0, nil),
                                             ck(2, c_onion, 0, @"gold.1"),
                                             ck(4, c_spoon, 0, @"gold.1"),
                                             ck(3, c_wooden, 0, nil),
                                             ck(1, c_spoon, 0, @"gold.1"),],
                           @"time": @(self.gap*6.3),
                           };
    
    NSDictionary *cloud1 = @{@"cloud":@[@[@3,@0]],
                           @"time": @27,};
    
    self.c_chickens = @[dic0, dic1, dic2, dic3, dic4, dic5, cloud1];
}

-(void)beginTheGame  //选完果冻
{
    [super beginTheGame];
    
    ViewController *vc = [ViewController single];
    
    Grid *grid = [GridArray getGridArray][12];
    [CreateJelly addJellyWithName:@"iceThin" pos:CGPointMake(grid.position.x+5, grid.position.y-48) gird:grid array:[GridArray getGridArray] games:vc.gameScene.war.jellys];
    SKSpriteNode *iceThinJelly = grid.nodeInGrid;
    iceThinJelly.alpha = 0;
    SKAction *waitFadeIn = [SKAction waitForDuration:4];
    SKAction *fadeinAlpha = [SKAction fadeAlphaTo:1 duration:3];
    SKAction *seqForFadeIn = [SKAction sequence:@[waitFadeIn,fadeinAlpha]];
    [iceThinJelly runAction:seqForFadeIn];

    SKAction *wait0 = [SKAction waitForDuration:self.gap*0.9];
    SKAction *block0 = [SKAction runBlock:^{
        Story *story = [Story createWithNumber:-1 string:iString(@"c3a")];
        story.zPosition = 3000;
        [vc.gameScene addChild:story];
    }];
    [self runAction:[SKAction repeatAction:[SKAction sequence:@[wait0, block0]] count:1]];
    
    SKAction *wait1 = [SKAction waitForDuration:self.gap*3.2+3];
    SKAction *block1 = [SKAction runBlock:^{
        Story *story = [Story createWithNumber:-1 string:iString(@"c3b")];
        story.zPosition = 3000;
        [vc.gameScene addChild:story];
    }];
    [self runAction:[SKAction repeatAction:[SKAction sequence:@[wait1, block1]] count:1]];
}

-(void)createPick:(CGPoint)pos
{
    pick = [[PickNode alloc] init];
    pick.position = pos;
    pick.zPosition = 1900;
    [self addChild:pick];
}


@end
