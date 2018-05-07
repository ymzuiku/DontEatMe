//
//  Weapon.h
//  AtlasTesing
//
//  Created by Tie Muer on 12/30/13.
//  Copyright (c) 2013 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Weapon : Body
enum bulletType {
    bullet_banana,
    bullet_laser,
    bullet_boxer,
    bullet_rifle,
    bullet_robot,
    bullet_fur,
    Bullet_ViolentMana,
};

@property int bullet;

@property NSMutableArray *hurtByWeaponArray;

-(void)addBodyToHurtArray:(NSNumber *)bodyNumber;
-(void)attackBody:(Body *)body;

@end
