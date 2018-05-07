//
//  Shop.m
//  DontEatMe
//
//  Created by ym on 14/7/5.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "Shop.h"

@implementation Shop
{
    BOOL isMiddle;
    SKSpriteNode *canvas_0;
    SKSpriteNode *canvas_1;
}

-(void)removeFromParent
{
    ViewController *vc = [ViewController single];
    if (vc.book) {
        vc.book.bookData.hidden = NO;
        vc.book.hidden = NO;
    }
    if (vc.gameScene.selectJellys) {
        vc.gameScene.selectJellys.hidden = NO;
        vc.gameScene.selectJellys.bookData.hidden = NO;
    }
    
    self.hidden = YES;
    //moveBar
    if (!vc.book) {
        [vc.mapScene moveBarShow];
    }
    [vc.mapScene.sv.miniMapBackground runAction:[SKAction fadeInWithDuration:0.3]];
    
    if (vc.mapScene.topBar) {
        [vc.mapScene.topBar showBackground];
    }
    if (vc.gameScene.topBar) {
        [vc.gameScene.topBar showBackground];
    }
    
    isMiddle = NO;
    
    [canvas_0 removeFromParent];
    canvas_0 = nil;
    
    [canvas_1 removeFromParent];
    canvas_1 = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
    vc.shop = nil;
}

-(id)initWith:(int)number
{
    if (self = [super initWithColor:rgb(0x000000, 0) size:CGSizeMake(iw, ih)]) {
        self.userInteractionEnabled = NO;
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        self.zPosition = 9100;
        isMiddle = NO;
        
        StaticActions *sa = [StaticActions single];
        SK_Button *closeButton = [SK_Button spriteNodeWithImageNamed:@"ui_shops/images/ui_shops_closeButton.png"];
        closeButton.position = cciPhone5Pos(578, 122, 549, 88);
        closeButton.zPosition = 100;
        [self addChild:closeButton];
        [closeButton playSound:sa.sound_buttonB];
        [closeButton event:^{
            ViewController *vc = [ViewController single];
            if (vc.book) {
                vc.book.bookData.hidden = NO;
                vc.book.lawn.hidden = NO;
            }
            [self removeFromParent];
        }];
        
        if (number == 0) {
            [self openCookPage];
        }
        else if(number == 1) {
            [self openGoldPage];
        }
        
        ViewController *vc = [ViewController single];
        if (!vc.book) {
            [self moveWindow];
        }
        else {
            vc.book.bookData.hidden = YES;
            vc.book.lawn.hidden = YES;
        }
        vc.gameScene.selectJellys.hidden = YES;
        vc.gameScene.selectJellys.bookData.hidden = YES;
        
        if (vc.mapScene.topBar) {
            [vc.mapScene.topBar hiddenBackground];
        }
        if (vc.gameScene.topBar) {
            [vc.gameScene.topBar hiddenBackground];
        }
    }
    return self;
}

