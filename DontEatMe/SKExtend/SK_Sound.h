//
//  SK_Audio.h
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface SK_Sound : AVAudioPlayer

+(id)createNewSound:(NSString *)name repeat:(int)number;
-(void)goon;

@end
