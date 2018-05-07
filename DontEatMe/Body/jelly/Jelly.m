//
//  Jelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "Jelly.h"
#import "Grid.h"

static NSMutableArray *gemAnimeArray;

@implementation Jelly

-(void)createInit
{
    [super createInit];
    self.name = @"jelly";
    [self sitDefaultHP:300];
    self.defBoxRect = CGRectMake(-30, -15, 60, 45);
    self.attack = 20;
    self.texString_hpBar = @"chicken_hp_blue_mini";
    
    self.soundAction_changeHPA = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_22.mp3" waitForCompletion:YES];
    self.soundAction_changeHPB = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_22.mp3" waitForCompletion:YES];
}

-(void)startup
{
    [super startup];
    [self useRest];
    [self reloadRect];
	self.lineOfJellyOn = [self countLine];
//    [self createGemAnime];    //test 取消宝石效果
}

-(int)countLine
{
    return self.position.x/114;
}

#pragma mark 基础动画

-(void)useRest
{
    [self useRest:@[s_rest]];
}

-(void)useRest:(NSArray *)notChangeArray
{
    if ([self changCanStatusRun:s_rest] == NO) {
        return;
    }
    self.canNotChangeStatus = notChangeArray;
    if (!self.restAction) {
        SKAction *rest;
        if (self.isNotAtlas_Static == YES) {
            
            rest = [SKAction animateWithTextures:Atlas(self.texString_rest) timePerFrame:oneKey/self.speedRest resize:YES restore:NO];
        }
        else {
            rest = [SKAction animateWithTextures:Atlas(self.texString_rest) timePerFrame:oneKey/self.speedRest resize:YES restore:NO];
        }
        self.restAction = [SKAction repeatActionForever:rest];
    }
    [self runAction:self.restAction withKey:s_rest];
}


#pragma mark 宝石
-(void)changeGem
{
    NSDictionary *dic = [[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:self.myName];
    self.isGemA  = [[dic objectForKey:@"isGemA"] intValue] == 0 ? YES : NO;
    self.isGemB = [[dic objectForKey:@"isGemB"] intValue] == 0 ? YES : NO;
}

-(void)createGemAnime
{
    if (self.isGemA == NO && self.isGemB == NO) {
        return;
    }
    if (!gemAnimeArray) {
        gemAnimeArray = [NSMutableArray array];
    }
    
    //防止重复播放锁
    BOOL isPlayedAnime = NO;
    for (NSString *jellyMyName in gemAnimeArray) {
        isPlayedAnime = [jellyMyName isEqualToString:self.myName]?YES:isPlayedAnime;
    }
    if (isPlayedAnime == YES) {
        return;
    }
    [gemAnimeArray addObject:self.myName];
    
    SKNode *nodeA = [SKNode node];
    [self addChild:nodeA];
    SKNode *nodeB = [SKNode node];
    [self addChild:nodeB];
    [nodeA setScale:0.5];
    [nodeB setScale:0.5];
    [nodeB setXScale:-0.5];
    
    if (self.isGemA == YES) {
        SKSpriteNode *gemA = [SKSpriteNode spriteNodeWithTexture:self.gemTexture];
        gemA.position = CGPointMake(-25, 10);
        gemA.alpha = 0;
        [nodeA addChild:gemA];
        [gemA runAction:[SK_Actions actionDown]];
    }
    if (self.isGemA == YES) {
        SKSpriteNode *gemB = [SKSpriteNode spriteNodeWithTexture:self.gemTexture];
        gemB.position = CGPointMake(25, 10);
        gemB.alpha = 0;
        [nodeB addChild:gemB];
        SKAction *wait = [SKAction waitForDuration:1];
        SKAction *seq = [SKAction sequence:@[wait, [SK_Actions actionDown]]];
        [gemB runAction:seq];
    }
    
    SKAction *waitA = [SKAction waitForDuration:1];
    SKAction *waitB = [SKAction waitForDuration:2];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.3];
    SKAction *seqA = [SKAction sequence:@[waitA, fadeOut]];
    SKAction *seqB = [SKAction sequence:@[waitB, fadeOut]];
    [nodeA runAction:seqA completion:^{
        [nodeA removeFromParent];
    }];
    [nodeB runAction:seqB completion:^{
        [nodeB removeFromParent];
    }];
}

-(void)useDie
{
    [GridArray clearJellyGridWithNumber:self.gridNumber];
    [super useDie];
}

+(void)clearStatic
{
    [gemAnimeArray removeAllObjects];
}

-(void)beColliedBy:(Body *)body
{
    if (self.beCollied == true) {
        return;
    }
    self.beCollied = true;
    SKAction *seqBeginBlock = [SKAction runBlock:^{
        [self resetZPostion];
        [self changeHP:body.attack attacker:body];
    }];
    SKAction *moveByCollied = [SKAction scaleTo:1.1 duration:0.1];
    SKAction *moveBackByCollied = [SKAction scaleTo:1.0 duration:0.1];
    SKAction *seqEndBlock = [SKAction runBlock:^{
        self.beCollied = false;
    }];
    SKAction *moveByColliedSeq =  [SKAction sequence:@[seqBeginBlock,moveByCollied, moveBackByCollied, seqEndBlock]];
    [self runAction:moveByColliedSeq withKey:@"moveByCollied"];
}

@end
