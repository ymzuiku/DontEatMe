//
//  SKEButton.m
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "SK_Button.h"

@implementation SK_Button
{
    void (^myBlock)();
    void (^longMyBlock)();
    float defScale;
    SKNode *longActionNode;
    NSString *doBlock;
    int touchMoveCounter;
}

-(void)removeFromParent
{
    myBlock = nil;
    if (_label) {
        [_label removeFromParent];
    }
    [self removeAllActions];
    [super removeFromParent];
}

+(SK_Button *)createButtonWithTexture:(SKTexture *)texture pos:(CGPoint)pos sound:(NSString *)soundStr father:(id)father event:(void (^)())event;
{
    SK_Button *button = [SK_Button spriteNodeWithTexture:texture];
    button.position = pos;
    [father addChild:button];
    [button event:event];
    [button playSound:[SKAction playSoundFileNamed:soundStr waitForCompletion:NO]];
    return button;
}

+(SK_Button *)createButtonWithSize:(CGSize)size pos:(CGPoint)pos sound:(NSString *)soundStr father:(id)father event:(void (^)())event;
{
    SK_Button *button = [SK_Button spriteNodeWithColor:[UIColor clearColor] size:size];
    button.position = pos;
    [father addChild:button];
    [button event:event];
    [button playSound:[SKAction playSoundFileNamed:soundStr waitForCompletion:NO]];
    return button;
}

-(id)initWithColor:(UIColor *)color size:(CGSize)size
{
    if (self = [super initWithColor:color size:size]) {
        [self createInit];
    }
    return self;
}

-(id)initWithImageNamed:(NSString *)name
{
    if (self = [super initWithImageNamed:name]) {
        [self createInit];
    }
    return self;
}

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        [self createInit];
    }
    return self;
}

-(id)init
{
    if (self = [super init]) {
        [self createInit];
    }
    return self;
}


-(void)createInit
{
    self.touchScale = 1.1;
    self.touchAddzPosition = 50;
    self.userInteractionEnabled = YES;
    self.isTouchUp = YES;
    float value = self.yScale;
    float wValue = self.size.width/self.size.height;
    SKSpriteNode *touchNode = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(80/value*wValue, 80/value)];
    touchNode.alpha = 0.003;
    [self addChild:touchNode];
}

-(void)event:(void(^)())block
{
    myBlock = block;
}

-(void)longEvent:(void (^)())block
{
    if (!longActionNode) {
        longActionNode = [SKNode node];
        [self addChild:longActionNode];
    }
    longMyBlock = block;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.cannotTouch) return;
    if (self.isTouchUp) self.zPosition += self.touchAddzPosition;
    defScale = self.yScale;
    touchMoveCounter = 0;
    if (self.isNotBigAnime == 0) {
        [self setScale:defScale*self.touchScale];
        if (self.backgoundImage) {
            [self.backgoundImage setScale:defScale * self.touchScale];
        }
    }
    doBlock = @"myBlock";
    if (longActionNode) {
        [longActionNode removeAllActions];
        SKAction *wait = [SKAction waitForDuration:0.35];
        SKAction *block = [SKAction runBlock:^{
            if (longMyBlock) {
                longMyBlock();
            }
            doBlock = @"longMyBlock";
        }];
        SKAction *seq = [SKAction sequence:@[wait, block]];
        [longActionNode runAction:seq];
    }
    
    if (self.touchMoveNode) {
        [self.touchMoveNode touchesBegan:touches withEvent:event];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchMoveCounter++;
    if (self.touchMoveNode) {
        [self.touchMoveNode touchesMoved:touches withEvent:event];
    }
    if (touchMoveCounter > 7) {
        doBlock = @"move";
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.cannotTouch) return;
    self.userInteractionEnabled = NO;
    if (self.isTouchUp) self.zPosition -= self.touchAddzPosition;
    if (_sound && ![doBlock isEqualToString:@"move"]) [self runAction:_sound];
    SKAction *action = [SKAction scaleTo:defScale duration:0.1];
    action.timingMode = SKActionTimingEaseOut;
    [self runAction:action completion:^{
        if (self.hidden == NO || self.alpha > 0.1) {
            if (myBlock != nil && [doBlock isEqualToString:@"myBlock"]) myBlock();
            SKAction *wait = [SKAction waitForDuration:0.25];
            [self runAction:wait completion:^{
                self.userInteractionEnabled = YES;
            }];
        }
    }];
    
    if (self.backgoundImage) {
        [self.backgoundImage runAction:action];
    }
    
    if (longActionNode) {
        [longActionNode removeAllActions];
    }
    
    if (self.touchMoveNode) {
        [self.touchMoveNode touchesEnded:touches withEvent:event];
    }
}

-(void)setLabel:(SK_Label *)label
{
    _label = label;
    _label.position = label.position;
    [self addChild:_label];
}

-(void)playSound:(SKAction *)sound;
{
    _sound = sound;
}

-(void)runEvent
{
    if (myBlock) {
        myBlock();
    }
}

@end