-(void)openCookPage
{
    if (canvas_1) {
        canvas_1.hidden = YES;
        canvas_1.zPosition = -50;
    }
    if (canvas_0) {
        canvas_0.hidden = NO;
        canvas_0.zPosition = 50;
        return;
    }
    canvas_0 = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(iw, ih)];
    canvas_0.anchorPoint = CGPointMake(0.5, 0.5);
    canvas_0.position = CGPointMake(-5, -40);
    canvas_0.zPosition = 50;
    [self addChild:canvas_0];
    
    if(!iPhone5) {
        [canvas_0 setScale:0.9];
        canvas_0.position = CGPointMake(30-3, 96);
    }
    
    SK_PSD *cookView = [SK_PSD createWithPath:@"ui_shops" name:@"cookPage"];
    cookView.userInteractionEnabled = NO;
    [canvas_0 addChild:cookView];
    
    SK_PSD *cookButtons = [SK_PSD createWithPath:@"ui_shops" name:@"cookBtns"];
    [canvas_0 addChild:cookButtons];
    
    StaticActions *sa = [StaticActions single];
    
    SK_Button *goGoldButton = (SK_Button *)[cookView childNodeWithName:@"cooktab_button"];//goldtab_button cooktab_button
    goGoldButton.isTouchUp = NO;
    [goGoldButton playSound:sa.sound_buttonA];
    [goGoldButton event:^{
        [self openGoldPage];
    }];
    
    SK_Button *cookBtn_0 = (SK_Button *)[cookButtons childNodeWithName:@"cook_0_button"];
    [cookBtn_0 playSound:sa.sound_buttonA];
    [cookBtn_0 event:^{
        [[ViewController single] buyAlertWithTitle:iString(@"Buy Title") message:iString(@"Buy Cook") type:@"cook" number:12 callBack:nil];
    }];
    
    SK_Button *cookBtn_1 = (SK_Button *)[cookButtons childNodeWithName:@"cook_1_button"];
    [cookBtn_1 playSound:sa.sound_buttonA];	
    [cookBtn_1 event:^{
        [[ViewController single] buyAlertWithTitle:iString(@"Buy Title") message:iString(@"Buy Cook") type:@"maxCookTime" number:31 callBack:nil];
    }];
    
    SK_Button *cookBtn_2 = (SK_Button *)[cookButtons childNodeWithName:@"cook_2_button"];
    [cookBtn_2 playSound:sa.sound_buttonA];
    [cookBtn_2 event:^{
        [[ViewController single] buyAlertWithTitle:iString(@"Buy Title") message:iString(@"Buy Cook") type:@"maxCookTime" number:9999 callBack:nil];
    }];
    
    SK_Label *label_0 = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:16 size:26 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    label_0.text = iString(@"0.99$");
    label_0.position = CGPointMake(143, -66);
    [cookBtn_0 addChild:label_0];
    
    SK_Label *label_1 = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:16 size:26 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    label_1.text = iString(@"3.99$");
    label_1.position = CGPointMake(143, -78);
    [cookBtn_1 addChild:label_1];
    
    SK_Label *label_1a = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:15 size:28 color:rgb(0x606019, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    label_1a.text = iString(@"vip1");
    label_1a.position = CGPointMake(0, 53);
    [cookBtn_1 addChild:label_1a];
    
    SK_Label *label_1b = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:15 size:24 color:rgb(0x606019, 1) horizontal:SKLabelHorizontalAlignmentModeRight];
    label_1b.text = iString(@"everyday");
    label_1b.position = CGPointMake(-62, -17);
    [cookBtn_1 addChild:label_1b];
    
    SK_Label *label_2 = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:15 size:26 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    label_2.text = iString(@"29.99$");
    label_2.position = CGPointMake(143, -78);
    [cookBtn_2 addChild:label_2];
    
    SK_Label *label_2a = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:15 size:28 color:rgb(0x606019, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    label_2a.text = iString(@"vip2");
    label_2a.position = CGPointMake(0, 53);
    [cookBtn_2 addChild:label_2a];
    
    SK_Label *label_2b = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:15 size:24 color:rgb(0x606019, 1) horizontal:SKLabelHorizontalAlignmentModeRight];
    label_2b.text = iString(@"everyday");
    label_2b.position = CGPointMake(-62, -17);
    [cookBtn_2 addChild:label_2b];
    
    if ([iString(@"language") isEqualToString:@"Chinese"]) {
        cookBtn_2.texture = [SKTexture textureWithImageNamed:@"ui_shops/images/cook_2_button_cn.png"];
    }
}

