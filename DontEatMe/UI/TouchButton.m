//
//  TouchButton.m
//  DontEatMe
//
//  Created by ym on 14/7/7.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "TouchButton.h"

@implementation TouchButton
{
    SKSpriteNode *background;
    SKSpriteNode *labelBackground;
    SK_Label *manaLabel;
    SK_Label *eggLabel;
    void (^myBlock)();
    float defScale;
    AVAudioPlayer *player;
}

@synthesize mana = _mana, canCreateJelly = _canCreateJelly;

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithColor:rgb(0xffffff, 0) size:CGSizeMake(110, 110)]) {
        _mana = 0;
        _canCreateJelly = YES;
        _isTimeOver = YES;
        self.userInteractionEnabled = YES;
        
        background = [SKSpriteNode spriteNodeWithTexture:texture];
        background.position = CGPointMake(0, 0);
        [self addChild:background];
        
        labelBackground = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_pick", 34)];
        labelBackground.position = CGPointMake(0, -48);
        [self addChild:labelBackground];
        
        manaLabel = [SK_Label createLabelWithFont:font_ChalkboardSE_Bold line:0 size:28 color:rgb(0x9f9fff, 1) horizontal:SKLabelHorizontalAlignmentModeCenter];
        manaLabel.text = [NSString stringWithFormat:@"%d", _mana];
        manaLabel.position = CGPointMake(2, 0);
        [labelBackground addChild:manaLabel];
    }
    return self;
} 

-(void)setCanCreateJelly:(BOOL)canCreateJelly
{
    _canCreateJelly = canCreateJelly;
    
    if (_canCreateJelly == YES) {
        SKAction *action = [SKAction colorizeWithColor:rgb(0x0042ff, 1) colorBlendFactor:0 duration:0.15];
        [background runAction:action];
    }else {
        SKAction *action = [SKAction colorizeWithColor:rgb(0x3a3704, 1) colorBlendFactor:0.36 duration:0.15];
        [background runAction:action];
    }
}

-(void)addGemA:(BOOL)isGemA gemB:(BOOL)isGemB;
{
    int number = 0;
    if (isGemA && !isGemB) {
        number = 1;
    }
    if (!isGemA && isGemB) {
        number = 2;
    }
    if (isGemA && isGemB) {
        number = 3;
    }
    SKSpriteNode *gemImage = [SKSpriteNode spriteNodeWithTexture:Atlas(@"ui_games_touchLayerLight")[number]];
    gemImage.position = CGPointMake(50, -2);
    [self addChild:gemImage];
}


-(void)setMana:(int)mana
{
    _mana = mana;
    manaLabel.text = [NSString stringWithFormat:@"%d", _mana];
}


-(void)event:(void (^)())block
{
    myBlock = block;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.zPosition += 100;
    defScale = 1;
    [self setScale:defScale*1.35];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.zPosition -= 100;
    BOOL isInTheSelf = NO;
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (CGRectIntersectsRect(CGRectMake(location.x-1, location.y-1, 2, 2), CGRectMake(-self.size.width/2, -self.size.height/2, self.size.width, self.size.height))) {
            isInTheSelf = YES;
            if (player) [player play];
            self.userInteractionEnabled = NO;
        }
    }
    
    SKAction *action = [SKAction scaleTo:defScale duration:0.1];
    action.timingMode = SKActionTimingEaseOut;
    [self runAction:action completion:^{
        if ((self.hidden == NO || self.alpha > 0.1) && isInTheSelf == YES) {
            
            if (myBlock != nil && _canCreateJelly == YES && _isTimeOver) {
                ViewController *vc = [ViewController single];
                [vc.gameScene changeMana:-self.mana];
                myBlock();
            }
            SKAction *wait = [SKAction waitForDuration:0.25];
            [self runAction:wait completion:^{
                self.userInteractionEnabled = YES;
            }];
        }
    }];
}


-(void)playSound:(NSString *)name
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle]resourcePath], name];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSError *error = nil;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    player.volume = 0.35;
    
}

@end
