//
//  DateCenter.h
//  SpriteKitTest
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassCenter : NSObject
+(id)singleton;

@property (strong, nonatomic) NSMutableDictionary *classJellyNames;
@property (nonatomic) int isWinObject;
@property (nonatomic) int groupManas;
@property (nonatomic) int lastMapNumber;
@property (nonatomic) int nowMapNumber;
@property (nonatomic) float speed;
@property (nonatomic) int sceneNumber;
@property (nonatomic) BOOL isTips;
@property (nonatomic) int isOpenFillScene;
@property (nonatomic) CGPoint lastObjPosition;
@property (nonatomic) BOOL isCanPlayMusic;
@property (nonatomic) int startNumber;

@end
