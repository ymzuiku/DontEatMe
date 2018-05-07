//
//  MoreChickensHummer.m
//  DontEatMe
//
//  Created by ym on 15/2/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "MoreChickensHummer.h"

#define grid0 @"{98,1095}"
#define grid1 @"{212,1095}"
#define grid2 @"{326,1095}"
#define grid3 @"{440,1095}"
#define grid4 @"{554,1095}"
#define grid5 @"{98,1001}"
#define grid6 @"{212,1001}"
#define grid7 @"{326,1001}"
#define grid8 @"{440,1001}"
#define grid9 @"{554,1001}"
#define grid10 @"{98,907}"
#define grid11 @"{212,907}"
#define grid12 @"{326,907}"
#define grid13 @"{440,907}"
#define grid14 @"{554,907}"
#define grid15 @"{98,813}"
#define grid16 @"{212,813}"
#define grid17 @"{326,813}"
#define grid18 @"{440,813}"
#define grid19 @"{554,813}"
#define grid20 @"{98,719}"
#define grid21 @"{212,719}"
#define grid22 @"{326,719}"
#define grid23 @"{440,719}"
#define grid24 @"{554,719}"
#define grid25 @"{98,625}"
#define grid26 @"{212,625}"
#define grid27 @"{326,625}"
#define grid28 @"{440,625}"
#define grid29 @"{554,625}"
#define grid30 @"{98,531}"
#define grid31 @"{212,531}"
#define grid32 @"{326,531}"
#define grid33 @"{440,531}"
#define grid34 @"{554,531}"
#define grid35 @"{98,437}"
#define grid36 @"{212,437}"
#define grid37 @"{326,437}"
#define grid38 @"{440,437}"
#define grid39 @"{554,437}"
#define grid40 @"{98,343}"
#define grid41 @"{212,343}"
#define grid42 @"{326,343}"
#define grid43 @"{440,343}"
#define grid44 @"{554,343}"

@interface MiniHammer : SKSpriteNode

@property SKSpriteNode *chicken;
-(id)initWithChicken:(SKSpriteNode *)theChicken;

@end

@implementation MiniHammer
{
    SKAction *pickSound;
    ViewController *vc;
    StaticActions *sa;
    NSArray *chickenList;
    NSArray *posList;
    int chickenListNumber;
}

-(void)removeFromParent
{
    vc = nil;
    sa = nil;
    pickSound = nil;
    [super removeFromParent];
}

-(id)initWithChicken:(SKSpriteNode *)theChicken;
{
    if (self = [super initWithTexture:Atlas(@"scene_moreChickens_other")[2]]) {
        self.userInteractionEnabled = YES;
        _chicken = theChicken;
        pickSound = [SKAction playSoundFileNamed:@"Sound/boxer_attack_0.mp3" waitForCompletion:NO];
        vc = [ViewController single];
        sa = [StaticActions single];
        
        //spoon  onion  fish  ironBasin  woodenBasin  fat  bomb  beer  fire  saw  weed  yoda  rifle  machete  maid  fur  robot
        chickenList = @[@"spoon", @"spoon", @"beer", @"spoon", @"spoon", @"woodenBasin", @"beer",@"rifle", @"spoon",@"fire", @"ironBasin",@"beer", @"machete",@"onion",@"woodenBasin",@"beer", @"fish", @"fish",@"ironBasin", @"bomb", @"beer", @"maid",@"fish",@"fire", @"beer", @"machete", @"spoon",  @"woodenBasin", @"spoon",@"beer", @"woodenBasin",@"beer",@"bomb",@"rifle", @"woodenBasin",@"ironBasin", @"onion",@"fat", @"beer",@"rifle",@"spoon",  @"bomb", @"fire",@"machete", @"spoon", @"fire", @"saw", @"weed", @"yoda", @"rifle",@"bomb", @"machete", @"spoon",@"onion", @"ironBasin", @"maid", @"fur"];
        posList = @[grid0, grid1, grid2, grid3, grid4, grid5, grid6, grid7, grid8, grid9, grid10, grid11, grid12, grid13, grid14,
                    grid15, grid16, grid17, grid18, grid19, grid22,];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.texture = Atlas(@"scene_moreChickens_other")[3];
    [self runAction:pickSound];
    _chicken.speed = 0;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
    _chicken.speed = 1;
    int posRandom = random() % (int)posList.count;
    self.texture = Atlas(@"scene_moreChickens_other")[2];
    [[ViewController single].gameScene downObject:@"gold.1" pos:CGPointMake(iw-140-posRandom*2, ih/2-100-posRandom/2)];
    SKAction *move = [SKAction moveByX:0 y:-100 duration:0.2];
    move.timingMode = SKActionTimingEaseOut;
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.2];
    SKAction *group = [SKAction group:@[move, fadeIn]];
    Chicken *chicken = [vc.gameScene.war createOneChickenWithName:chickenList[chickenListNumber%chickenList.count]];
    chicken.position = CGPointFromString(posList[posRandom]);
    chicken.alpha = 0.5;
    [vc.gameScene.war.chickens addChild:chicken];
    [chicken runAction:group completion:^{
        [chicken startup];
        [chicken beBuff_dizzy:3 random:100];
        [chicken changeHP:chicken.defaultHP/5 attacker:nil];
    }];
    chickenListNumber++;
    
}

