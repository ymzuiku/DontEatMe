//
//  Mauler.h
//  AtlasTesing
//
//  Created by Tie Muer on 12/31/13.
//  Copyright (c) 2013 ym. All rights reserved.
//

#import "Weapon.h"

@interface Mauler : Weapon
{
  
}

@property CGRect bulletRect;
@property int damage;

- (id)initWithPosition:(CGPoint)jellyPosition  zPosition:(float)zPos;
- (int)attack:(CGRect)pirateCollinRect;
- (void)animationMove;
- (void)animationBlowUp;

@end

