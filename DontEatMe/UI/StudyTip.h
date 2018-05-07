//
//  StudyTip.h
//  DontEatMe
//
//  Created by ym on 6/11/14.
//  Copyright (c) 2014 ymMac. All rights reserved.
//

#import "SK_Button.h"

@interface StudyTip : SKSpriteNode

-(id)initWithTalkArray:(NSArray *)talkArray_ icon:(SKTexture *)icon_ block:(void (^)())block;

@property (nonatomic) SKSpriteNode *icon;

@end
