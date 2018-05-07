//
//  SnailJelly.m
//  DontEatMe
//
//  Created by ym on 15/1/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "SnailJelly.h"
#import "CDBar.h"
#import "Bullet.h"

@implementation SnailJelly
{
    SKNode *games;
}

-(id)init
{
    if (self = [super initWithTexture:Atlas(@"jelly_snail_rest")[0]]) {
        
    }
    return self;
}

-(void)createInit
{
    [super createInit];
    
    self.myName = @"snail";
    self.gemTexture = Atlas(@"ui_map_bigObj")[6];
    self.texString_attack = @"jelly_snail_attack";
    self.texString_rest = @"jelly_snail_rest";
    self.defAttackRect = CGRectMake(-640, 0, 640*2, ih-self.position.y-10);
    [self changeGem];
    
    self.skillCD = 12;
    self.haveSnail_changeHPRate = 1;
    self.haveSnail_time = 12;
    if (self.isGemA == YES) {
        self.skillCD = 6;
    }
    if (self.isGemB == YES) {
        self.haveSnail_changeHPRate = 1.8;
    }
   
    [self addCDBar:CGPointMake(0, -30) name:@"jelly_cd_timing" beginName:@"jelly_cd_beging"]; //0,60
    
    ViewController *vc = [ViewController single];
    games = vc.gameScene.war.jellysBullets;
}

-(void)useAttack
{
    [self useSkill];
}

-(void)useSkill
{
    if ([self changCanStatusRun:s_skill] == NO) {
        return;
    }
    self.canNotChangeStatus = @[s_skill];
    SKAction *anime = [SKAction animateWithTextures:Atlas(self.texString_attack) timePerFrame:oneKey resize:YES restore:NO];
    SKAction *animeEndBlcok = [SKAction runBlock:^{[self useRest:@[s_skill]];}];
    SKAction *animeSeq = [SKAction sequence:@[anime,animeEndBlcok]];
    SKAction *block = [SKAction runBlock:^{
        [self.cdBar changeCDBar:^{
            self.canNotChangeStatus = @[];
        }];
        
        Bullet *jellyBullet = [[Bullet alloc] init];
        [jellyBullet animationMove];
        jellyBullet.attack = 1;
        jellyBullet.position = CGPointMake(self.position.x, self.position.y);
        jellyBullet.defBoxRect = CGRectMake(-640, -40, 640*2, 80);
        jellyBullet.haveBuffSkill = YES;
        jellyBullet.haveSnail_time = self.haveSnail_time;
        jellyBullet.haveSnail_changeHPRate = self.haveSnail_changeHPRate;
        jellyBullet.hidden = YES;
        [games addChild:jellyBullet];
    }];
    SKAction *group = [SKAction group:@[animeSeq, block]];
    [self runAction:group withKey:s_skill];
}

@end
