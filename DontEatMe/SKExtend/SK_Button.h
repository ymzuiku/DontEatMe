//
//  SKEButton.h
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SK_Label.h"

@interface SK_Button : SKSpriteNode

@property (nonatomic) SK_Label *label;
@property (nonatomic) BOOL cannotTouch;
@property (nonatomic) int number;
@property (nonatomic) SKAction *sound;
@property (nonatomic) BOOL isTouchUp;
@property (nonatomic) int isNotBigAnime;
@property (nonatomic) float touchScale;
@property (nonatomic) float touchAddzPosition;
@property (nonatomic) SKNode *touchMoveNode;
@property (nonatomic) SKNode *backgoundImage;

-(void)playSound:(SKAction *)sound;
-(void)event:(void(^)())block;
-(void)longEvent:(void (^)())block;

+(SK_Button *)createButtonWithTexture:(SKTexture *)texture pos:(CGPoint)pos sound:(NSString *)soundStr father:(id)father event:(void (^)())event;
+(SK_Button *)createButtonWithSize:(CGSize)size pos:(CGPoint)pos sound:(NSString *)soundStr father:(id)father event:(void (^)())event;

@end
