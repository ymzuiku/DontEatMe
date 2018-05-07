//
//  SK_BackgroundSound.m
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "SK_BackgroundSound.h"

@implementation SK_BackgroundSound


//+(id)singleton
//{
//    static dispatch_once_t pred = 0;
//    __strong static id _sharedObject = nil;
//    dispatch_once(&pred, ^{
//        _sharedObject = [[self alloc] init]; // or some other init method
//    });
//    return _sharedObject;
//}

+(SK_BackgroundSound *)singleton
{
    static SK_BackgroundSound *music = nil;
    if (!music) {
        music = [[SK_BackgroundSound alloc] init];
    }
    return music;
}

-(void)createSound:(NSString *)name repeat:(int)number
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle]resourcePath], name];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSError *error = nil;
    self.musicName = name;
    
    _singletonPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    _singletonPlayer.volume = 0.18;
    _singletonPlayer.numberOfLoops = number;
}

-(void)playSound
{
    self.playing = YES;
    [_singletonPlayer play];
}

-(void)pauseSound
{
    self.playing = NO;
    [_singletonPlayer pause];
}

-(void)stopSound
{
    self.playing = NO;
    [_singletonPlayer stop];
}

-(void)fadePlay
{
    _singletonPlayer.volume = 0.01;
    [_singletonPlayer play];
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(fadePlaySelector:) userInfo:nil repeats:YES];
}

-(void)fadeStop
{
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(fadeStopSelector:) userInfo:nil repeats:YES];
}

-(void)fadePlaySelector:(NSTimer *)theTimer
{
    if (_singletonPlayer.volume >= 0.18) {
        [theTimer invalidate];
    }
    else {
        _singletonPlayer.volume += 0.01;
    }
}

-(void)fadeStopSelector:(NSTimer *)theTimer
{
    if (_singletonPlayer.volume < 0.025) {
        [_singletonPlayer stop];
        [theTimer invalidate];
    }
    else {
        _singletonPlayer.volume -= 0.01;
    }
}


@end
