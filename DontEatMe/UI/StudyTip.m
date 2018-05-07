//
//  StudyTip.m
//  DontEatMe
//
//  Created by ym on 6/11/14.
//  Copyright (c) 2014 ymMac. All rights reserved.
//

#import "StudyTip.h"

@implementation StudyTip
{
    SKSpriteNode *blackMask;
    SKSpriteNode *tip;
    NSArray *talkArray;
    SK_Label *label;
    int labelNumbers;
    int nowLabelLenth;
    int isLoadAllOfOnes;
    void (^myblock)();
    float defSpeed;
}


-(id)initWithTalkArray:(NSArray *)talkArray_ icon:(SKTexture *)icon_ block:(void (^)())block;
{
    if (self = [super initWithColor:[UIColor clearColor] size:CGSizeMake(iw, ih)]) {
        SKSpriteNode *backgournd = [SKSpriteNode spriteNodeWithTexture:Atlas(@"studyTip")[1]];
        backgournd.alpha = 0.8;
        [self addChild:backgournd];
        
        self.userInteractionEnabled = YES;
        myblock = block;
        self.zPosition = 2100;
        self.position = CGPointMake(iw/2, ih/2);
        
        tip = [SK_Button spriteNodeWithTexture:Atlas(@"studyTip")[0]];
        tip.position = CGPointMake(0, 288);
        [self addChild:tip];
        
        if (icon_) {
            SKSpriteNode *iconBackground = [SKSpriteNode spriteNodeWithTexture:Atlas(@"studyTip")[2]];
            iconBackground.position = CGPointMake(-254, -30);
            [tip addChild:iconBackground];
            
            _icon = [SKSpriteNode spriteNodeWithTexture:icon_];
            _icon.position = CGPointMake(-254, 10);
            [tip addChild:_icon];
        }
        
        SKSpriteNode *touchImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"studyTipButton")[0]];
        touchImage.position = CGPointMake(239, -63);
        [tip addChild:touchImage];
        
        SKAction *anime = [SKAction animateWithTextures:Atlas(@"studyTipButton") timePerFrame:0.1 resize:YES restore:NO];
        SKAction *rep = [SKAction repeatActionForever:anime];
        [touchImage runAction:rep];
        
        talkArray = talkArray_;
        int line = iSEnglish ? 18 : 10;
        label = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:line size:37 color:rgb(0xc28bef, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        label.position = CGPointMake(0, -8);
        label.text = @"";
        [tip addChild:label];
        labelNumbers = 0;
        [self reloadText];
        
        ViewController *vc = [ViewController single];
        defSpeed = vc.gameScene.war.speed;
        vc.gameScene.war.speed = 0;
    }
    return self;
}

-(void)reloadText
{
    isLoadAllOfOnes = 0;
    NSString *string = talkArray[labelNumbers];
    int length = (int)string.length;
    nowLabelLenth = 0;
    SKAction *wait = [SKAction waitForDuration:0.16];
    SKAction *reloadBlock = [SKAction runBlock:^{
        nowLabelLenth++;
        if (nowLabelLenth < length) {
            NSString *string = talkArray[labelNumbers];
            label.text = [string substringToIndex:nowLabelLenth];
        }
        else {
            [tip removeAllActions];
            isLoadAllOfOnes = 1;
            label.text = talkArray[labelNumbers];
        }
    }];
    SKAction *sound = [SKAction playSoundFileNamed:@"Sound/keyboard.mp3" waitForCompletion:NO];
    SKAction *seq = [SKAction sequence:@[wait, reloadBlock]];
    SKAction *group = [SKAction group:@[seq, sound]];
    SKAction *rep = [SKAction repeatActionForever:group];
    [tip runAction:rep];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isLoadAllOfOnes == 0) {
        nowLabelLenth += 3;
        return;
    }
    
    labelNumbers++;
    if (labelNumbers <= talkArray.count-1) {
        [tip removeAllActions];
        [self reloadText];
    }
    else {
        [tip removeAllActions];
        if (myblock) myblock();
        ViewController *vc = [ViewController single];
        vc.gameScene.war.speed = defSpeed;
        [self removeAllActions];
        [self removeAllChildren];
        [self removeFromParent];
    }
}

-(void)removeFromParent
{
    talkArray = nil;
    [_icon removeAllActions];
    [_icon removeFromParent];
    [super removeFromParent];
}

@end
