//
//  TouchLayer.m
//  DontEatMe
//
//  Created by ym on 14/7/6.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "TouchLayer.h"
#import "CreateJelly.h"
#import "Jelly.h"
#import "Prop.h"
#import "Button.h"
#import "CDBar.h"
@implementation TouchLayer
{
    NSMutableArray *gridArray;
    SKSpriteNode *shadow;
    SKSpriteNode *shadowOne;
    SKSpriteNode *dottedLine;
    SKSpriteNode *dottedLinePickDown;
    
    SK_Button *spoonButton;
    NSArray *posArray;
    
    SKSpriteNode *dottedLine_0;
    SKSpriteNode *dottedLine_1;
    SKSpriteNode *dottedLine_2;
    SKSpriteNode *dottedLine_3;
    
    float tempTime;
    BOOL isUIOpen;
    int mana;
    int egg;
    int touchFlag;
    
    StaticActions *sa;
    SKAction *buttonSound;
    SKAction *spoonSound;
}

-(void)removeFromParent
{
    [gridArray removeAllObjects];
    gridArray = nil;
    posArray = nil;
    [_buttonArray removeAllObjects];
    _buttonArray = nil;
    
    [shadow removeAllChildren];
    [shadow removeFromParent];
    shadow = nil;
    
    [shadowOne removeAllChildren];
    [shadowOne removeFromParent];
    shadowOne = nil;
    
    [dottedLine removeFromParent];
    dottedLine = nil;
    
    [dottedLine_0 removeFromParent];
    dottedLine_0 = nil;
    
    [dottedLine_1 removeFromParent];
    dottedLine_1 = nil;
    
    [dottedLine_2 removeFromParent];
    dottedLine_2 = nil;
    
    [dottedLine_3 removeFromParent];
    dottedLine_3 = nil;
    
    [dottedLinePickDown removeFromParent];
    dottedLinePickDown = nil;
    
    [spoonButton removeAllChildren];
    [spoonButton removeFromParent];
    spoonButton = nil;
    
    [_buttonArray removeAllObjects];

    [self removeAllChildren];
    [super removeFromParent];
}

-(id)init
{
    if (self = [super initWithColor:[UIColor clearColor] size:CGSizeMake(iw, ih)]) {
        self.userInteractionEnabled = YES;
        self.position = CGPointMake(0, 0);
        self.anchorPoint = CGPointMake(0, 0);
        self.isCanSpoon = YES;
        sa = [StaticActions single];
        gridArray = [GridArray getGridArray];
        isUIOpen = NO;
        tempTime = 0.15;
        _isCanTouch = YES;
        [self createTreeDic];
        
        spoonSound = [SKAction playSoundFileNamed:@"Sound/ui_seletJelly_notBeginButton.mp3" waitForCompletion:YES];
        buttonSound = [SKAction playSoundFileNamed:@"Sound/jelly_touch_2.mp3" waitForCompletion:YES];
        
        //提前创建一次,预加载缓存
        Grid *grid;
        [self showButtonsWithPosition:CGPointMake(-500, -500) grid:grid];
        isUIOpen = YES;
        [self closeTouchUI];
    }
    return self;
}

-(void)changeMana:(int)theMana
{
    mana = theMana;
    [shadow.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TouchButton *button = (TouchButton *)obj;
        if (mana >= button.mana ) {
            button.canCreateJelly = YES;
        }else {
            button.canCreateJelly = NO;
        }
    }];
}

