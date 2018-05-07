//
//  SK_BackgroundSound.h
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "SKExtendHeader.h"
#import <Foundation/Foundation.h>

@interface SK_BackgroundSound : NSObject

+(SK_BackgroundSound *)singleton;
-(void)createSound:(NSString *)name repeat:(int)number;
-(void)stopSound;
-(void)pauseSound;
-(void)playSound;
-(void)fadeStop;
-(void)fadePlay;

@property (nonatomic, strong) AVAudioPlayer *singletonPlayer;
@property (nonatomic) BOOL playing;
@property (nonatomic) NSString *musicName;

@end
