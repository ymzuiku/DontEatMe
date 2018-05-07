//
//  SK_Slider.m
//  DontEatMe
//
//  Created by ym on 14/12/25.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "SK_Slider.h"

@implementation SK_Slider
{
    CGPoint _offPos;
    CGPoint _onPos;
    SK_Button *_slider;
    int _isOpen;
    void (^_OffBlock)();
    void (^_OnBlock)();
}
-(id)initWithBackground:(SKTexture *)background slider:(SKTexture *)slider
{
    if (self = [super initWithTexture:background]) {
        _slider = [SK_Button spriteNodeWithTexture:slider];
        [self addChild:_slider];
        _animeTime = 0.3;
        [_slider event:^{
            if (_isOpen == 0) {
                [self on:YES];
            }
            else if (_isOpen == 1) {
                [self off:YES];
            }
        }];
    }
    return self;
}

-(void)setAnimeTime:(float)animeTime
{
    [_slider event:^{
        if (_isOpen == 0) {
            [self on:_animeTime];
        }
        else if (_isOpen == 1) {
            [self off:_animeTime];
        }
    }];
    _animeTime = animeTime;
}

-(void)setOffPostion:(CGPoint)offPos onPostion:(CGPoint)onPos
{
    _offPos = offPos;
    _onPos = onPos;
    _slider.position = offPos;
}

-(void)didOff:(void (^)())OffBlock
{
    _OffBlock = OffBlock;
}

-(void)didOn:(void (^)())OnBlock
{
    _OnBlock = OnBlock;
}

-(void)on:(BOOL)isAnime
{
    if (isAnime) {
        SKAction *move = [SKAction moveTo:_onPos duration:_animeTime];
        move.timingMode = SKActionTimingEaseInEaseOut;
        _isOpen = 2;
        [_slider runAction:move completion:^{
            _isOpen = 1;
        }];
    }
    else {
        _slider.position = _onPos;
        _isOpen = 1;
    }

    if (_OnBlock) {
        _OnBlock();
    }
}

-(void)off:(BOOL)isAnime
{
    if (isAnime > 0) {
        SKAction *move = [SKAction moveTo:_offPos duration:_animeTime];
        move.timingMode = SKActionTimingEaseInEaseOut;
        _isOpen = 2;
        [_slider runAction:move completion:^{
            _isOpen = 0;
        }];
    }
    else {
        _slider.position = _onPos;
        _isOpen = 0;
    }
    if (_OffBlock) {
        _OffBlock();
    }
}

@end
