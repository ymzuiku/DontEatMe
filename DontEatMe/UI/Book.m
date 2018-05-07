//
//  Book.m
//  DontEatMe
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "Book.h"
#import "PickNode.h"

@implementation Book
{
    SKSpriteNode *canvas;
    BOOL _isMiddle;
    void (^closeBlock)();
    SKNode *allJellys;
    PickNode *pick;
}

@synthesize isMiddle = _isMiddle;

-(void)removeFromParent
{
    [allJellys removeAllChildren];
    [allJellys removeFromParent];
    allJellys = nil;
    
    [pick removeFromParent];
    pick = nil;
    
    [_bookData removeAllChildren];
    [_bookData removeFromParent];
    _bookData = nil;
    
    [_lawn removeAllChildren];
    [_lawn removeFromParent];
    _lawn = nil;
    
    [canvas removeAllChildren];
    [canvas removeFromParent];
    canvas = nil;
    
    [pick removeFromParent];
    pick = nil;
    
    [self removeAllChildren];
    [super removeFromParent];
    ViewController *vc = [ViewController single];
    vc.book.bookData = nil;
    vc.book = nil;
}

-(id)init
{
    if (self = [super initWithColor:rgb(0x000000, 0.0) size:CGSizeMake(iw, ih)]) {
        [self rootInitWithChangeBackgound:YES];
    }
    return self;
}

-(id)initWithChangeBackgound:(BOOL)isChangeBackground
{
    if (self = [super initWithColor:rgb(0x000000, 0.0) size:CGSizeMake(iw, ih)]) {
        [self rootInitWithChangeBackgound:isChangeBackground];
    }
    return self;
}

-(void)rootInitWithChangeBackgound:(BOOL)isChangeBackground
{
    self.userInteractionEnabled = YES;
    self.anchorPoint = CGPointMake(0, 0);
    self.position = CGPointMake(0, 0);
    self.zPosition = 2000;
    self.dontChangeTopbar = 0;
    self.isPlayCloseAnime = YES;
    [self createLawn];
    [self createJellys];
    if (isChangeBackground == YES) {
        [self moveWindow:nil];
    }
    else {
        self.isPlayCloseAnime = NO;
    }
    ViewController *vc = [ViewController single];
    ClassCenter *cc = [ClassCenter singleton];
    if (cc.sceneNumber == 1) {
        [vc.mapScene.topBar hiddenBackground];
    }
    else if (cc.sceneNumber == 2) {
        [vc.gameScene.topBar hiddenBackground];
    }

}

-(void)createLawn
{
    canvas = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(iw, ih)];
    canvas.anchorPoint = CGPointMake(0, 0);
    canvas.position = CGPointMake(0, 0);
    [self addChild:canvas];
    
    _lawn = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_lawn")[12]];
    _lawn.anchorPoint = CGPointMake(0, 0);
    _lawn.position = cciPhone5Pos(16, -5, 16, -112);
    [canvas addChild:_lawn];
    
    SK_Button *closeButton = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_lawn")[13]];
    closeButton.position = CGPointMake(553-20, 274-74);
    [_lawn addChild:closeButton];
    
    StaticActions *sa = [StaticActions single];
    [closeButton playSound:sa.sound_buttonB];
    [closeButton event:^{
        [self moveWindow:nil];
    }];
    
    SKSpriteNode *title = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_lawn")[11]];
    title.position = cciPhone5Pos(iw/2, ih-160, iw/2, ih-124);
    [title setScale:0.8];
    [canvas addChild:title];
    
    SK_Label *titleLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:58 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
    titleLabel.text = iString(@"bookTitle");
    [title addChild:titleLabel];
}

