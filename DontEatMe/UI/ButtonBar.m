//
//  ButtonBar.m
//  DontEatMe
//
//  Created by ym on 14-5-3.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "ButtonBar.h"
#import "FreeWhistlePro.h"
#import "PauseAlert.h"

@implementation ButtonBar
{
    SKSpriteNode *gamesBar;
    SK_Label *manaLabel;
    SK_Label *manaLabelSub;
    SK_Label *whistleLabel;
    SK_Label *whistleProLabel;
    SK_Button *stopButton;
    SK_Button *manaButton;
    
    SKEmitterNode *startPartique;
    
    
    BOOL isStop;
    BOOL isReplaceBar;
    BOOL isBook;
    int mana;
    int egg;
    int startPartiqueLive;
    int isFirstBeginGame;
    int whistleNumber;
    SKAction *sound_manaTip;
    
    SKAction *manaUp;
    SKAction *manaDown;
}

-(void)removeFromParent
{
    [gamesBar removeAllChildren];
    [gamesBar removeFromParent];
    gamesBar = nil;
    
    [stopButton removeFromParent];
    stopButton = nil;
    
    [manaButton removeFromParent];
    manaButton = nil;
    
    [self removeActionForKey:@"sound_manaTip"];
    [self removeAllActions];
    [self removeAllChildren];
    [super removeFromParent];
    
    [self showGamesBar];
}

-(id)init
{
    if (self = [super init]) {
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        mana = 0;
        egg = 0;
        
        SKAction *manaUp0 = [SKAction scaleXTo:1.1 y:1 duration:0.1];
        SKAction *manaUp1 = [SKAction scaleXTo:0.9 y:1 duration:0.1];
        SKAction *manaUp2 = [SKAction scaleXTo:1.05 y:1 duration:0.1];
        SKAction *manaUp3 = [SKAction scaleXTo:1 y:1 duration:0.1];
        manaUp = [SKAction sequence:@[manaUp0, manaUp1, manaUp2, manaUp3]];
        
        SKAction *manaDown0 = [SKAction scaleXTo:0.9 y:1 duration:0.1];
        SKAction *manaDown1 = [SKAction scaleXTo:1.1 y:1 duration:0.1];
        SKAction *manaDown2 = [SKAction scaleXTo:0.95 y:1 duration:0.1];
        SKAction *manaDown3 = [SKAction scaleXTo:1 y:1 duration:0.1];
        manaDown = [SKAction sequence:@[manaDown0, manaDown1, manaDown2, manaDown3]];
        
        [self createBar];
        [self touchButtonsEvens];
        [self createPartique];
        
        sound_manaTip = [SKAction playSoundFileNamed:@"Sound/energy_createMana_0.mp3" waitForCompletion:0];
    }
    return self;
}

-(void)createPartique
{
    startPartique = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"ManaFullParticle" ofType:@"sks"]];
    startPartique.zPosition = -5000;
    startPartique.targetNode = self;
    startPartique.userInteractionEnabled = NO;
    if (iPhone5) {
        startPartique.position = CGPointMake(iw/2+15, 42);
        startPartiqueLive = 14;
    }
    else {
        startPartique.position = CGPointMake(iw/2+15, 42-16);
//        [startPartique setScale:0.5];
        startPartiqueLive = 1.5;
    }
    [gamesBar addChild:startPartique];
    startPartique.particleLifetime = 0;
}

