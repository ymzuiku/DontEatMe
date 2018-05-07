//
//  GameScene.h
//  DontEatMe
//
//  Created by ym on 14/9/5.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "SelectJellys.h"
#import "BeginAnime.h"
#import "Background.h"
#import "TopBar.h"
#import "ButtonBar.h"
#import "War.h"
#import "War_Controller.h"
#import "TouchLayer.h"

@interface GameScene : SKScene

-(id)initWithNumber:(int)number;
+(id)createWithNumber:(int)number;

-(void)downObject:(NSString *)string pos:(CGPoint)pos;
-(void)gotoMap:(int)isWin;
-(void)startGame;
-(void)loster;
-(void)winner;
-(void)revive;
-(void)pause;
-(void)goon;
-(void)reloadGame;
-(void)showSelectJellysLand;
-(void)changeMana:(int)theMana;
-(void)createWar;

@property (nonatomic) Background *background;
@property (nonatomic) War *war;
@property (nonatomic) War_Controller *war_Controller;
@property (nonatomic) TouchLayer *touchLayer;
@property (nonatomic) SelectJellys *selectJellys;
@property (nonatomic) TopBar *topBar;
@property (nonatomic) ButtonBar *buttonBar;
@property (nonatomic) SK_BackgroundSound *music_BG;
@property (nonatomic) BeginAnime *beginAnime;
@property (nonatomic) int mana;
@property (nonatomic) int isAgainClass;
@property (nonatomic) int classNumber;
@property (nonatomic) SKSpriteNode *rootView;


@end
