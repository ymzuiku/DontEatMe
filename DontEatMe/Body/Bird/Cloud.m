//
//  Cloud.m
//  DontEatMe
//
//  Created by pringlesfox on 8/20/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Cloud.h"

@implementation Cloud

-(id)initWithNumber:(int)number cloudType:(int)cloudType
{
    if (self = [super initWithNumber:number]) {
        self.userInteractionEnabled = NO;
        self.texture = AtlasNum(@"ui_scene_anime_cloud", cloudType);
        self.size = self.texture.size;
        self.zPosition = 1999-5;   //1999.1-self.position.y/2000;
        self.position = CGPointMake(0-self.size.width/2, self.position.y);
        [self fly:[self flyPath]];
        self.alpha = 0.95;
    }
    return self;
}


-(SKAction *)flyPath
{
    SKAction *move = [SKAction moveByX:1000 y:0 duration:33];
    move.timingMode = SKActionTimingEaseInEaseOut;
    return move;
}

-(void)fly:(SKAction *)flyPath
{
    [self runAction:flyPath completion:^{
        [self removeFromParent];
    }];
}

@end
