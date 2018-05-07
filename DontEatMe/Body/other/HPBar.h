//
//  HPBar.h
//  DontEatMe
//
//  Created by pringlesfox on 9/11/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HPBar : SKSpriteNode

@property float defaultHP_HPBar;

-(id)initWithName:(NSString *)name;
-(void)changeHPBar:(float)currentHP;


@end
