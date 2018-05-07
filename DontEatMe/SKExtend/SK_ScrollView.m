//
//  SKEScrollView.m
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "SK_ScrollView.h"


//----------------------------------------- subView -----------------------------------------//
@interface SK_ScrollSubView : SKSpriteNode

-(void)didMove:(void (^)())block;

@end

@implementation SK_ScrollSubView
{
    void (^myBlock)();
}


-(void)didMove:(void (^)())block
{
    myBlock = block;
}

-(void)setPosition:(CGPoint)position
{
    if (myBlock) myBlock();
    [super setPosition:position];
}

@end

//----------------------------------------- SK_ScrollView -----------------------------------------//

@implementation SK_ScrollView
{
    SK_ScrollSubView *map;
    CGPoint touchBeginLocation;
    CGPoint touchMoveLocation;
    CGPoint touchEndLocation;
    BOOL isTouching;
    
    SKSpriteNode *miniMap;
    SKSpriteNode *miniPhone;
    void (^scrollCallBack)();
}

-(void)removeFromParent
{
    [map removeAllActions];
    [map removeAllChildren];
    [map removeFromParent];
    [self removeAllChildren];
    [super removeFromParent];
}

+(id)createScrollViewWithSize:(CGSize)size
{
    return [[SK_ScrollView alloc] initWithSize:size];
}

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithColor:[UIColor clearColor] size:size]) {
        self.size = size;
        self.canTouch = YES;
        self.userInteractionEnabled = YES;
        self.anchorPoint = CGPointMake(0, 0);
        self.position = CGPointMake(0, 0);
        map = [SK_ScrollSubView spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(1000, 1000)];
        map.anchorPoint = CGPointMake(0, 0);
        map.position = CGPointMake(0, 0);
        [self addChild:map];
    }
    return self;
}

-(void)jumpTo:(CGPoint)point
{
    map.position = CGPointMake(-point.x+self.size.width/2, -point.y+self.size.height/2);
    miniPhone.position = CGPointMake(-map.position.x*0.045-16, -map.position.y*0.045-18);
}

-(void)setScrollNodePosition:(CGPoint)pos
{
    map.position = pos;
}

-(void)moveTo:(CGPoint)point
{
    float moveX = map.position.x - point.x;
    float moveY = map.position.y - point.y;
    float moveC = sqrt(moveX*moveX + moveY*moveY);
    float time = moveC/300;
    if (time < 0.45) {
        time = 0.45;
    }
    else if (time > 2.5) {
        time = 2.5;
    }
    SKAction *move = [SKAction moveTo:CGPointMake(-point.x+self.size.width/2, -point.y+self.size.height/2) duration:time];
    move.timingMode = SKActionTimingEaseInEaseOut;
    [map runAction:move];
}

-(void)addScrollNode:(SKSpriteNode *)node
{
    node.anchorPoint = CGPointMake(0, 0);
    node.position = CGPointMake(0, 0);
    map.size = CGSizeMake(node.size.width, node.size.height);
    [map addChild:node];
}

-(void)showRadar:(SKTexture *)texture
{
    _miniMapBackground = [SKSpriteNode spriteNodeWithTexture:texture];
    _miniMapBackground.position = CGPointMake(0, 0);
    _miniMapBackground.anchorPoint = CGPointMake(0, 0);
    [self addChild:_miniMapBackground];
    
    if (!miniMap) {
        miniMap = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(map.size.width*0.045, map.size.height*0.045)];
        miniMap.anchorPoint = CGPointMake(0, 0);
        miniMap.position = CGPointMake(208, 10);
        [_miniMapBackground addChild:miniMap];
    }
    if (!miniPhone) {
        miniPhone = [SKSpriteNode spriteNodeWithImageNamed:@"miniPhone.png"];
        miniPhone.anchorPoint = CGPointMake(0, 0);
        miniPhone.position = CGPointMake(-map.position.x*0.045-16, -map.position.y*0.045-18); //CGPointMake(-map.position.x*0.045-10, -map.position.y*0.045-8);
        [miniMap addChild:miniPhone];
    }
    
    [map didMove:^{
        miniPhone.position = CGPointMake(-map.position.x*0.045-16, -map.position.y*0.045-18);
    }];
}

