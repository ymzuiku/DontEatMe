//
//  GamblingBoat.m
//  DontEatMe
//
//  Created by ym on 15/3/3.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "GamblingBoat.h"
#import "ShowAddCookGoldView.h"
#import "Story.h"

@implementation GamblingBoat
{
    SK_Button *plus;
    SK_Button *less;
    SK_Button *buyBig;
    SK_Button *buySmall;
    
    SKSpriteNode *goldsImage;
    SKSpriteNode *goldsLabelBackgroup;
    SKSpriteNode *redBox;
    SKSpriteNode *openSexImage;
    SKSpriteNode *rightRedBoxOpenImage;
    
    SK_Label *goldsLabel;
    SK_Label *goldsShadowLabel;
    
    int useGoldsNumbel;
    int goldImageNumbel;
    
    BOOL isCanTouchScene;
}

-(void)removeFromParent
{
    [plus removeAllChildren];
    [plus removeFromParent];
    plus = nil;
    
    [less removeAllChildren];
    [less removeFromParent];
    less = nil;
    
    [buyBig removeAllChildren];
    [buyBig removeFromParent];
    buyBig = nil;
    
    [goldsImage removeAllChildren];
    [goldsImage removeFromParent];
    goldsImage = nil;
    
    [goldsLabelBackgroup removeAllChildren];
    [goldsLabelBackgroup removeFromParent];
    goldsLabelBackgroup = nil;
    
    [redBox removeAllChildren];
    [redBox removeFromParent];
    redBox = nil;
    
    [openSexImage removeAllChildren];
    [openSexImage removeFromParent];
    openSexImage = nil;
    
    [rightRedBoxOpenImage removeAllChildren];
    [rightRedBoxOpenImage removeFromParent];
    rightRedBoxOpenImage = nil;
    
    
    [self removeAllChildren];
    [super removeFromParent];
}

//快速创建sprite方法
-(SKSpriteNode *)createSpriteWithTexture:(SKTexture *)texture pos:(CGPoint)pos father:(id)father
{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:texture];
    sprite.position = pos;
    [father addChild:sprite];
    return sprite;
}

-(void)createInit
{
    ClassCenter *cc = [ClassCenter singleton];
    cc.isOpenFillScene = 4;
    
    self.zPosition = 9000;
    self.anchorPoint = CGPointMake(0, 0);
    self.position = CGPointMake(0, 0);
    self.backgroup = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_map_ship")[0]];
    float backgroupHight = iPhone5 ? 0 : 65;
    self.backgroup.position = CGPointMake(iw/2, ih/2 - backgroupHight);
    [self addChild:self.backgroup];
    
    isCanTouchScene = YES;
    useGoldsNumbel = 10;
    goldImageNumbel = 4;
    [self newCloseButton];
    [self newAnimeImages];
    [self newButtons];
    [self learn];
}


-(void)learn
{
    int isHomeAFirst = [[[UserCenter dic] objectForKey:@"homeABCDFirstIn"][3] intValue];
    if (isHomeAFirst == 0) {
        ViewController *vc = [ViewController single];
        Story *story = [Story createWithNumber:-1 string:iString(@"homeD")];
        story.zPosition = 9001;
        [vc.mapScene addChild:story];
        [[UserCenter dic] objectForKey:@"homeABCDFirstIn"][3] = @1;
        [UserCenter save];
    }
}

-(void)newAnimeImages
{
    goldsImage = [self createSpriteWithTexture:Atlas(@"ui_map_ship")[goldImageNumbel] pos:CGPointMake(340, ih - 720) father:self];
    goldsLabelBackgroup = [self createSpriteWithTexture:Atlas(@"ui_map_ship")[3] pos:CGPointMake(320+4, ih - 780) father:self];
    rightRedBoxOpenImage = [self createSpriteWithTexture:Atlas(@"ui_map_ship")[9] pos:CGPointMake(525, ih - 244) father:self];
    rightRedBoxOpenImage.hidden = YES;
    redBox = [self createSpriteWithTexture:Atlas(@"ui_map_shipDuAnime")[0] pos:CGPointMake(335, ih - 250) father:self];
    openSexImage = [self createSpriteWithTexture:Atlas(@"ui_map_ship")[10] pos:CGPointMake(350, ih - 253) father:self];
    openSexImage.hidden = YES;
    
    
    goldsShadowLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:40 color:rgb(0x0000, 0.25) horizontal:SKLabelHorizontalAlignmentModeCenter];
    goldsShadowLabel.position = CGPointMake(0, -3);
    goldsShadowLabel.text = [NSString stringWithFormat:@"%d", useGoldsNumbel];
    [goldsLabelBackgroup addChild:goldsShadowLabel];
    
    goldsLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:40 color:[UIColor whiteColor] horizontal:SKLabelHorizontalAlignmentModeCenter];
    goldsLabel.position = CGPointMake(0, 0);
    goldsLabel.text = [NSString stringWithFormat:@"%d", useGoldsNumbel];
    [goldsLabelBackgroup addChild:goldsLabel];
}

