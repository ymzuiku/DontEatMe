//
//  StartGameAlert.m
//  DontEatMe
//
//  Created by ym on 15/1/5.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "StartGameAlert.h"

@implementation StartGameAlert
{
    BOOL isBlack;
    SK_Button *okButton;
    SK_Button *cancelButton;
    War *war;
    NSString *classString;
    int classNumber;
    NSString *lableType;
    SKTexture *texType;
}

-(id)initWithClassNumber:(int)number classString:(NSString *)classStr;
{
    if (self = [super initWithColor:rgb(0x000000, 0.0) size:CGSizeMake(iw, ih)]) {
        self.userInteractionEnabled = YES;
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        [self colorBlack:nil];
        classNumber = number;
        classString = classStr;
        war = [War_Controller createWar:classNumber];
        [self loadTpye];
        [self createButton];
    }
    return self;
}

-(void)loadTpye
{
    if (![classString isEqualToString:@"first"]) {
        if (classNumber < 4) {
            war.c_prize = @"gold.3.win";
        }
        else if (classNumber < 20) {
            war.c_prize = @"gold.6.win";
        }
        else if (classNumber < 40) {
            war.c_prize = @"gold.12.win";
        }
        else if (classNumber < 60) {
            war.c_prize = @"gold.20.win";
        }
        else if (classNumber < 99) {
            war.c_prize = @"gold.30.win";
        }
    }
    
    NSArray *nameArray = [war.c_prize componentsSeparatedByString:@"."];
    NSString *objName = nameArray[0];
    if ([objName isEqualToString:@"jelly"]) {
        lableType = @"jelly.start";
        texType = Atlas(@"ui_map_startAlert")[8];
    }
    else if ([objName isEqualToString:@"gold"]) {
        lableType = @"gold.start";
        texType = Atlas(@"ui_map_startAlert")[14];
    }
    else if ([objName isEqualToString:@"cook"]) {
        lableType = @"cook.start";
        texType = Atlas(@"ui_map_startAlert")[13];
    }
    else if ([objName isEqualToString:@"gem"]) {
        NSDictionary *dic = [[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:nameArray[1]];
        NSString *foodString = [dic objectForKey:@"type"];
        
        if ([foodString isEqualToString:@"banana"]) {
            lableType = @"bananaGem.start";
            texType = Atlas(@"ui_map_startAlert")[11];
        }
        else if ([foodString isEqualToString:@"boom"]) {
            lableType = @"boomGem.start";
            texType = Atlas(@"ui_map_startAlert")[10];
        }
        else if ([foodString isEqualToString:@"shield"]) {
            lableType = @"shieldGem.start";
            texType = Atlas(@"ui_map_startAlert")[9];
        }
        else if ([foodString isEqualToString:@"ice"]) {
            lableType = @"iceGem.start";
            texType = Atlas(@"ui_map_startAlert")[5];
        }
        else if ([foodString isEqualToString:@"energy"]) {
            lableType = @"energyGem.start";
            texType = Atlas(@"ui_map_startAlert")[6];
        }
    }
    else if ([objName isEqualToString:@"whistle"]) {
        lableType = @"whistle.start";
        texType = Atlas(@"ui_map_startAlert")[7];
    }
    else if ([objName isEqualToString:@"jellyPro"]) {
        lableType = @"jellyPro.start";
        texType = Atlas(@"ui_map_startAlert")[8];
    }
    else if ([objName isEqualToString:@"map"]) {
        lableType = @"map.start";
        texType = Atlas(@"ui_map_startAlert")[12];
    }
}

-(void)createButton
{
    StaticActions *sa = [StaticActions single];
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_map_startAlert", 0)];
    background.position = CGPointMake(iw/2, ih/2-30);
    [self addChild:background];
    
    okButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_map_startAlert", 4)];
    okButton.position = CGPointMake(101, -125);
    [background addChild:okButton];
    
    cancelButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_map_startAlert", 3)];
    cancelButton.position = CGPointMake(-103, -125);
    [background addChild:cancelButton];
    
    int line = iSEnglish ? 26:13;
    SK_Label *title = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:line size:32 color:rgb(0x657108, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
//    title.text = [NSString stringWithFormat:@"%@%@", iString(@"startGame"), war.c_name];
    title.text = [NSString stringWithFormat:@" %@", war.c_name];
    title.position = CGPointMake(0, 280);
    [background addChild:title];
    
    SK_Label *label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:line size:26 color:rgb(0x657108, 0.9) horizontal:SKLabelHorizontalAlignmentModeCenter];
    label.text = iString(lableType);
    label.position = CGPointMake(0, 0);
    [background addChild:label];
    
    [okButton playSound:sa.sound_buttonA];
    [okButton event:^{
        ClassCenter *cc = [ClassCenter singleton];
        [UserCenter setNowClass:cc.nowMapNumber];
        [UserCenter save];
        [self createAGame:classNumber classString:classString];
    }];
    
    [cancelButton playSound:sa.sound_buttonB];
    [cancelButton event:^{
        [self removeFromParent];
    }];
    SKTexture *startTexture;
    if ([classString isEqualToString:@"first"]) {
        startTexture = Atlas(@"ui_map_startAlert")[1];
    }
    else if ([classString isEqualToString:@"again0"]) {
        startTexture = Atlas(@"ui_map_startAlert")[1];
    }
    else if ([classString isEqualToString:@"again1"]) {
        startTexture = Atlas(@"ui_map_startAlert")[2];
    }
    else if ([classString isEqualToString:@"again2"]) {
        startTexture = Atlas(@"ui_map_startAlert")[15];
    }
    else if ([classString isEqualToString:@"again3"]) {
        startTexture = Atlas(@"ui_map_startAlert")[16];
    }
    
    SKSpriteNode *start = [SKSpriteNode spriteNodeWithTexture:startTexture];
    start.position = CGPointMake(-152, 250-5);
    [background addChild:start];
    
    SKSpriteNode *image = [SKSpriteNode spriteNodeWithTexture:texType];
    image.position = CGPointMake(-1, 144);
    [background addChild:image];
    
    if ([lableType isEqualToString:@"jellyPro.start"]) {
        SKSpriteNode *sprtie = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_obj")[8]];
        sprtie.position = CGPointMake(0, -15);
        [sprtie setScale:1.2];
        [image addChild:sprtie];
    }
}

-(void)colorBlack:(dispatch_block_t)block
{
    if (isBlack == NO) {
        self.position = CGPointMake(0, 0);
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.3*0.6];
        [self runAction:color completion:^{
            if (block != nil) block();
        }];
        isBlack = YES;
    }
    else if (isBlack == YES) {
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, 0) colorBlendFactor:1 duration:0.3*0.6];
        [self runAction:color completion:^{
            if (block != nil) block();
            self.position = CGPointMake(640*2, 0);
        }];
        isBlack = NO;
    }
}
-(void)createAGame:(int)number classString:(NSString *)classStr;
{
    ViewController *vc = [ViewController single];
    [UserCenter addCook:-1];
    [vc.mapScene.topBar reloadLabel:^{
        [vc gotoGameScene:number classString:classStr];
        if (![classStr isEqualToString:@"first"]) {
            vc.gameScene.isAgainClass = 1;
        }
        [self removeFromParent];
    }];
}

@end