-(void)openGoldPage
{
    if (canvas_0) {
        canvas_0.hidden = YES;
        canvas_0.zPosition = -50;
    }
    if (canvas_1) {
        canvas_1.hidden = NO;
        canvas_1.zPosition = 50;
        return;
    }

    canvas_1 = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(iw, ih)];
    canvas_1.anchorPoint = CGPointMake(0, 0);
    canvas_1.position = CGPointMake(-5, -40);
    canvas_1.zPosition = 50;
    [self addChild:canvas_1];
    
    if(!iPhone5) {
        [canvas_1 setScale:0.9];
        canvas_1.position = CGPointMake(30, 96);
    }
    
    SK_PSD *goldView = [SK_PSD createWithPath:@"ui_shops" name:@"goldPage"];
    [canvas_1 addChild:goldView];
    
    SK_PSD *goldButtons = [SK_PSD createWithPath:@"ui_shops" name:@"goldBtns"];
    [canvas_1 addChild:goldButtons];
    StaticActions *sa = [StaticActions single];
    

    
    SK_Button *goCookButton = (SK_Button *)[goldView childNodeWithName:@"goldtab_button"];
    goCookButton.isTouchUp = NO;
    [goCookButton playSound:sa.sound_buttonA];
    [goCookButton event:^{
        [self openCookPage];
    }];
    
    SK_Button *goldBtn_0 = (SK_Button *)[goldButtons childNodeWithName:@"gold_0_button"];
    [goldBtn_0 playSound:sa.sound_buttonA];
    [goldBtn_0 event:^{
        [[ViewController single] buyAlertWithTitle:iString(@"Buy Title") message:iString(@"Buy Boxer") type:@"gold" number:50 callBack:nil];
    }];
    
    SK_Button *goldBtn_1 = (SK_Button *)[goldButtons childNodeWithName:@"gold_1_button"];
    [goldBtn_1 playSound:sa.sound_buttonA];
    [goldBtn_1 event:^{
        [[ViewController single] buyAlertWithTitle:iString(@"Buy Title") message:iString(@"Buy Boxer") type:@"gold" number:150 callBack:nil];
    }];
    
    SK_Button *goldBtn_2 = (SK_Button *)[goldButtons childNodeWithName:@"gold_2_button"];
    [goldBtn_2 playSound:sa.sound_buttonA];
    [goldBtn_2 event:^{
        [[ViewController single] buyAlertWithTitle:iString(@"Buy Title") message:iString(@"Buy Boxer") type:@"gold" number:350 callBack:nil];
    }];
    
    SK_Button *goldBtn_3 = (SK_Button *)[goldButtons childNodeWithName:@"gold_3_button"];
    [goldBtn_3 playSound:sa.sound_buttonA];
    [goldBtn_3 event:^{
        [[ViewController single] buyAlertWithTitle:iString(@"Buy Title") message:iString(@"Buy Boxer") type:@"gold" number:900 callBack:nil];
    }];
    
    SK_Button *goldBtn_4 = (SK_Button *)[goldButtons childNodeWithName:@"gold_4_button"];
    [goldBtn_4 playSound:sa.sound_buttonA];
    [goldBtn_4 event:^{
        [[ViewController single] buyAlertWithTitle:iString(@"Buy Title") message:iString(@"Buy Boxer") type:@"gold" number:2000 callBack:nil];
    }];
    
    SK_Button *goldBtn_5 = (SK_Button *)[goldButtons childNodeWithName:@"gold_5_button"];
    [goldBtn_5 playSound:sa.sound_buttonA];
    [goldBtn_5 event:^{
        [[ViewController single] buyAlertWithTitle:iString(@"Buy Title") message:iString(@"Buy Boxer") type:@"gold" number:4999 callBack:nil];
    }];
    
    int lineNumber = iSEnglish ? 33 : 16;
    if (!iSEnglish) {
        goldBtn_5.texture = [SKTexture textureWithImageNamed:@"ui_shops/images/gold_5_button_cn.png"];
    }
    SK_Label *intoLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:lineNumber size:24 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeLeft];
    intoLabel.text = iString(@"shopping");
    intoLabel.position = CGPointMake(-190, 259);
    [goldView addChild:intoLabel];
    
    SK_Label *label_0 = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:16 size:26 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    label_0.text = iString(@"1.99$");
    label_0.position = CGPointMake(50, -49);
    [goldBtn_0 addChild:label_0];
    
    SK_Label *label_1 = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:16 size:26 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    label_1.text = iString(@"4.99$");
    label_1.position = CGPointMake(50, -49);
    [goldBtn_1 addChild:label_1];
    
    SK_Label *label_2 = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:16 size:26 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    label_2.text = iString(@"9.99$");
    label_2.position = CGPointMake(50, -49);
    [goldBtn_2 addChild:label_2];
    
    SK_Label *label_3 = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:16 size:26 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    label_3.text = iString(@"24.99$");
    label_3.position = CGPointMake(50, -49);
    [goldBtn_3 addChild:label_3];
    
    SK_Label *label_4 = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:16 size:26 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    label_4.text = iString(@"49.99$");
    label_4.position = CGPointMake(50, -49);
    [goldBtn_4 addChild:label_4];
    
    SK_Label *label_5 = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:16 size:26 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    label_5.text = iString(@"99.99$");
    label_5.position = CGPointMake(59, -38);
    [goldBtn_5 addChild:label_5];
}

-(void)moveWindow
{
    ViewController *vc = [ViewController single];
    if (!isMiddle) {

        //背景发灰
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.3*1.8];
        [self runAction:color];
        isMiddle = YES;
        
        //moveBar
        [vc.mapScene moveBarHidden];
        [vc.mapScene.sv.miniMapBackground runAction:[SKAction fadeOutWithDuration:0.3]];
    }
    else if (isMiddle) {

        //背景透明
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, 0) colorBlendFactor:1 duration:0.3*1.8];
        [self runAction:color completion:^{
            [self removeFromParent];
        }];
    }
}


@end