-(void)newButtons
{
    less = [SK_Button createButtonWithTexture:Atlas(@"ui_map_ship")[1] pos:CGPointMake(152, ih - 719) sound:@"Sound/ui_goButton_1.mp3" father:self event:^{
        if (isCanTouchScene) {
            if (useGoldsNumbel > 10) {
                useGoldsNumbel -= 10;
                goldImageNumbel --;
                goldsLabel.text = [NSString stringWithFormat:@"%d", useGoldsNumbel];
                goldsShadowLabel.text = [NSString stringWithFormat:@"%d", useGoldsNumbel];
                goldsImage.texture = Atlas(@"ui_map_ship")[goldImageNumbel];
            }
            
            plus.alpha = 1;
            less.alpha = 1;
            if (useGoldsNumbel <= 10) {
                less.alpha = 0.3;
                
            }
            else if (useGoldsNumbel >= 50) {
                plus.alpha = 0.3;
            }
        }
    }];
    less.alpha = 0.3;
    
    plus = [SK_Button createButtonWithTexture:Atlas(@"ui_map_ship")[2] pos:CGPointMake(518, ih - 719) sound:@"Sound/ui_goButton_1.mp3" father:self event:^{
        if (isCanTouchScene) {
            if (useGoldsNumbel < 50) {
                useGoldsNumbel += 10;
                goldImageNumbel ++;
                goldsLabel.text = [NSString stringWithFormat:@"%d", useGoldsNumbel];
                goldsShadowLabel.text = [NSString stringWithFormat:@"%d", useGoldsNumbel];
                goldsImage.texture = Atlas(@"ui_map_ship")[goldImageNumbel];
            }
            
            plus.alpha = 1;
            less.alpha = 1;
            if (useGoldsNumbel <= 10) {
                less.alpha = 0.3;
                
            }
            else if (useGoldsNumbel >= 50) {
                plus.alpha = 0.3;
            }
        }
    }];
    
    buyBig = [SK_Button createButtonWithSize:CGSizeMake(200, 200) pos:CGPointMake(208, ih - 507) sound:@"Sound/ui_goButton_1.mp3" father:self event:^{
        if (isCanTouchScene) {
            int nowGold = [[[UserCenter dic] objectForKey:@"gold"] intValue];
            if (useGoldsNumbel > nowGold) {
                ViewController *vc = [ViewController single];
                [vc.mapScene.topBar tipPickGold];
            }
            else {
                [self gambling:0];
            }
            
        }
    }];
    
    buySmall = [SK_Button createButtonWithSize:CGSizeMake(200, 200) pos:CGPointMake(458, ih - 507) sound:@"Sound/ui_goButton_1.mp3" father:self event:^{
        if (isCanTouchScene) {
            int nowGold = [[[UserCenter dic] objectForKey:@"gold"] intValue];
            if (useGoldsNumbel > nowGold) {
                ViewController *vc = [ViewController single];
                [vc.mapScene.topBar tipPickGold];
            }
            else {
                [self gambling:1];
            }
        }
    }];
}

-(void)gambling:(int)leftOrRight
{
    isCanTouchScene = NO;
    CGPoint pos = leftOrRight == 0 ? buyBig.position : buySmall.position;
    SKAction *move = [SKAction moveTo:pos duration:1];
    SKAction *wait = [SKAction waitForDuration:0.3];
    move.timingMode = SKActionTimingEaseInEaseOut;
    SKAction *seqMove = [SKAction sequence:@[move, wait]];
    [goldsImage runAction:seqMove];
    
    SKAction *wait2 = [SKAction waitForDuration:seqMove.duration];
    SKAction *anime = [SKAction animateWithTextures:Atlas(@"ui_map_shipDuAnime") timePerFrame:0.042 resize:YES restore:NO];
    SKAction *repAnime = [SKAction repeatAction:anime count:3];
    SKAction *seqAnime = [SKAction sequence:@[wait2, repAnime]];
    [redBox runAction:seqAnime];
    
    int randomInt = skRand(0, 99);
    int plusOrLess = (randomInt > 60)?1:-1;
    int randomTexture;
    if (leftOrRight == 0) {
        if (plusOrLess == 1) {
            randomTexture = (int)skRand(10, 12);
        }
        else {
            randomTexture = (int)skRand(13, 15);
        }
        
    }
    else {
        if (plusOrLess == -1) {
            randomTexture = (int)skRand(10, 12);
        }
        else {
            randomTexture = (int)skRand(13, 15);
        }
    }
    
    SKAction *wait3 = [SKAction waitForDuration:seqAnime.duration];
    SKAction *block = [SKAction runBlock:^{
        redBox.texture = Atlas(@"ui_map_ship")[16];
        rightRedBoxOpenImage.hidden = NO;
        openSexImage.texture = Atlas(@"ui_map_ship")[randomTexture];
        openSexImage.hidden = NO;
    }];
    SKAction *seqOpenBox = [SKAction sequence:@[wait3, block]];
    [self runAction:seqOpenBox];
    
    [self runAction:wait3 completion:^{
        ShowAddCookGoldView *addGoldView = [ShowAddCookGoldView createWithIsGold:YES number:useGoldsNumbel*plusOrLess backCall:^{
            [self reloadBegin];
        }];
        addGoldView.position = CGPointMake(iw/2, ih/2);
        [self addChild:addGoldView];
        
        ViewController *vc = [ViewController single];
        if (vc.mapScene.topBar) {
            [vc.mapScene.topBar reloadLabel:nil];
        }
        else if (vc.gameScene.topBar) {
            [vc.gameScene.topBar reloadLabel:nil];
        }
    }];
}

-(void)reloadBegin
{
    isCanTouchScene = YES;
    goldsImage.position = CGPointMake(340, ih - 720);
    redBox.texture = Atlas(@"ui_map_shipDuAnime")[0];
    rightRedBoxOpenImage.hidden = YES;
    openSexImage.hidden = YES;
}



@end