-(void)showButtonsWithPosition:(CGPoint)pos grid:(Grid *)grid
{
    CGPoint shadowPos = CGPointMake(pos.x, pos.y+shadow.size.height/2+18);
    
    if (grid.hasNode <= 1) {
        isUIOpen = YES;
        if (shadowPos.x-(shadow.size.width/2-12) < 0) {
            shadowPos.x = 0+(shadow.size.width/2-12);
        }
        if (shadowPos.x+(shadow.size.width/2-12) >iw) {
            shadowPos.x = iw-(shadow.size.width/2-12);
        }
        if (shadowPos.y+(shadow.size.height/2-12) >ih) {
            shadowPos.y = ih-(shadow.size.height/2-12);
        }
        
        dottedLine.position = pos;
        
        SKAction *move = [SKAction moveTo:CGPointMake(0, 0) duration:tempTime];
        move.timingMode = SKActionTimingEaseOut;
        
        dottedLine_0.position = CGPointMake(-20, 20);
        dottedLine_1.position = CGPointMake(20, 20);
        dottedLine_2.position = CGPointMake(-20, -20);
        dottedLine_3.position = CGPointMake(20, -20);
        
        [dottedLine_0 runAction:move];
        [dottedLine_1 runAction:move];
        [dottedLine_2 runAction:move];
        [dottedLine_3 runAction:move];
    }
    
    if (grid.hasNode == 0) {
        shadow.position = shadowPos;
        shadow.alpha = 0;
        SKAction *fadeIn = [SKAction fadeInWithDuration:tempTime];
        [shadow runAction:fadeIn];
        
        [shadow.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TouchButton *button = (TouchButton *)obj;
            button.position = CGPointMake(0, 0);
            CGPoint numberPos = CGPointFromString([posArray objectAtIndex:idx]);
            SKAction *move_0 = [SKAction moveTo:numberPos duration:tempTime];
            move_0.timingMode = SKActionTimingEaseOut;
            [button runAction:move_0];
            
            if (mana >= button.mana) {
                button.canCreateJelly = YES;
            }else {
                button.canCreateJelly = NO;
            }
            
            ViewController *vc = [ViewController single];
            [button event:^{
                [self runAction:buttonSound];
                [CreateJelly addJellyWithName:button.name pos:CGPointMake(pos.x, pos.y-40) gird:grid array:gridArray games:vc.gameScene.war.jellys];
                [self closeTouchUI];
                CDBar *cdBar = (CDBar *)[button childNodeWithName:button.name];
                button.isTimeOver = NO;
                cdBar.hidden = NO;
                [cdBar changeCDBar:^{
                    cdBar.hidden = YES;
                    button.isTimeOver = YES;
                }];
            }];
        }];
    }
    else if (grid.hasNode == 1) {
        CGPoint shadowOnePos = CGPointMake(pos.x, pos.y+shadowOne.size.height/2+18);
        if (shadowOnePos.x-(shadowOne.size.width/2-12) < 0) {
            shadowOnePos.x = 0+(shadowOne.size.width/2-12);
        }
        if (shadowOnePos.x+(shadowOne.size.width/2-12) >iw) {
            shadowOnePos.x = iw-(shadowOne.size.width/2-12);
        }
        if (shadowOnePos.y+(shadowOne.size.height/2-12) >ih) {
            shadowOnePos.y = ih-(shadowOne.size.height/2-12);
        }
        shadowOne.position = shadowOnePos;
        shadowOne.alpha = 0;
        SKAction *fadeIn = [SKAction fadeInWithDuration:tempTime];
        [shadowOne runAction:fadeIn];
        
        spoonButton.position = CGPointMake(0, 0);
        CGPoint numberPos = CGPointMake(0, 33);
        SKAction *move_0 = [SKAction moveTo:numberPos duration:tempTime];
        move_0.timingMode = SKActionTimingEaseOut;
        [spoonButton runAction:move_0];
        
        if (self.isCanSpoon == YES) {
            SKAction *action = [SKAction colorizeWithColor:rgb(0x3a3704, 1) colorBlendFactor:0 duration:0.15];
            [spoonButton runAction:action];
        }
        else {
            SKAction *action = [SKAction colorizeWithColor:rgb(0x3a3704, 1) colorBlendFactor:0.36 duration:0.15];
            [spoonButton runAction:action];
        }
        
        //!!! :挖掉
        [spoonButton event:^{
            [self runAction:spoonSound];
            if (self.isCanSpoon == YES) {
                
                if (grid.nodeInGrid.isCallBackMana > 0) {
                    ViewController *vc = [ViewController single];
                    [vc.gameScene changeMana:2];
                }
                
                grid.nodeInGrid.isTouchKill = 1;
                grid.nodeInGrid.isGemA = NO;
                grid.nodeInGrid.isGemB = NO;
                [grid.nodeInGrid useDie];
                grid.nodeInGrid = nil;
                grid.propInGrid = nil;
                grid.hasNode = 0;
                [self closeTouchUI];
            }
        }];
    }
    else if (grid.hasNode == 2) {
        Prop *prop = grid.propInGrid;
        [prop jump];
        [self closeTouchUI];
    }
    else if (grid.hasNode == 3) {
        Button *button = (Button *)grid.propInGrid;
        [button jump];
        [button buttonDown];
    }
    else if (grid.hasNode == 4) {
        [grid.nodeInGrid useSkill];
    }
    else if (grid.hasNode == 9) {
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isCanTouch == NO) {
        return;
    };
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGRect touchRect = CGRectMake(location.x, location.y, 1, 1);
        
        [gridArray enumerateObjectsUsingBlock:^(Grid *grid, NSUInteger idx, BOOL *stop) {
            if (CGRectIntersectsRect(grid.gridRect, touchRect)) {
                CGPoint jellyPos = CGPointMake(grid.position.x+5, grid.position.y-8);

                if (grid.isShowLines == 1) {
                    dottedLinePickDown.alpha = 1;
                }
                else {
                    dottedLinePickDown.alpha = 0.4;
                }
                dottedLinePickDown.position = jellyPos;
            }
        }];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isCanTouch == NO) {
        return;
    };
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGRect touchRect = CGRectMake(location.x, location.y, 1, 1);
    
        [gridArray enumerateObjectsUsingBlock:^(Grid *grid, NSUInteger idx, BOOL *stop) {
            if (CGRectIntersectsRect(grid.gridRect, touchRect)) {
                CGPoint jellyPos = CGPointMake(grid.position.x+5, grid.position.y-8);
                if (isUIOpen) {
                    [self closeTouchUI];
                }
                if (grid.isShowLines == 1) {
                    dottedLinePickDown.alpha = 1;
                }
                else {
                    dottedLinePickDown.alpha = 0.4;
                }
                dottedLinePickDown.position = jellyPos;
            };
        }];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isCanTouch == NO) {
        return;
    };
    
    [self removeAllActions];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGRect touchRect = CGRectMake(location.x, location.y, 1, 1);
        
        dottedLinePickDown.position = CGPointMake(-500, -500);
        [gridArray enumerateObjectsUsingBlock:^(Grid *grid, NSUInteger idx, BOOL *stop) {
            if (CGRectIntersectsRect(grid.gridRect, touchRect)) {
                if (!isUIOpen && touchFlag != 1) {
                    CGPoint jellyPos = CGPointMake(grid.position.x+5, grid.position.y-8);
                    [self showButtonsWithPosition:jellyPos grid:grid];
                    return;
                }
                else if (isUIOpen) {
                    [self closeTouchUI];
                }
                touchFlag = 0;
            }
        }];
        
        if (location.y < (ih - 880)) {
            [self closeTouchUI];
        }
    }
}

