//
//  Stump.m
//  DontEatMe
//
//  Created by pringlesfox on 9/12/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Stump.h"

@implementation Stump
{
}

-(id)initWithNumber:(int)number
{
    if (self = [super initWithNumber:number]) {
        
        self.name = @"prop";
        self.myName = @"stump";
        self.defBoxRect = CGRectMake(-57, -60, 114, 120);
        self.defaultHP = 500;
        self.nowHP = self.defaultHP;
        self.type = 1;
        self.attack = 200;
        [self addHpBar:CGPointMake(hpPosX, hpPosY+5) name:@"chicken_hp_mini"];
		[self setPropInGrid:2];
        [self stumpStand];
    }
    return self;
}

-(void)propDoThings
{
    
}

-(void)stumpStand
{
    self.texture = AtlasNum(@"ui_scene_obj_stump", 0);
    self.zPosition = (1999-self.position.y);
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    if ((self.nowHP - hurt) < (self.defaultHP*0.66) && self.nowHP > self.defaultHP*0.33) {
        [self stumpBrackA];
    }
    else if (self.nowHP < self.defaultHP*0.33) {
        [self stumpBrackB];
    }
    return [super changeHP:hurt+10 attacker:attacker];
}

-(void)stumpBrackA
{
    self.texture = AtlasNum(@"ui_scene_obj_stump", 1);
}

-(void)stumpBrackB
{
    self.texture = AtlasNum(@"ui_scene_obj_stump", 2);
}

-(void)beColliedBy:(Body *)body
{
    float tempY;
    if (self.beCollied == true) {
        return;
    }
    self.beCollied = true;
    if (body.position.y - self.position.y > 0) {
        tempY = -15;
    }else{
        tempY = 15;
    }
    SKAction *moveByCollied = [SKAction moveByX:0 y:tempY duration:0.2];
    
    SKAction *seqEndBlock = [SKAction runBlock:^{
        [self resetZPostion];
        self.beCollied = false;
        [self checkPropInTheGrid];
    }];
    SKAction *moveByColliedSeq =  [SKAction sequence:@[moveByCollied,seqEndBlock]];
    [self runAction:moveByColliedSeq withKey:@"moveByCollied"];
}

@end