-(void)moveWindow:(void (^)())block;
{
    if (!self.isPlayCloseAnime) {
        //moveBar
        ViewController *vc = [ViewController single];
        ClassCenter *cc = [ClassCenter singleton];
        if (cc.sceneNumber == 1) {
            if (_dontChangeTopbar == 0) {
                [vc.mapScene.topBar showBackground];
            }
            [vc.mapScene moveBarShow];
            [vc.mapScene.sv.miniMapBackground runAction:[SKAction fadeInWithDuration:0.3]];
        }
        else if (cc.sceneNumber == 2) {
            if (_dontChangeTopbar == 0) {
                [vc.gameScene.topBar showBackground];
            }
        }
        
        if (block) {
            block();
        }
        if (closeBlock) {
            closeBlock();
            closeBlock = nil;
        }
        self.paused = YES;
        [self removeAllChildren];
        [self removeFromParent];
        return;
    }
    
    StaticActions *sa = [StaticActions single];
    if (!_isMiddle) {
        self.paused = NO;
        //移动视图
        canvas.position = CGPointMake(0, -canvas.size.height);
        [canvas runAction:sa.actionSpringUpWindow];
        
        //背景发灰
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, iGrayFloat) colorBlendFactor:1 duration:0.3*1.8];
        [self runAction:color];
        _isMiddle = YES;
    }
    else if (_isMiddle) {
        //移动视图
        [canvas runAction:sa.actionSpringDownWindow];
        
        ViewController *vc = [ViewController single];
        //背景透明
        SKAction *color = [SKAction colorizeWithColor:rgb(0x000000, 0) colorBlendFactor:1 duration:0.3*1.8];
        [self runAction:color completion:^{
            if (block) {
                block();
            }
            if (closeBlock) {
                closeBlock();
                closeBlock = nil;
            }
            self.paused = YES;
            [self removeAllChildren];
            [self removeFromParent];
        }];

        //moveBar
        ClassCenter *cc = [ClassCenter singleton];
        if (cc.sceneNumber == 1) {
            if (_dontChangeTopbar == 0) {
                [vc.mapScene.topBar showBackground];
            }
            [vc.mapScene moveBarShow];
            [vc.mapScene.sv.miniMapBackground runAction:[SKAction fadeInWithDuration:0.3]];
        }
        else if (cc.sceneNumber == 2) {
            if (_dontChangeTopbar == 0) {
                [vc.gameScene.topBar showBackground];
            }
        }
        _isMiddle = NO;
    }
}

