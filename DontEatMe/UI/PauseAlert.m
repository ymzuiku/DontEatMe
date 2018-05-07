//
//  PauseAlert.m
//  DontEatMe
//
//  Created by ym on 14/12/24.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "PauseAlert.h"
#import "QuitAlert.h"
#import "ReloadAlert.h"
#import "Book.h"

@implementation PauseAlert
{
    int isBlack;
    SKSpriteNode *background;
    SK_Button *goonButton;
    SK_Button *againButton;
    SK_Button *mapButton;
    SK_Button *bookButton;
    SK_Label *levelLabel;
    SK_Slider *musicSlider;
    SK_Sound *sound_sliderPickOn;
    SK_Sound *sound_sliderPickOff;
}

-(id)init
{
    if (self = [super initWithColor:rgb(0x000000, 0.0) size:CGSizeMake(iw, ih)]) {
        self.userInteractionEnabled = YES;
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        [self colorBlack:nil];
        [self createSomeBody];
        [self setButtonsEvent];
    }
    return self;
}

-(void)createSomeBody
{
    background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_pauseAlert")[0]];
    background.position = CGPointMake(iw/2, ih/2-35);
    [self addChild:background];
    
    goonButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_pauseAlert")[1]];
    goonButton.position = CGPointMake(-172+4, 177-50);
    [background addChild:goonButton];
    
    againButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_pauseAlert")[2]];
    againButton.position = CGPointMake(0, 194-50);
    [background addChild:againButton];
    
    mapButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_pauseAlert")[3]];
    mapButton.position = CGPointMake(167-4, 177-50);
    [background addChild:mapButton];
    
    bookButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_pauseAlert")[4]];
    bookButton.position = CGPointMake(-106, -75-30);
    [background addChild:bookButton];
    [bookButton runAction:[SK_Actions actionWaterMiddleQuick]];
    
    musicSlider = [[SK_Slider alloc] initWithBackground:Atlas(@"ui_games_pauseAlert")[5] slider:Atlas(@"ui_games_pauseAlert")[6]];
    musicSlider.position = CGPointMake(137, -65-15);
    [background addChild:musicSlider];
    [musicSlider setOffPostion:CGPointMake(-26, 4) onPostion:CGPointMake(26, 4)];
    
    ViewController *vc = [ViewController single];
    levelLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:40 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter]; //0x84a800
    levelLabel.text = vc.gameScene.war.c_name;
    levelLabel.position = CGPointMake(0, 281);
    [background addChild:levelLabel];
}


-(void)setButtonsEvent
{
    ViewController *vc = [ViewController single];
    StaticActions *sa = [StaticActions single];
    
    [goonButton playSound:sa.sound_buttonA];
    [goonButton event:^{
        [vc.gameScene goon];
        [vc.gameScene.buttonBar showGamesBar];
        [self colorBlack:^{
            [self removeFromParent];
        }];
    }];
    
    [againButton playSound:sa.sound_buttonA];
    [againButton event:^{
        background.alpha = 0;
        ReloadAlert *reloadAlert = [[ReloadAlert alloc] init];
        reloadAlert.zPosition = 3002;
        [vc.gameScene addChild:reloadAlert];
        [reloadAlert cancel:^{
            background.alpha = 1;
        }];
    }];
    
    [mapButton playSound:sa.sound_buttonA];
    [mapButton event:^{
        background.alpha = 0;
        QuitAlert *quitAlert = [[QuitAlert alloc] init];
        quitAlert.zPosition = 3002;
        [vc.gameScene addChild:quitAlert];
        [quitAlert cancel:^{
            background.alpha = 1;
        }];
    }];
    
    bookButton.speed = 1.8; //test 书飘动太慢了，加快一点
    [bookButton playSound:sa.sound_buttonA];
    [bookButton event:^{
        background.alpha = 0;
        vc.book = [[Book alloc] initWithChangeBackgound:NO];
        vc.book.zPosition = 3000;
        vc.book.dontChangeTopbar = 1;
        [vc.gameScene  addChild:vc.book];
        [vc.book closeBlock:^{
            background.alpha = 1;
        }];
    }];
    
    ClassCenter *cc = [ClassCenter singleton];
    sound_sliderPickOn = [SK_Sound createNewSound:@"Sound/ui_tabButton_1.mp3" repeat:0];
    [musicSlider didOn:^{
        [sound_sliderPickOn play];
        [vc.gameScene.music_BG playSound];
        [[UserCenter dic] setValue:@YES forKey:@"music"];
        cc.isCanPlayMusic = YES;
    }];
    
    sound_sliderPickOff = [SK_Sound createNewSound:@"Sound/ui_tabButton_0.mp3" repeat:0];
    [musicSlider didOff:^{
        [sound_sliderPickOff play];
        [vc.gameScene.music_BG pauseSound];
        [[UserCenter dic] setValue:@NO forKey:@"music"];
        cc.isCanPlayMusic = NO;
    }];
    
    if ([[[UserCenter dic] objectForKey:@"music"] boolValue] == YES) {
        [musicSlider on:NO];
    }
    else {
        [musicSlider off:NO];
    }
}

-(void)colorBlack:(dispatch_block_t)block
{
    ViewController *vc = [ViewController single];
    if (isBlack == NO) {
        self.position = CGPointMake(0, 0);
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.3*0.6];
        [self runAction:color completion:^{
            if (block != nil) block();
        }];
        [vc.gameScene.topBar hiddenBackground];
        isBlack = YES;
    }
    
    else if (isBlack == YES) {
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, 0) colorBlendFactor:1 duration:0.3*0.6];
        [self runAction:color completion:^{
            if (block != nil) block();
            self.position = CGPointMake(640*2, 0);
        }];
        [vc.gameScene.topBar showBackground];
        isBlack = NO;
        
    }
}

@end