@end

@implementation MoreChickensHummer
{
    SKSpriteNode *background;
    SKSpriteNode *chicken;
    SKSpriteNode *timeLine;
    SKSpriteNode *fire;
    SKSpriteNode *hammerShadow;
    MiniHammer *hammer;
    SK_Button *closeButton;
}
-(id)init
{
    if (self = [super initWithColor:[UIColor clearColor] size:CGSizeMake(100, 100)]) {
        self.zPosition = 1999.6;  //touchLayer 是1999.5
        self.position = CGPointMake(iw+200, ih/2);
        [self setScale:0.6];
        background = [SKSpriteNode spriteNodeWithTexture:Atlas(@"scene_moreChickens_other")[0]];
        [self addChild:background];
        
        float waitTime = 9;
        float codingTime = (waitTime-0.9)*0.02;
        timeLine = [SKSpriteNode spriteNodeWithTexture:Atlas(@"scene_moreChickens_timeline")[0]];
        SKAction *animeTimeLine = [SKAction animateWithTextures:Atlas(@"scene_moreChickens_timeline") timePerFrame:codingTime resize:YES restore:NO];
        [background addChild:timeLine];
        [timeLine runAction:animeTimeLine completion:^{
            [self moveOut];
        }];
        timeLine.position = CGPointMake(203-204, 300-107);
        
        chicken = [SKSpriteNode spriteNodeWithTexture:Atlas(@"scene_moreChickens_chicken")[0]];
        SKAction *animeChicken = [SKAction animateWithTextures:Atlas(@"scene_moreChickens_chicken") timePerFrame:oneKey resize:YES restore:NO];
        [chicken runAction:[SKAction repeatActionForever:animeChicken]];
        [background addChild:chicken];
        chicken.position = CGPointMake(200-204, 300-30);
        
        fire = [SKSpriteNode spriteNodeWithTexture:Atlas(@"scene_moreChickens_fire")[0]];
        SKAction *animeFire = [SKAction animateWithTextures:Atlas(@"scene_moreChickens_fire") timePerFrame:oneKey resize:YES restore:NO];
        [fire runAction:[SKAction repeatActionForever:animeFire]];
        fire.zPosition = -1;
        [background addChild:fire];
        fire.position = CGPointMake(206-204, 300-364);
        
        closeButton = [SK_Button spriteNodeWithTexture:Atlas(@"scene_moreChickens_other")[1]];
        [background addChild:closeButton];
        [closeButton playSound:[SKAction playSoundFileNamed:@"Sound/ui_goButton_1.mp3" waitForCompletion:NO]];
        [closeButton event:^{
           [self moveOut];
        }];
        closeButton.position = CGPointMake(55.8-204, 300-58.6);
        
        SKAction *backSound = [SKAction playSoundFileNamed:@"Sound/moreChickens.mp3" waitForCompletion:YES];
        SKAction *seqSound = [SKAction sequence:@[backSound, backSound]];
        [self runAction:seqSound];
        
        
        hammer = [[MiniHammer alloc] initWithChicken:chicken];
        hammer.position = CGPointMake(254.2-204, 300-32.2);
        [background addChild:hammer];
        
        [self moveIn];
    }
    return self;
}

-(void)moveIn
{
    SKAction *rockSound = [SKAction playSoundFileNamed:@"Sound/map_rocket.mp3" waitForCompletion:YES];
    [self runAction:rockSound];
    SKAction *moveIn = [SKAction moveTo:CGPointMake(iw-140, ih/2) duration:0.6];
    moveIn.timingMode = SKActionTimingEaseInEaseOut;
    [self runAction:moveIn];
}

-(void)moveOut
{
    SKAction *moveOut = [SKAction moveTo:CGPointMake(iw+200, ih/2) duration:0.6];
    moveOut.timingMode = SKActionTimingEaseInEaseOut;
    [self runAction:moveOut completion:^{
        [hammer removeFromParent];
        [self removeFromParent];
    }];
}

-(void)hammerDown
{
    
}

@end
