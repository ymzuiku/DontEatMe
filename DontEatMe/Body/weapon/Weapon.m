//
//  Weapon.m
//  AtlasTesing
//
//  Created by Tie Muer on 12/30/13.
//  Copyright (c) 2013 ym. All rights reserved.
//

#import "Weapon.h"

static int weaponIDNumber = 40000;

@implementation Weapon
{
    BOOL isHaveBoxFrame;
    BOOL isHaveAttackFrame;
}

-(void)myIDNumber
{
    if(weaponIDNumber >= 40000 && weaponIDNumber < 59999) {
        weaponIDNumber += 1;
        self.idNumber = weaponIDNumber;
    }else {
        weaponIDNumber = 40000;
        weaponIDNumber += 1;
        self.idNumber = weaponIDNumber;
    }
}

-(id)init
{
    if (self = [super init]) {
        [self myIDNumber];
        self.hurtByWeaponArray = [[NSMutableArray alloc] init];
        _bullet = 0;
        self.defBoxRect = CGRectMake(-10, -10, 20, 20);
        self.speed = 1.1;
    }
    return self;
}

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        [self myIDNumber];
        self.hurtByWeaponArray = [[NSMutableArray alloc] init];
        _bullet = 0;
        self.defBoxRect = CGRectMake(-10, -10, 20, 20);
        self.speed = 1.1;
    }
    return self;
}

-(void)addBodyToHurtArray:(NSNumber *)bodyNumber
{
    [self.hurtByWeaponArray addObject:bodyNumber];
}

-(void)attackBody:(Body *)body{}

@end
