//
//  Ck.h
//  DontEatMe
//
//  Created by ym on 14-7-23.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define ck(line, type)  @"fdsafdasf";
#define ck(line_, type_, level_, down_)  [ChickenInClass createWithLine:line_ type:type_ level:level_ skill:@"0" down:down_]

//chicken
#define c_beer          @"beer"
#define c_bomb          @"bomb"
#define c_fat           @"fat"
#define c_fire          @"fire"
#define c_fish          @"fish"
#define c_fur           @"fur"
#define c_iron          @"ironBasin"
#define c_machete       @"machete"
#define c_maid          @"maid"
#define c_normal        @"normal"
#define c_onion         @"onion"
#define c_rifle         @"rifle"
#define c_robot         @"robot"
#define c_saw           @"saw"
#define c_snail         @"snail"
#define c_spoon         @"spoon"
#define c_weed          @"weed"
#define c_wooden        @"woodenBasin"
#define c_yoda          @"yoda"
#define c_fireMagic     @"fireMagic"
#define c_flashMagic    @"flashMagic"
#define c_mini          @"mini"
#define c_smart         @"smart"
#define c_bore          @"bore"
#define c_shadow        @"shadow"
#define c_miniFly       @"miniFly"
#define c_sleep         @"sleep"


@interface ChickenInClass : NSObject

@property int line;
@property int level;
@property NSString *type;
@property NSString *skill;
@property NSString *down;


+(id)createWithLine:(int)line_ type:(NSString *)type_ level:(int)level_ skill:(NSString *)skill_ down:(NSString *)down_;
-(id)initWithLine:(int)line_ type:(NSString *)type_ level:(int)level_ skill:(NSString *)skill_ down:(NSString *)down_;


@end