-(void)scrollCallBack:(void (^)())callBack
{
    scrollCallBack = callBack;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_canTouch == NO) {
        return;
    }
    [map removeAllActions];
    int fingers = (int)touches.count;
    if (fingers == 1 && isTouching == NO) {
        isTouching = YES;
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            touchMoveLocation = location;
            break;
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_canTouch == NO) {
        return;
    }
    
    int fingers = (int)touches.count;
    if (fingers == 1 && isTouching == YES) {
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            CGPoint nowLocation = CGPointMake((location.x - touchMoveLocation.x)*1.3, (location.y - touchMoveLocation.y)*1.3);
            
            float tempX;
            float tempY;
            if (_bouncesX) {
                tempX = map.position.x;
            }
            else {
                tempX = map.position.x + nowLocation.x;
                if (tempX < (self.size.width - map.size.width) || tempX > 0) {
                    tempX = map.position.x + nowLocation.x/2.5;
                }
            }
            
            if (_bouncesY) {
                tempY = map.position.y;
            }
            else {
                tempY = map.position.y + nowLocation.y;
                if (tempY < (self.size.height - map.size.height) || tempY > 0) {
                    tempY = map.position.y + nowLocation.y/2.5;
                }
            }
            map.position = CGPointMake(tempX, tempY);
            touchMoveLocation = location;
            self.scrollViewX = map.position.x;
            self.scrollViewY = ih- (map.size.height + map.position.y);
            
            //调用回调block
            if (scrollCallBack) scrollCallBack();
            break;
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_canTouch == NO) {
        return;
    }
    
    isTouching = NO;
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        touchEndLocation = location;
        [self moveBack:map size:self.size];
        break;
    }
}

-(void)moveBack:(SKSpriteNode *)sprite size:(CGSize)theSize
{
    float tempL = sprite.position.x;
    float tempT = theSize.height- (sprite.size.height + sprite.position.y);
    float tempR = theSize.width- (sprite.size.width + sprite.position.x);
    float tempD = sprite.position.y;
    float outLeft = (tempL > 0)? tempL : 0;
    float outTop = (tempT > 0)? tempT : 0;
    float outRight = (tempR > 0) ? tempR : 0;
    float outDown = (tempD > 0) ? tempD : 0;
    
    if (outLeft > 0 && outTop <= 0 && outDown <= 0) {
        [self moveWithSprite:map X:-outLeft Y:0];
    }
    else if (outTop > 0 && outLeft <= 0 && outRight <= 0 ) {
        [self moveWithSprite:map X:0 Y:outTop];
    }
    else if (outRight > 0 && outTop <= 0 && outDown <= 0) {
        [self moveWithSprite:map X:outRight Y:0];
    }
    else if (outDown > 0 && outLeft <= 0 && outRight <= 0) {
        [self moveWithSprite:map X:0 Y:-outDown];
    }
    else if (outLeft > 0 && outTop > 0) {
        [self moveWithSprite:map X:-outLeft Y:outTop];
    }
    else if (outLeft > 0 && outDown > 0) {
        [self moveWithSprite:map X:-outLeft Y:-outDown];
    }
    else if (outTop > 0 && outRight > 0) {
        [self moveWithSprite:map X:outRight Y:outTop];
    }
    else if (outDown > 0 && outRight > 0) {
        [self moveWithSprite:map X:outRight Y:-outDown];
    }
}

-(void)moveWithSprite:(SKSpriteNode *)sprite X:(float)x Y:(float)y
{
    SKAction *move = [SKAction moveByX:x y:y duration:0.4];
    move.timingMode = SKActionTimingEaseInEaseOut;
    [sprite runAction:move completion:^{
        self.scrollViewX = map.position.x;
        self.scrollViewY = ih- (map.size.height + map.position.y);
    }];
    miniPhone.position = CGPointMake(-(map.position.x+x)*0.045-10, -(map.position.y+y)*0.045-8);
}

@end





