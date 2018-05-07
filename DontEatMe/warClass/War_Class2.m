//
//  War.m
//  DontEatMe
//
//  Created by ym on 14/7/6.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "War_Class2.h"
#import "Stump.h"
#import "Story.h"
#import "PickNode.h"
#import "CreateJelly.h"

@implementation War_Class2
{
    NSArray *grids;
    PickNode *pick;
    SKSpriteNode *lineMask;
    int isPickNumbel;
}

-(void)createDate
{
    self.c_name = iString(@"class2");
    self.c_scene = @"island";
    self.nextMusicTime = 900;
    self.c_music = music_land2;
    self.c_prize = @"jelly.iceThin.win";

    self.randomLine = 0;
    
    NSDictionary *dic_0 = @{@"chickenType": @[ck(2, c_spoon, 0, @"gold.1")],
                            @"time": @10,
                            };
    
    NSDictionary *dic_1 = @{@"chickenType": @[ck(1, c_spoon, 0, @"gold.1")],
                            @"time": @(self.gap),
                            };
    NSDictionary *dic_2 = @{@"chickenType": @[ck(3, c_spoon, 0, nil)],
                            @"time": @(self.gap*2),
                            };
    NSDictionary *dic_3 = @{@"chickenType": @[ck(2, c_spoon, 0, nil),
                                              ck(1, c_spoon, 0, @"gold.1"),],
                            @"time": @(self.gap*3),
                            };
    NSDictionary *dic_4 = @{@"chickenType": @[ck(1, c_onion, 0, nil),
                                              ck(2, c_spoon, 0, @"gold.1"),
//                                              ck(3, c_spoon, 0, nil),
                                              ck(2, c_spoon, 0, @"gold.1"),],
                            @"time": @(self.gap*4),
                            @"music": @"0",
                            };
    self.c_chickens = @[dic_0, dic_1, dic_2, dic_3, dic_4];
}

-(void)createLineMask
{
    lineMask = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_obj_lineMask")[1]];
    lineMask.position = CGPointMake(iw/2+3, ih+10);
    lineMask.anchorPoint = CGPointMake(0.5, 1);
    [self addChild:lineMask];
    
    grids = [GridArray getGridArray];
    [grids enumerateObjectsUsingBlock:^(Grid *grid, NSUInteger idx, BOOL *stop) {
        if (idx%5 == 0 || idx%5 == 4) {
            grid.hasNode = 10;
            grid.isShowLines = 0;
        }
    }];
}

-(void)createStump
{
    [self createLineMask];
    Stump *stump0 = [[Stump alloc] initWithNumber:10];
    [self.props addChild:stump0];
    
    Stump *stump3 = [[Stump alloc] initWithNumber:14];
    [self.props addChild:stump3];
}

-(void)beginTheGame  //选完果冻
{
    [super beginTheGame];
    self.guageBar.hidden = YES;
    ViewController *vc = [ViewController single];
    
    Grid *grid = [GridArray getGridArray][27];
    [CreateJelly addJellyWithName:@"energy" pos:CGPointMake(grid.position.x+5, grid.position.y-48) gird:grid array:[GridArray getGridArray] games:vc.gameScene.war.jellys];
    SKSpriteNode *energyJelly = grid.nodeInGrid;
    energyJelly.alpha = 0;
    SKAction *waitFadeIn = [SKAction waitForDuration:4];
    SKAction *fadeinAlpha = [SKAction fadeAlphaTo:1 duration:3];
    SKAction *seqForFadeIn = [SKAction sequence:@[waitFadeIn,fadeinAlpha]];
    [energyJelly runAction:seqForFadeIn];
    
//    pick = [[PickNode alloc] init];
//    pick.position = CGPointMake(-100, -100);
//    [self addChild:pick];
    
    SKAction *wait1 = [SKAction waitForDuration:self.gap*1];
    SKAction *block1 = [SKAction runBlock:^{
        if (self.jellys.children.count > 0 && isPickNumbel == 0) {
            isPickNumbel = 1;
            Story *story = [Story createWithNumber:-1 string:iString(@"c2")];
            story.zPosition = 3000;
            [vc.gameScene addChild:story];
        }
    }];
    [self runAction:[SKAction repeatAction:[SKAction sequence:@[wait1, block1]] count:1]];
    
    SKAction *wait2 = [SKAction waitForDuration:self.gap*3+7];
    SKAction *block2 = [SKAction runBlock:^{
        Story *story = [Story createWithNumber:-1 string:iString(@"c2b")];
        story.zPosition = 3000;
        [vc.gameScene addChild:story];
    }];
    [self runAction:[SKAction repeatAction:[SKAction sequence:@[wait2, block2]] count:1]];
}



@end
