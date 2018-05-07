//
//  SKHeader.h
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//  (iPad1 ? 320 : 640)

#import <SpriteKit/SpriteKit.h>

#import "SK_Button.h"
#import "SK_ScrollView.h"
#import "SK_Map.h"
#import "SK_Label.h"
#import "SK_Actions.h"
#import "SK_Sound.h"
#import "SK_BackgroundSound.h"
#import "SK_PSD.h"
#import "SK_Slider.h"
#import "SK_Date.h"

#define iHeight     [[UIScreen mainScreen] currentMode].size.height
#define iWidth      [[UIScreen mainScreen] currentMode].size.width
#define iPhone5     ((iHeight == 1136 || iHeight == 1334 || iHeight == 1920)? YES : NO)
#define iPad     (iHeight == 2048 || iHeight == 1024 ? YES : NO)
#define is500m   (iHeight == 480 || iHeight == 960 || iHeight == 768 || iHeight == 1024 ? YES : NO)
#define rgb(c,a)        [UIColor colorWithRed:((c>>16)&0xFF)/256.0  green:((c>>8)&0xFF)/256.0   blue:((c)&0xFF)/256.0   alpha:a]

#define iString(string)    NSLocalizedString(string, nil)
#define iPI(du)      (M_PI*(-du)/180.0)
#define iw  640
#define ih  (iPhone5 ? 1136 : 960)
#define cciPhone5Pos(iPhone5x, iPhone5y, iPhone4x, iPhone4y)   (iPhone5 ? CGPointMake(iPhone5x, iPhone5y) : CGPointMake(iPhone4x, iPhone4y))
#define cciPhone5AutoPos(iPhone5x, iPhone5y)    (iPhone5 ? CGPointMake(iPhone5x, iPhone5y) : CGPointMake(iPhone5x, iPhone5y-176))
#define oneKey  0.042
#define isDebug  0
#define iGrayFloat  0.35
#define iSpeed      1.35

#define iNSLogFile  NSLog(@"%@", [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:nil]);

#define iSEnglish   ([iString(@"language") isEqualToString:@"Base"]?YES:NO)
#define iSChinese   ([iString(@"language") isEqualToString:@"Chinese"]?YES:NO)
#define umAppKey    @"558276e067e58e1837001052"

/* font */
#define font_Arial                  @"Arial"
#define font_Marker_Felt            @"Marker Felt"
#define font_Helvetica              @"Helvetica"
#define font_Helvetica_Bold         @"Helvetica-Bold"
#define font_Helvetica_Light        @"Helvetica-Light"
#define font_HelveticaNeue_UltraLightltalic @"HelveticaNeue-UltraLightltalic" //超细字体
#define font_AvenirNext_Heavy       @"AvenirNext-Heavy"
#define font_AvenirNext_Heavyltalic @"AvenirNext-Heavyltalic"
#define font_GillSans               @"GillSans"
#define font_GillSans_Light         @"GillSans-Light"
#define font_GillSans_Bold          @"GillSans-Bold"
#define font_ChalkboardSE_Bold      @"ChalkboardSE-Bold"
#define font_PartyLetPlain          @"PartyLetPlain"
#define font_Papyrus_Condensed      @"Papyrus-Condensed"
#define font_Papyrus                @"Papyrus"
#define font_SavoyeLetPlain         @"SavoyeletPlain"
#define font_Noteworthy_Light       @"Noteworthy-Light"
#define font_Noteworthy_Bold        @"Noteworthy-Bold"
#define font_Zapfino                @"Zapfino"     //艺术连笔字体

/* music */
#define music_welcome   @""
#define music_home      @"Sound/music/199_full_it-s-your-birthday-4_0140.mp3"
#define music_map       @"Sound/music/199_full_it-s-your-birthday-4_0140.mp3"
#define music_land1     @"Sound/music/177_full_kind-of-a-funny-tale_0205.mp3"
#define music_land2     @"Sound/music/199_full_feeling-peachy_0133.mp3"
#define music_land3     @"Sound/music/177_full_kind-of-a-funny-tale_0205.mp3"
#define music_land4     @"Sound/music/199_full_feeling-peachy_0133.mp3"
#define music_land5     @"Sound/music/177_full_kind-of-a-funny-tale_0205.mp3"
#define music_land6     @"Sound/music/199_full_feeling-peachy_0133.mp3"
#define music_land7     @"Sound/music/177_full_kind-of-a-funny-tale_0205.mp3"
#define music_kuang     @"Sound/music/177_full_kind-of-a-funny-tale_0205.mp3"
#define music_bigChicken    @"Sound/music/199_full_surf-guitar-madness-12_0124.mp3"
#define music_win       @""
#define music_lost      @""

/* grid postion */
#define iGrid_0 CGPointMake(50, 50);

//#define skRand(low, high)   ((arc4random()/0x100000000) * ((high+1) - low) + low)

static inline CGFloat skRandTemp() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    CGFloat back = skRandTemp() * ((high+1) - low) + low;
    if (back == high+1) {
        back = high;
    }
    return back;
}