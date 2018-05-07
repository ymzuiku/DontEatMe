//
//  Button.m
//  DontEatMe
//
//  Created by pringlesfox on 8/18/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//

#import "Button.h"
#import "Grid.h"
#import "GridArray.h"

static SKAction *buttonDown;

@implementation Button
{
    int buttonDown;
    NSArray *gridArray;
}

-(id)initWithNumber:(int)number
{
    if (self = [super initWithNumber:number]) {
        self.gridNamber = number;
        self.name = @"prop";
        self.myName = @"boomButton";
        self.texture = AtlasNum(@"ui_scene_obj_button", 0);
        self.boxRect = CGRectMake(-57,-48, 114, 97);
        self.defaultHP = 300;
        self.type = 4;
        buttonDown = 0;
        gridArray = [GridArray getGridArray];
		[self setPropInGrid:3];
    }
    return self;
}

-(void)beColliedBy:(Body *)body
{
    [self buttonDown];
}



-(void)buttonDown
{
    if(buttonDown == 0){
        buttonDown = 1;
        SKAction *wait = [SKAction waitForDuration:10];  //炸弹爆炸间隔
        SKAction *textureButtonDown = [SKAction setTexture:AtlasNum(@"ui_scene_obj_button", 1)];
        SKAction *bombBlock = [SKAction runBlock:^{
            [self bombBlow];
        }];
        SKAction *buttonUp = [SKAction runBlock:^{
            buttonDown = 0;
        }];
        SKAction *textureButtonUp = [SKAction setTexture:AtlasNum(@"ui_scene_obj_button", 0)];
        SKAction *downAction = [SKAction sequence:@[textureButtonDown,bombBlock,wait,textureButtonUp,buttonUp]];
        [self runAction:downAction withKey:@"buttonDown"];
    }
}

-(void)bombBlow
{
    for (Grid *grid in gridArray) {
        if ([grid.propInGrid.myName isEqualToString:@"buttonBomb"]) {
            [grid.propInGrid propDoThings];
            [grid.nodeInGrid changeHP:3000 attacker:self]; //扣除格子上的单位的血
        }
    }
}

-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    return NO;
}

//-(void)setPropInGrid
//{
//    gridArray = [GridArray getGridArray];
//    Grid *grid = gridArray[self.gridNamber];
//    self.position = grid.position;
//    grid.propInGrid = self;
//    grid.hasNode = 3;
//    [gridArray enumerateObjectsUsingBlock:^(Grid *obj, NSUInteger idx, BOOL *stop) {
//        CGRect posRect = CGRectMake(self.position.x, self.position.y, 1, 1);
//        
//        if (CGRectIntersectsRect(obj.gridRect, posRect)) {
//            self.position = obj.position;
//            self.gridNamber = idx;
//            obj.propInGrid = self;
//        }
//    }];
//} //*/

@end
