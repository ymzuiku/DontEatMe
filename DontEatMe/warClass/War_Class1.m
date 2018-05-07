//
//  War.m
//  DontEatMe
//
//  Created by ym on 14/7/6.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "War_Class1.h"
#import "Stump.h"
#import "PickNode.h"
#import "StudyTip.h"
#import "Story.h"

@implementation War_Class1
{
    int isCreateChickens;
    NSArray *grids;
    PickNode *pick;
    SKSpriteNode *lineMask;
    ClassCenter *cc;
    int isPickNumble;
    Story *story1;
}

-(void)createDate
{
    self.c_mana = 2;
    self.c_name = iString(@"class1");
    self.c_scene = @"island";
    self.c_particle = @"Rain";                  //@"Rain" @"Snow" @"Send" @"Tree"
    self.nextMusicTime = 901;
    self.c_music = music_land1;
    self.c_prize = @"jelly.energy.win";
    self.randomLine = 0;
    self.birdFlyLoopTime = 9;
    self.userInteractionEnabled = YES;
    
    NSDictionary *dic_0 = @{@"chickenType": @[ck(2, c_spoon, 0, @"gold.1")],
                            @"time": @2,
                            };
    
    NSDictionary *dic_1 = @{@"chickenType": @[ck(2, c_spoon, 0, @"gold.1"),],
                            @"time": @11,
                            };
    
    NSDictionary *dic_2 = @{@"chickenType": @[ck(2, c_spoon, 0, nil)],
                            @"time": @17,
                            };
    
    self.c_chickens = @[dic_0, dic_1, dic_2];
}

-(void)createTheGame
{
    self.isStopBridRoop = 1;
    cc = [ClassCenter singleton];
    cc.classJellyNames = [NSMutableDictionary dictionary];
    [cc.classJellyNames setValue:@"banana" forKey:@"banana"];
    ViewController *vc = [ViewController single];
    [vc.gameScene startGame];
    
    vc.gameScene.touchLayer.isCanSpoon = NO;
    [self createStump];
    [self createLineMask];
}

-(void)beginTheGame
{
    [super beginTheGame];
    self.guageBar.hidden = YES;
//    return;
    //掉落mana提示捡起mana
    ViewController *vc = [ViewController single];
    isPickNumble = 0;
    SKAction *updateDownMana = [SKAction waitForDuration:0.5];
    SKAction *updateDownManaBlock = [SKAction runBlock:^{
        if (cc.lastObjPosition.x != 0 && isPickNumble == 0) {
            isPickNumble = 1;
            [self createPick:CGPointMake(cc.lastObjPosition.x, cc.lastObjPosition.y)];
            
            // !!!创建教程1
            SKAction *wait = [SKAction waitForDuration:0.2];
            SKAction *block = [SKAction runBlock:^{
                story1 = [Story createWithNumber:-1 string:iString(@"c1a")];
                story1.zPosition = 3000;
                [vc.gameScene addChild:story1];
            }];
            SKAction *seq = [SKAction sequence:@[wait, block]];
            [self runAction:seq];
        }
    }];
    [self runAction:[SKAction repeatAction:[SKAction sequence:@[updateDownMana, updateDownManaBlock]] count:30]];
    
    //捡起mana提示种植jelly
    SKAction *updateTouchMana = [SKAction waitForDuration:0.5];
    SKAction *updateTouchManaBlock = [SKAction runBlock:^{
        if (vc.gameScene.mana != 2 && isPickNumble == 1) {
            isPickNumble = 2;
            if (story1) {
                [story1 removeFromParent];
            }
            SKAction *moveTo = [SKAction moveTo:cciPhone5AutoPos(326-50, 437+20) duration:0.2];
            [pick runAction:moveTo];
            
            // !!!创建教程2
            SKAction *wait = [SKAction waitForDuration:0.2];
            SKAction *block = [SKAction runBlock:^{
                Story *story = [Story createWithNumber:-1 string:iString(@"c1b")];
                story.zPosition = 3000;
                [vc.gameScene addChild:story];
            }];
            SKAction *seq = [SKAction sequence:@[wait, block]];
            [self runAction:seq];
        }
    }];
    [self runAction:[SKAction repeatAction:[SKAction sequence:@[updateTouchMana, updateTouchManaBlock]] count:30*2]];
    
    
    SKAction *updateTouchJelly = [SKAction waitForDuration:0.5];
    SKAction *updateTouchJellyBlock = [SKAction runBlock:^{
        if (self.jellys.children.count > 1 && isPickNumble == 2) {
            isPickNumble = 3;
            [pick removeAllActions];
            [pick removeFromParent];
            
            // !!!创建教程3
            SKAction *wait = [SKAction waitForDuration:7];
            SKAction *block = [SKAction runBlock:^{
                Story *story = [Story createWithNumber:-1 string:iString(@"c1c")];
                story.zPosition = 3000;
                [vc.gameScene addChild:story];
            }];
            SKAction *seq = [SKAction sequence:@[wait, block]];
            [self runAction:seq];
        }
    }];
    [self runAction:[SKAction repeatAction:[SKAction sequence:@[updateTouchJelly, updateTouchJellyBlock]] count:30*3]];
}

-(void)createLineMask
{
    lineMask = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_scene_obj_lineMask")[0]];
    lineMask.position = CGPointMake(iw/2+3, ih+10);
    lineMask.anchorPoint = CGPointMake(0.5, 1);
    [self addChild:lineMask];
    
    grids = [GridArray getGridArray];
    [grids enumerateObjectsUsingBlock:^(Grid *grid, NSUInteger idx, BOOL *stop) {
        if (idx%5 !=2) {
            grid.hasNode = 10;
            grid.isShowLines = 0;
        }
    }];
}


-(void)createStump
{
    Stump *stump0 = [[Stump alloc] initWithNumber:10-5];
    [self.props addChild:stump0];
    
    Stump *stump1 = [[Stump alloc] initWithNumber:11-5];
    [self.props addChild:stump1];
    
    Stump *stump2 = [[Stump alloc] initWithNumber:13-5];
    [self.props addChild:stump2];
    
    Stump *stump3 = [[Stump alloc] initWithNumber:14-5];
    [self.props addChild:stump3];
}

-(void)createPick:(CGPoint)pos
{
    pick = [[PickNode alloc] init];
    pick.position = pos;
    pick.zPosition = 1900;
    [self addChild:pick];
}

@end
