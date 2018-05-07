//
//  ParticleMagicMatrix.h
//  DontEatMe
//  椭圆使用固定比例
//  Created by 木尔 铁 on 24/12/14.
//  Copyright (c) 2014 ymMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>

@interface ParticleMagicMatrix : SKSpriteNode

@property SKSpriteNode *backGroundImage;
@property NSString *particleImageName;

-(id)init;
-(id)initWithBackGroundIamge:(NSString *)ImageName;
-(void)startup;

@end