-(void)createJellys
{
    if (allJellys) {
        [allJellys removeAllChildren];
        [allJellys removeFromParent];
    }
    allJellys = [[SKNode alloc] init];
    [_lawn addChild:allJellys];
    NSDictionary *jellyData = [[UserCenter dic] objectForKey:@"jellyData"];
    NSMutableArray *haveJellys = [[UserCenter dic] objectForKey:@"haveJellys"];
    NSMutableArray *noHaveJellys = [[UserCenter dic] objectForKey:@"noHaveJellys"];
    for (int idx = 0; idx < haveJellys.count + noHaveJellys.count; idx++) {
        NSDictionary *jellyDic;
        if (idx < haveJellys.count) {
            jellyDic = [jellyData objectForKey:haveJellys[idx]];
        }
        else {
            jellyDic = [jellyData objectForKey:noHaveJellys[idx-haveJellys.count]];
        }
        
        SK_Button *jelly;
        if ([jelly.name isEqualToString:@"iceThin"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[0]];
        }
        else if ([jelly.name isEqualToString:@"iceThick"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[1]];
        }
        else if ([jelly.name isEqualToString:@"iceThorn"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[2]];
        }
        else if ([jelly.name isEqualToString:@"iceMist"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[3]];
        }
        else if ([jelly.name isEqualToString:@"dizzy"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[4]];
        }
        else if ([jelly.name isEqualToString:@"aoeBoom"]) {
            jelly = [SK_Button spriteNodeWithTexture:Atlas(@"ui_book_tempJellyImage")[5]];
        }
        else {
            jelly = [SK_Button spriteNodeWithTexture:Atlas([jellyDic objectForKey:@"atlas"])[0]];
        }
        
        float xx = 140;
        float yy = 108;
        int line = idx / 4;
        int num = idx % 4;
        jelly.position = CGPointMake(88 + num * xx, 804 - line * yy);
        jelly.name = [jellyDic objectForKey:@"myName"];
        jelly.number = idx;
        [jelly setScale:[[jellyDic objectForKey:@"scale"] floatValue]];
        [allJellys addChild:jelly];

        
        // !!!:根据教程添加提示
        if ([[jellyDic objectForKey:@"isGemA"] intValue] == 111 || [[jellyDic objectForKey:@"isGemB"] intValue] == 111) {
            SKSpriteNode *newSkillImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_lawn")[19]];
            newSkillImage.position = CGPointMake(28, 38);
            [jelly addChild:newSkillImage];
            
            if (!pick) {
                pick = [[PickNode alloc] init];
                pick.position = CGPointMake(-20, 20);
                pick.zPosition = 1;
                [jelly addChild:pick];
            }
        }
        
        if ([jelly.name isEqualToString:@"iceThin"] || [jelly.name isEqualToString:@"iceMist"] ||
            [jelly.name isEqualToString:@"iceThorn"] || [jelly.name isEqualToString:@"iceThick"] ||
            [jelly.name isEqualToString:@"aoeBoom"] || [jelly.name isEqualToString:@"dizzy"]) {
            
        }
        else {
            float waitTime = (rand()/(float)RAND_MAX);
            SKAction *wait = [SKAction waitForDuration:waitTime];
            SKAction *anime = [SK_Actions actionAnime:Atlas([jellyDic objectForKey:@"atlas"]) repeat:0];
            [jelly runAction:wait completion:^{
                [jelly runAction:anime];
            }];
        }
        
        int needPrice = [[jellyDic objectForKey:@"price"] intValue];
        if (needPrice > 0) {
            SKTexture *buySpriteTex;
            if ([[jellyDic objectForKey:@"price"] intValue] > 999) {
                buySpriteTex = Atlas(@"ui_book_lawn")[14];
            }
            else {
                buySpriteTex = Atlas(@"ui_book_lawn")[4];
            }
            SKSpriteNode *buySprite = [SKSpriteNode spriteNodeWithTexture:buySpriteTex];
            buySprite.name = @"buy";
            buySprite.position = CGPointMake(0, -38-16);
            [jelly addChild:buySprite];
            NSString *string = [NSString stringWithFormat:@"%d", needPrice];
            SK_Label *label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:24 color:rgb(0xffffff, 1) horizontal:SKLabelHorizontalAlignmentModeLeft];
            
            if (needPrice == 111) {
                label.text = iString(@"free");
            }else {
                label.text = string;
            }
            
            label.position = CGPointMake(-13, 3);
            label.icon = Atlas(@"ui_book_lawn")[8];
            [buySprite addChild:label];
            [buySprite setScale:1/[[jellyDic objectForKey:@"scale"] floatValue]];
        }
        else if (idx >= haveJellys.count) {
            SKSpriteNode *lockImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_book_lawn")[9]];
            lockImage.position = CGPointMake(0, -40);
            [lockImage setScale:0.8];
            [jelly addChild:lockImage];
        }
        
        StaticActions *sa = [StaticActions single];
        [jelly playSound:sa.sound_buttonA];
        [jelly event:^{
            int isHave = idx < haveJellys.count ? 1 : 0;
            if (_bookData) {
                [_bookData removeFromParent];
            }
            _bookData = [[BookData alloc] initWithDic:jellyDic isHave:isHave];
            [canvas addChild:_bookData];
            [self bookDataMoveIn];
            [_bookData closeBlock:^{
                [self bookDataMoveOut];
            }];
        }];
    }
}

-(void)hiddenJellyGoldTip:(NSString *)jellyName
{
    SKSpriteNode *jelly = (SKSpriteNode *)[_lawn childNodeWithName:jellyName];
    [jelly removeAllChildren];
}


-(void)closeBlock:(void (^)())block
{
    closeBlock = block;
}


-(void)bookDataMoveIn
{
    SKAction *moveIn = [SKAction moveToX:-590 duration:0.2];
    moveIn.timingMode = SKActionTimingEaseInEaseOut;
    [canvas runAction:moveIn];
}

-(void)bookDataMoveOut
{
    [self createJellys];
    SKAction *moveOut = [SKAction moveToX:0 duration:0.2];
    moveOut.timingMode = SKActionTimingEaseInEaseOut;
    [canvas runAction:moveOut completion:^{
        [_bookData removeFromParent];
    }];
}





@end
