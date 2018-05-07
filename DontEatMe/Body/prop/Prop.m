//
//  Jelly.m
//  AtlasTesing
//
//  Created by pringlesfox on 3/30/14.
//  Copyright (c) 2014 ym. All rights reserved.
//

#import "Prop.h"
#import "Grid.h"

@implementation Prop
{
    NSMutableArray *gridArray;
    int isColliedMoveJelly;                                                                     //prop移动锁;
    int isColliedMoveChicken;
}

-(id)init
{
    if (self = [super init]) {
        self.gridNamber = 0;
        self.name = @"prop";
        self.defBoxRect = CGRectMake(-30, -50, 60, 45);
        gridArray = [GridArray getGridArray];
        Grid *grid = gridArray[self.gridNamber];
        self.position = CGPointMake(grid.position.x, grid.position.y-60);
    }
    return  self;
}

-(id)initWithNumber:(int)number
{
    if (self = [super initWithTexture:AtlasNum(@"ui_scene_obj_stump", 2)]) {
        self.gridNamber = number;
        self.name = @"prop";
        self.defBoxRect = CGRectMake(-30, -50, 60, 45);
        gridArray = [GridArray getGridArray];
        Grid *grid = gridArray[self.gridNamber];
        self.position = CGPointMake(grid.position.x, grid.position.y-60);
    }
    return  self;
}

#pragma mark - propCollid
-(void)propMove:(int)moveCount velocity:(Jelly *)propVelocity                                               //##f
{
    if (isColliedMoveJelly == 1) {
        return;
    }
    
    isColliedMoveJelly = 1;
    [self removeAllActions];
    SKAction *propMove;
    SKAction *bodyMove = [SKAction moveByX:0 y:-8 duration:(47/2-6)*oneKey];
    if (moveCount != 0) {
        propMove = [SKAction repeatAction:bodyMove count:moveCount];
    }else{
        propMove = [SKAction repeatActionForever:bodyMove];
    }
    SKAction *endBlock = [SKAction runBlock:^{
        [propVelocity changeHP:50 attacker:self];
        isColliedMoveJelly = 0;
        self.pace = 0;
    }];
    SKAction *seqPropMove = [SKAction sequence:@[propMove,endBlock]];
    [self runAction:seqPropMove withKey:@"propMove"];
}

-(void)setPropInGrid:(int)hasNodeNumber;
{
    Grid *grid = gridArray[self.gridNamber];
    grid.isShowLines = 0;
    grid.propInGrid = self;
    grid.hasNode = hasNodeNumber;
}

-(void)useDie
{
    [GridArray clearPropGridWithNumber:(int)self.gridNamber];
    [self removeAllActions];
    [self removeAllChildren];
    [super useDie];
}

-(void)jump
{
    if (isColliedMoveChicken == 1 || isColliedMoveJelly == 1 || self.isCantBeTouch == 1) {
        return;
    }
    SKAction *down0 = [SKAction moveByX:0 y:15 duration:0.1];
    SKAction *down1 = [SKAction moveByX:0 y:-15 duration:0.1];
    SKAction *down2 = [SKAction moveByX:0 y:5 duration:0.1];
    SKAction *down3 = [SKAction moveByX:0 y:-5 duration:0.1];
    down0.timingMode = SKActionTimingEaseOut;
    down1.timingMode = SKActionTimingEaseIn;
    down2.timingMode = SKActionTimingEaseOut;
    down3.timingMode = SKActionTimingEaseIn;
    SKAction *seq = [SKAction sequence:@[down0, down1, down2, down3]];
    [self runAction:seq];
}

-(void)checkPropInTheGrid
{
    Grid *grid = gridArray[self.gridNamber];
    Grid *nextGrid;
    if (self.gridNamber+5 < 40) {
        nextGrid = gridArray[self.gridNamber+5];
    }
    else {
        nextGrid = gridArray[self.gridNamber];
    }
    CGRect nowGirdRect = CGRectMake(grid.gridRect.origin.x, grid.gridRect.origin.y-35, 90, 45);
    CGRect nextGirdRect = CGRectMake(nextGrid.gridRect.origin.x, nextGrid.gridRect.origin.y-35, 90, 45);
    
    if (CGRectIntersectsRect(self.boxRect, nowGirdRect)) {
        
        if (grid.hasNode != 1) {
            grid.isShowLines = 0;
            grid.propInGrid = self;
            grid.hasNode = 2;
        }
        if (nextGrid.hasNode != 1) {
            nextGrid.isShowLines = 1;
            nextGrid.propInGrid = nil;
            nextGrid.hasNode = 0;
        }
    }
    
    if (CGRectIntersectsRect(self.boxRect, nextGirdRect)) {
        if (nextGrid.hasNode != 1) {
            nextGrid.isShowLines = 0;
            nextGrid.propInGrid = self;
            nextGrid.hasNode = 2;
            if (self.gridNamber+5 < 40) {
                self.gridNamber += 5;
            }
        }
        if (grid.hasNode != 1) {
            grid.isShowLines = 1;
            grid.propInGrid = nil;
            grid.hasNode = 0;
        }
    }
}

// empty function;
-(void)beColliedBy:(Body *)body
{
    return;
}


-(void)propDoThings
{
    return;
}



@end
