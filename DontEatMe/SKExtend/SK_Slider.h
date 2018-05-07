//
//  SK_Slider.h
//  DontEatMe
//
//  Created by ym on 14/12/25.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SK_Slider : SKSpriteNode

-(id)initWithBackground:(SKTexture *)background slider:(SKTexture *)slider;
-(void)setOffPostion:(CGPoint)offPos onPostion:(CGPoint)onPos;
-(void)didOff:(void (^)())OffBlock;
-(void)didOn:(void (^)())OnBlock;
-(void)on:(BOOL)isAnime;
-(void)off:(BOOL)isAnime;
-(void)setAnimeTime:(float)animeTime;

@property (nonatomic) float animeTime;

@end