-(void)closeTouchUI
{
    shadow.position = CGPointMake(-500, -500);
    shadowOne.position = CGPointMake(-500, -500);
    dottedLine.position = CGPointMake(-500, -500);
    isUIOpen = NO;
}

-(void)createTreeDic
{
    NSDictionary *jellysTexture = @{@"banana": AtlasNum(@"ui_games_pick", 1), @"energy": AtlasNum(@"ui_games_pick", 2),
                                    @"slow": AtlasNum(@"ui_games_pick", 3), @"iceThin": AtlasNum(@"ui_games_pick", 4),
                                    @"boom": AtlasNum(@"ui_games_pick", 5), @"double": AtlasNum(@"ui_games_pick", 6),
                                    @"strom": AtlasNum(@"ui_games_pick", 7), @"shield": AtlasNum(@"ui_games_pick", 8),
                                    @"boxer": AtlasNum(@"ui_games_pick", 10), @"iceThick": AtlasNum(@"ui_games_pick", 9),
                                    @"aoeBoom": AtlasNum(@"ui_games_pick", 11), @"violent": AtlasNum(@"ui_games_pick", 13),
                                    @"cure": AtlasNum(@"ui_games_pick", 12), @"dizzy": AtlasNum(@"ui_games_pick", 14),
                                    @"highEnergy": AtlasNum(@"ui_games_pick", 15), @"iceMist": AtlasNum(@"ui_games_pick", 16),
                                    @"iceThorn": AtlasNum(@"ui_games_pick", 17), @"laser": AtlasNum(@"ui_games_pick", 18),
                                    @"snail": AtlasNum(@"ui_games_pick", 19), @"spoon": AtlasNum(@"ui_games_pick", 0)};
    
    NSArray *allJellys = @[@"banana", @"energy", @"iceThin", @"slow", @"boom", @"double",
                           @"strom", @"shield", @"boxer", @"iceThick", @"aoeBoom", @"violent",
                           @"cure", @"dizzy", @"highEnergy", @"iceMist", @"iceThorn", @"laser", @"snail", @"spoon"];
    
    NSMutableArray *endArray = [NSMutableArray array];
    _buttonArray = [NSMutableArray array];
    
    ClassCenter *cc = [ClassCenter singleton];
    for (NSString *strB in allJellys) {
        [cc.classJellyNames enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *strA = (NSString *)obj;
            if ([strA isEqualToString:strB]) {
                [endArray addObject:strB];
            }
        }];
    }
    
    shadow = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_pick", 35)];
    shadow.position = CGPointMake(-500, -500);
    shadow.zPosition = 0.2;
    [self addChild:shadow];
     
    //TODO: 设置果冻消耗的mana
    NSDictionary *manaDic = @{@"banana": @3, @"energy": @2, @"double": @4, @"iceThin": @3, @"slow": @2, @"shield": @2, @"iceThorn": @6,
                              @"boxer": @6, @"boom": @1, @"strom": @12, @"violent": @10, @"highEnergy": @4, @"snail": @6, @"iceThick": @5,
                              @"cure": @4, @"aoeBoom": @12, @"dizzy": @7, @"iceMist": @7, @"laser": @15, };
    
    NSDictionary *timeDic = @{@"banana": @8, @"energy": @10, @"double": @4, @"iceThin": @20, @"slow": @2, @"shield": @2,            @"iceThorn": @6,
                              @"boxer": @6, @"boom": @20, @"strom": @12, @"violent": @10, @"highEnergy": @4, @"snail": @6, @"iceThick": @5,
                              @"cure": @4, @"aoeBoom": @12, @"dizzy": @7, @"iceMist": @7, @"laser": @15, };
    
    [endArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *string = [endArray objectAtIndex:idx];
        SKTexture *tex = [jellysTexture objectForKey:string];
        TouchButton *button = [TouchButton spriteNodeWithTexture:tex];
        button.name = string;
        [manaDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
            if ([key isEqualToString:string]) {
                button.mana = [obj intValue];
                
                //aoeBoom的B宝石
                if ([key isEqualToString:@"aoeBoom"]) {
                    NSDictionary *jellyDic = [[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:string];
                    BOOL gemB = [[jellyDic objectForKey:@"isGemA"] intValue] == 0 ? YES : NO;
                    if (gemB == YES) {
                        button.mana -= 3;
                    }
                }
            }
        }];
        
        [timeDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
            if ([key isEqualToString:string]) {
                button.time = [obj intValue];
                CDBar *cdBar = [[CDBar alloc] initWithName:@"jelly_cd_timing" beginName:@"jelly_cd_beging"];
                cdBar.position = CGPointMake(0, 1);
                [button addChild:cdBar];
                cdBar.name = key;
                [cdBar setScale:1.45];
                cdBar.hidden = YES;
                cdBar.defaultAllTime = button.time;
                
                if ([key isEqualToString:@"iceThin"]) {
                    cdBar.hidden = NO;
                    button.isTimeOver = NO;
                    [cdBar changeCDBar:^{
                        cdBar.hidden = YES;
                        button.isTimeOver = YES;
                    }];
                }
            }
        }];
        
        BOOL isGemA = NO;
        BOOL isGemB = NO;
        NSDictionary *jellyDic = [[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:string];
        isGemA = [[jellyDic objectForKey:@"isGemA"] intValue] == 0 ? YES : NO;
        isGemB = [[jellyDic objectForKey:@"isGemB"] intValue] == 0 ? YES : NO;

        [button addGemA:isGemA gemB:isGemB];
        button.zPosition = 0.25;
        button.position = CGPointMake(-500, -500);
        [shadow addChild:button];
    }];
    
    ViewController *vc = [ViewController single];
    int buttonCount = (int)shadow.children.count;
    int sceneNumber = 0;
    if ([vc.gameScene.war.c_scene isEqualToString:@"greed"]) {
        sceneNumber = 0;
    }
    else if ([vc.gameScene.war.c_scene isEqualToString:@"blue"]) {
        sceneNumber = 1;
    }
    
    if (sceneNumber == 0){
        shadowOne = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_pick", 31)];
        shadowOne.position = CGPointMake(-500, -500);
        shadowOne.zPosition = 0.2;
        [self addChild:shadowOne];
    }
    else if (sceneNumber == 1){
        shadowOne = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_pick", 27)];
        shadowOne.position = CGPointMake(-500, -500);
        shadowOne.zPosition = 0.2;
        [self addChild:shadowOne];
    }
    
    if (buttonCount == 1) {
        if (sceneNumber == 0) shadow.texture = AtlasNum(@"ui_games_pick", 31);
        else if (sceneNumber == 1) shadow.texture = AtlasNum(@"ui_games_pick", 27);
        shadow.size = shadow.texture.size;
        NSString *pos_0 = @"{0,33}";
        posArray = @[pos_0];
    }
    else if (buttonCount == 2) {
        if (sceneNumber == 0) shadow.texture = AtlasNum(@"ui_games_pick", 30);
        else if (sceneNumber == 1) shadow.texture = AtlasNum(@"ui_games_pick", 26);
        shadow.size = shadow.texture.size;
        NSString *pos_0 = @"{-56,33}";
        NSString *pos_1 = @"{56,33}";
        posArray = @[pos_0, pos_1];
    }
    else if (buttonCount == 3) {
        if (sceneNumber == 0) shadow.texture = AtlasNum(@"ui_games_pick", 29);
        else if (sceneNumber == 1) shadow.texture = AtlasNum(@"ui_games_pick", 25);
        shadow.size = shadow.texture.size;
        NSString *pos_0 = @"{-122,33}";
        NSString *pos_1 = @"{0,33}";
        NSString *pos_2 = @"{122,33}";
        posArray = @[pos_0, pos_1, pos_2];
    }
    else if (buttonCount == 4) {
        if (sceneNumber == 0) shadow.texture = AtlasNum(@"ui_games_pick", 28);
        else if (sceneNumber == 1) shadow.texture = AtlasNum(@"ui_games_pick", 24);
        shadow.size = shadow.texture.size;
        NSString *pos_0 = @"{-122,86}";
        NSString *pos_1 = @"{0,86}";
        NSString *pos_2 = @"{122,86}";
        NSString *pos_3 = @"{0,-31}";
        posArray = @[pos_0, pos_1, pos_2, pos_3];
    }
    else if (buttonCount == 5) {
        if (sceneNumber == 0) shadow.texture = AtlasNum(@"ui_games_pick", 28);
        else if (sceneNumber == 1) shadow.texture = AtlasNum(@"ui_games_pick", 24);
        shadow.size = shadow.texture.size;
        NSString *pos_0 = @"{-122,86}";
        NSString *pos_1 = @"{0,86}";
        NSString *pos_2 = @"{122,86}";
        NSString *pos_3 = @"{-72,-36}";
        NSString *pos_4 = @"{72,-36}";
        posArray = @[pos_0, pos_1, pos_2, pos_3, pos_4];
    }
    else if (buttonCount == 6) {
        if (sceneNumber == 0) shadow.texture = AtlasNum(@"ui_games_pick", 28);
        else if (sceneNumber == 1) shadow.texture = AtlasNum(@"ui_games_pick", 24);
        shadow.size = shadow.texture.size;
        NSString *pos_0 = @"{-122,86}";
        NSString *pos_1 = @"{0,86}";
        NSString *pos_2 = @"{122,86}";
        NSString *pos_3 = @"{-122,-36}";
        NSString *pos_4 = @"{0,-36}";
        NSString *pos_5 = @"{122,-36}";
        posArray = @[pos_0, pos_1, pos_2, pos_3, pos_4, pos_5];
    }
    else if (buttonCount == 7) {
        if (sceneNumber == 0) shadow.texture = AtlasNum(@"ui_games_pick", 32);
        else if (sceneNumber == 1) shadow.texture = AtlasNum(@"ui_games_pick", 33);
        shadow.size = shadow.texture.size;
        NSString *pos_0 = @"{-183,86}";
        NSString *pos_1 = @"{-63,86}";
        NSString *pos_2 = @"{63,86}";
        NSString *pos_3 = @"{183,86}";
        NSString *pos_4 = @"{-122,-36}";
        NSString *pos_5 = @"{0,-36}";
        NSString *pos_6 = @"{122,-36}";
        posArray = @[pos_0, pos_1, pos_2, pos_3, pos_4, pos_5, pos_6];
    }
    else if (buttonCount == 8) {
        if (sceneNumber == 0) shadow.texture = AtlasNum(@"ui_games_pick", 32);
        else if (sceneNumber == 1) shadow.texture = AtlasNum(@"ui_games_pick", 33);
        shadow.size = shadow.texture.size;
        NSString *pos_0 = @"{-183,86}";
        NSString *pos_1 = @"{-63,86}";
        NSString *pos_2 = @"{63,86}";
        NSString *pos_3 = @"{183,86}";
        NSString *pos_4 = @"{-183,-36}";
        NSString *pos_5 = @"{-63,-36}";
        NSString *pos_6 = @"{63,-36}";
        NSString *pos_7 = @"{183,-36}";
        posArray = @[pos_0, pos_1, pos_2, pos_3, pos_4, pos_5, pos_6, pos_7];
    }
    
    dottedLine = [SKSpriteNode spriteNodeWithColor:rgb(0x000000, 0) size:CGSizeMake(121, 102)];
    dottedLine.position = CGPointMake(-500, -500);
    dottedLine.zPosition = -1999;
    [self addChild:dottedLine];
    
    dottedLine_0 = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_pick", 20)];
    dottedLine_1 = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_pick", 21)];
    dottedLine_2 = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_pick", 22)];
    dottedLine_3 = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_pick", 23)];
    
    dottedLine_0.position = CGPointMake(-20, 20);
    dottedLine_1.position = CGPointMake(20, 20);
    dottedLine_2.position = CGPointMake(-20, -20);
    dottedLine_3.position = CGPointMake(20, -20);
    
    [dottedLine addChild:dottedLine_0];
    [dottedLine addChild:dottedLine_1];
    [dottedLine addChild:dottedLine_2];
    [dottedLine addChild:dottedLine_3];
    
    spoonButton = [SK_Button spriteNodeWithTexture:AtlasNum(@"ui_games_pick", 0)];
    spoonButton.position =CGPointMake(-500, -500);
    [shadowOne addChild:spoonButton];
//    spoonButton.mana = 99;
    
    dottedLinePickDown = [SKSpriteNode spriteNodeWithTexture:AtlasNum(@"ui_games_pick", 36)];
    dottedLinePickDown.position = CGPointMake(-500, -500);
    dottedLinePickDown.zPosition = -1999;
    [self addChild:dottedLinePickDown];
}

@end
