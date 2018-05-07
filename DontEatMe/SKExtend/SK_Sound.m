//
//  SK_Audio.m
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "SK_Sound.h"

@implementation SK_Sound
{
    BOOL isPauseing;
}

+(id)createNewSound:(NSString *)name repeat:(int)number
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle]resourcePath], name];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSError *error = nil;
    
    return [[SK_Sound alloc] initWithContentsOfURL:fileURL error:&error repeat:number];
}

-(id)initWithContentsOfURL:(NSURL *)url error:(NSError *__autoreleasing *)outError repeat:(int)number
{
    if (self = [super initWithContentsOfURL:url error:outError]) {
        self.numberOfLoops = number;
        self.volume = 0.2;
    }
    return self;
}

-(void)pause
{
    if (self.playing) {
        isPauseing = YES;
        [super pause];
    }
}

-(void)goon
{
    if (isPauseing == YES) {
        [self play];
    }
}

@end