-(void)createBar
{
    //------------------------------------  toolBar  ------------------------------------
    
    gamesBar = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(iw, 72)];
    gamesBar.anchorPoint = CGPointMake(0, 0);
    gamesBar.position = CGPointMake(0, 0);
    [self addChild:gamesBar];
    
    SKSpriteNode *stopBackground = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_bottom")[13]];
    stopBackground.anchorPoint = CGPointMake(0, 0);
    stopBackground.position = CGPointMake(0, 0);
    [stopBackground setScale:0.9];
    [gamesBar addChild:stopBackground];
    
    stopButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_bottom")[9]];
    stopButton.position = CGPointMake(47, 39);
    [gamesBar addChild:stopButton];
    
    manaButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_bottom")[14]];
    if (iPhone5) manaButton.position = CGPointMake(iw/2, 42);
    else manaButton.position = CGPointMake(iw/2, 42-5);
    manaButton.zPosition = 2;
    [gamesBar addChild:manaButton];

    manaLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:52 color:rgb(0xc38cf0, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    manaLabel.text = @"0";
    manaLabel.position = CGPointMake(20, 0); //CGPointMake(5, 0);
    [manaButton addChild:manaLabel];
    
    //------------------------------------  buttonBar  ------------------------------------
    whistleNumber = [[[[UserCenter dic] objectForKey:@"userRecord"] objectForKey:@"whistle"] intValue];

    if (whistleNumber > 0) {
        _whistleButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_bottom")[16]];
        _whistleButton.name = @"1";
        if (iPhone5) _whistleButton.position = CGPointMake(560, 42);
        else _whistleButton.position = CGPointMake(560, 42-5);
        [gamesBar addChild:_whistleButton];
        
        _whistleProButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_games_bottom")[17]];
        _whistleProButton.name = @"2";
        if (iPhone5) _whistleProButton.position = CGPointMake(560, 42);
        else _whistleProButton.position = CGPointMake(560, 42-5);
        [gamesBar addChild:_whistleProButton];
        
        whistleLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:52 color:rgb(0xc38cf0, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        whistleLabel.text = [NSString stringWithFormat:@"%d", whistleNumber];
        whistleLabel.position = CGPointMake(22, 0);
        [_whistleButton addChild:whistleLabel];
        
        whistleProLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:52 color:rgb(0xc38cf0, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        whistleProLabel.text = [NSString stringWithFormat:@"%d", whistleNumber];
        whistleProLabel.position = CGPointMake(22, 0);
        [_whistleProButton addChild:whistleProLabel];
        
        SKAction *moveRight = [SKAction moveTo:CGPointMake(800, _whistleButton.position.y) duration:0.01];
        SKAction *moveLeft = [SKAction moveTo:CGPointMake(560, _whistleButton.position.y) duration:0.01];
        if (whistleNumber == 1) {
            [_whistleButton runAction:moveLeft];
            [_whistleProButton runAction:moveRight];
        }
        else if (whistleNumber >= 2) {
            [_whistleButton runAction:moveRight];
            [_whistleProButton runAction:moveLeft];
        }
    }
}

-(void)changeMana:(int)theMana
{
    if (isFirstBeginGame == 1) {
        SKAction *big = [SK_Actions actionMiniBig];
        [manaButton runAction:big];
    }
    isFirstBeginGame = 1;
    mana = theMana;
    manaLabel.text = [NSString stringWithFormat:@"%d", mana];
    if (mana >= 20) {
        startPartique.particleLifetime = startPartiqueLive;
    }
    else {
        startPartique.particleLifetime = 0;
    }
}

-(void)hiddenBar
{
    SKAction *moveDown = [SKAction moveToY:-120 duration:0.3];
    moveDown.timingMode = SKActionTimingEaseInEaseOut;
    [gamesBar runAction:moveDown];
    
    if (mana >= 9) {
        startPartique.particleLifetime = 0;
    }
}

-(void)showGamesBar
{
    SKAction *moveDown = [SKAction moveToY:-120 duration:0.3];
    moveDown.timingMode = SKActionTimingEaseInEaseOut;
    
    SKAction *moveUp = [SKAction moveToY:0 duration:0.3];
    moveUp.timingMode = SKActionTimingEaseInEaseOut;
    
    [gamesBar runAction:moveUp];
    
    if (mana >= 20) {
        startPartique.particleLifetime = startPartiqueLive;
    }
}

#pragma mark - Touch
-(void)touchButtonsEvens
{
    ViewController *vc = [ViewController single];
    
    StaticActions *sa = [StaticActions single];
    [stopButton playSound:sa.sound_buttonA];
    [stopButton event:^{
        [vc.gameScene pause];
        [self hiddenBar];
        PauseAlert *pauseAlert = [[PauseAlert alloc] init];
        pauseAlert.zPosition = 3000;
        [vc.gameScene addChild:pauseAlert];
    }];
    
    [manaButton playSound:sa.sound_buttonC];
    [manaButton event:^{
        
    }];
    
    [_whistleButton playSound:sa.sound_buttonA];
    [_whistleButton event:^{
        if (whistleNumber > 0) {
            whistleNumber --;
            whistleLabel.text = [NSString stringWithFormat:@"%d", whistleNumber];
            ViewController *vc = [ViewController single];
            [vc.gameScene.war whistleOneBird];
        }
        else {
            ViewController *vc = [ViewController single];
            FreeWhistlePro *freeWhistlePro = [[FreeWhistlePro alloc] initWith:@"whistlePro.1"];
            freeWhistlePro.zPosition = 2002;
            [vc.gameScene addChild:freeWhistlePro];
        }
        
        if (whistleNumber <= 0) {
            [_whistleButton playSound:sa.sound_buttonC];
        }
        else {

        }
    }];
    
    [_whistleProButton playSound:sa.sound_buttonA];
    [_whistleProButton event:^{
        if (whistleNumber > 0) {
            whistleNumber --;
            whistleProLabel.text = [NSString stringWithFormat:@"%d", whistleNumber];
            ViewController *vc = [ViewController single];
            [vc.gameScene.war whistleOneBird];
        }
        
        if (whistleNumber <= 0) {
            [_whistleProButton playSound:sa.sound_buttonC];
        }
    }];
}

-(void)reloadWhistlePro
{
    whistleNumber = [[[[UserCenter dic] objectForKey:@"userRecord"] objectForKey:@"whistle"] intValue];
    
    SKAction *moveRight = [SKAction moveTo:CGPointMake(800, _whistleButton.position.y) duration:0.45];
    SKAction *moveLeft = [SKAction moveTo:CGPointMake(560, _whistleButton.position.y) duration:0.45];
    if (whistleNumber == 1) {
        [_whistleButton runAction:moveLeft];
        [_whistleProButton runAction:moveRight];
    }
    else if (whistleNumber >= 2) {
        [_whistleButton runAction:moveRight];
        [_whistleProButton runAction:moveLeft];
    }
    
    whistleProLabel.text = [NSString stringWithFormat:@"%d", whistleNumber];
}


@end
