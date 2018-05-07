//
//  StaticActions.m
//  DontEatMe
//
//  Created by ym on 14/9/6.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "StaticActions.h"

@implementation StaticActions
{
    int needLoadNumber;
    int loadNumber;
    void (^myBlock)();
}

+(StaticActions *)single
{
    static StaticActions *staticActions;
    if (!staticActions) {
        staticActions = [[StaticActions alloc] init];
        [staticActions createActions];
    }
    return staticActions;
}

-(void)clearActions
{
    self.actionBig = nil;
    self.actionWater = nil;
    self.actionDown = nil;
    self.actionVerticalDown = nil;
    self.actionWait = nil;
    self.actionSpringUpWindow = nil;
    self.actionSpringDownWindow = nil;
    self.actionSpringRightInWindow = nil;
    self.actionSpringLeftOutWindow = nil;
    
    self.sound_buttonA = nil;  //    self.sound_buttonA.volume = 0.12;
    self.sound_buttonB = nil;
    self.sound_buttonC = nil;
    self.sound_buttonD = nil;
    self.sound_gold = nil;
    self.sound_cook = nil;
    self.sound_egg = nil;
    self.sound_win = nil;
    self.sound_pickTouch_0 = nil;
    self.sound_getUp = nil;
    self.sound_bananaAttack = nil;
    self.sound_woodenBasinChangeHP0 = nil;
    self.sound_woodenBasinChangeHP1 = nil;
    self.sound_woodenBasinChangeHP2 = nil;
    self.sound_ironBasinChangeHP0 = nil;
    self.sound_ironBasinChangeHP1 = nil;
    self.sound_normalChangeHP0 = nil;
    self.sound_normalChangeHP1 = nil;
    self.sound_normalChangeHP2 = nil;
    self.sound_normalChangeHP3 = nil;
    self.sound_normalChangeHP4 = nil;
    self.sound_normalChangeHP5 = nil;
    self.sound_normalChangeHP6 = nil;
    self.sound_beNormal = nil;
    self.sound_chickenAttack0 = nil;
    self.sound_chickenAttack1 = nil;
    self.sound_chickenAttack2 = nil;
    self.sound_basinChickenAttack0 = nil;
    self.sound_basinChickenAttack1 = nil;
    self.sound_basinChickenAttack2 = nil;
    self.sound_basinChickenAttack0 = nil;
    self.sound_createJelly = nil;

    
}

-(void)createActions
{
    self.actionBig = [SK_Actions actionBig];
    self.actionWater = [SK_Actions actionWater];
    self.actionDown = [SK_Actions actionDown];
    self.actionVerticalDown = [SK_Actions actionVerticalDown];
    self.actionWait = [SK_Actions actionWait];
    self.actionSpringUpWindow = [SK_Actions actionSpringUpWindow];
    self.actionSpringDownWindow = [SK_Actions actionSpringDownWindow];
    self.actionSpringRightInWindow = [SK_Actions actionSpringRightInWindow];
    self.actionSpringLeftOutWindow = [SK_Actions actionSpringLeftOutWindow];

    self.sound_buttonA = [SKAction playSoundFileNamed:@"Sound/ui_goButton_1.mp3" waitForCompletion:0];  //    self.sound_buttonA.volume = 0.12;
    self.sound_buttonB = [SKAction playSoundFileNamed:@"Sound/ui_goButton_0.mp3" waitForCompletion:0];
    self.sound_buttonC = [SKAction playSoundFileNamed:@"Sound/waterCreate.caf" waitForCompletion:0];
    self.sound_buttonD = [SKAction playSoundFileNamed:@"Sound/ui_buyButton_1.mp3" waitForCompletion:0];
    self.sound_gold = [SKAction playSoundFileNamed:@"Sound/gold.caf" waitForCompletion:0];
    self.sound_cook = [SKAction playSoundFileNamed:@"Sound/ui_cook_remove_0.mp3" waitForCompletion:0];
    self.sound_egg = [SKAction playSoundFileNamed:@"Sound/gold.caf" waitForCompletion:0];
    self.sound_win = [SKAction playSoundFileNamed:@"Sound/star_third.caf" waitForCompletion:0];
    self.sound_pickTouch_0 = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_6.mp3" waitForCompletion:0]; //self.sound_pickTouch_0.volume = 0.15;
    self.sound_getUp = [SKAction playSoundFileNamed:@"Sound/war_getUp.mp3" waitForCompletion:0];
    self.sound_bananaAttack = [SKAction playSoundFileNamed:@"Sound/jelly_touch_1.mp3" waitForCompletion:0];
    self.sound_woodenBasinChangeHP0 = [SKAction playSoundFileNamed:@"Sound/changeHP_woodenBasin_4.mp3" waitForCompletion:0];
    self.sound_woodenBasinChangeHP1 = [SKAction playSoundFileNamed:@"Sound/changeHP_woodenBasin_5.mp3" waitForCompletion:0];
    self.sound_woodenBasinChangeHP2 = [SKAction playSoundFileNamed:@"Sound/changeHP_woodenBasin_6.mp3" waitForCompletion:0];
    self.sound_ironBasinChangeHP0 = [SKAction playSoundFileNamed:@"Sound/changeHP_ironBasin_4.mp3" waitForCompletion:0];
    self.sound_ironBasinChangeHP1 = [SKAction playSoundFileNamed:@"Sound/changeHP_ironBasin_0.mp3" waitForCompletion:0];
    self.sound_normalChangeHP0 = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_0.mp3" waitForCompletion:0];
    self.sound_normalChangeHP1 = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_1.mp3" waitForCompletion:0];
    self.sound_normalChangeHP2 = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_2.mp3" waitForCompletion:0];
    self.sound_normalChangeHP3 = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_3.mp3" waitForCompletion:0];
    self.sound_normalChangeHP4 = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_4.mp3" waitForCompletion:0];
    self.sound_normalChangeHP5 = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_5.mp3" waitForCompletion:0];
    self.sound_normalChangeHP6 = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_6.mp3" waitForCompletion:0];
    self.sound_beNormal = [SKAction playSoundFileNamed:@"Sound/changeHP_chicken_normal_21.mp3" waitForCompletion:0];
    self.sound_chickenAttack0 = [SKAction playSoundFileNamed:@"Sound/chicken_say_0.mp3" waitForCompletion:0];
    self.sound_chickenAttack1 = [SKAction playSoundFileNamed:@"Sound/spoon_attack_0.mp3" waitForCompletion:0];
    self.sound_chickenAttack2 = [SKAction playSoundFileNamed:@"Sound/spoon_attack_1.mp3" waitForCompletion:0];
    self.sound_basinChickenAttack0 = [SKAction playSoundFileNamed:@"Sound/basinChicken_attack_0.mp3" waitForCompletion:0];
    self.sound_basinChickenAttack1 = [SKAction playSoundFileNamed:@"Sound/basinChicken_attack_1.mp3" waitForCompletion:0];
    self.sound_basinChickenAttack2 = [SKAction playSoundFileNamed:@"Sound/basinChicken_attack_2.mp3" waitForCompletion:0];
    self.sound_basinChickenAttack0 = [SKAction playSoundFileNamed:@"Sound/basinChicken_attack_0.mp3" waitForCompletion:0];
    self.sound_createJelly = [SKAction playSoundFileNamed:@"Sound/boxer_attack_6.mp3" waitForCompletion:0]; //soundCreateJelly.volume = 0.04;
}

-(NSArray *)newAtlas:(NSString *)atlasName
{
    return [self.staticAtlas objectForKey:atlasName];
}

-(NSArray *)preload_home;
{
//    return @[@"chicken_buff_die2",];
    return @[@"ui_main_about", @"ui_main_anime", @"ui_main_button", @"ui_main_round", @"ui_main_scenes"];
}

-(NSArray *)preload_game:(int)n;
{
//    return @[@"chicken_buff_die2",];
    //test 暂时去掉buff的预加载
    //@"chicken_buff_ice", @"chicken_buff_poison", @"chicken_buff_sleep", @"chicken_buff_slow",
    if (is500m) {
        return @[@"ui_games_mana", @"chicken_hp_blue_mini", @"chicken_buff_die2", @"ui_games_begin", @"ui_games_pick", @"ui_map_bigObj", @"ui_main_alert", @"ui_games_other", @"chicken_normal_attack", @"chicken_normal_move", @"jelly_energy_water_0", @"jelly_energy_water_1", @"jelly_energy_water_3", @"jelly_energy_water_4", @"jelly_energy_water_5", @"jelly_energy_waterRest_0", @"jelly_energy_waterRest_1", @"jelly_energy_waterRest_2", @"jelly_energy_waterRest_3", @"jelly_energy_waterRest_4",];
    }
    else {
        return @[@"ui_games_mana", @"chicken_hp_blue_mini", @"chicken_buff_die2", @"ui_games_begin", @"ui_games_pick", @"ui_map_bigObj", @"ui_main_alert", @"ui_games_other", @"chicken_normal_attack", @"chicken_normal_move", @"jelly_energy_water_0", @"jelly_energy_water_1", @"jelly_energy_water_3", @"jelly_energy_water_4", @"jelly_energy_water_5", @"jelly_energy_waterRest_0", @"jelly_energy_waterRest_1", @"jelly_energy_waterRest_2", @"jelly_energy_waterRest_3", @"jelly_energy_waterRest_4",
                 @"jelly_banana_rest", @"jelly_energy_reat_lawn", @"jelly_double_rest", @"jelly_slow_rest", @"jelly_shield_rest", @"jelly_boxer_rest", @"jelly_boom_rest", @"jelly_strom_rest", @"jelly_violent_rest",
                 @"jelly_highEnergy_rest_lawn", @"jelly_snail_rest", @"jelly_cure_rest", @"jelly_laser_rest",];
        
    }
}

-(NSArray *)preload_map;
{
//    return @[@"chicken_buff_die2",];
    if (is500m) {
        return @[@"ui_map_flay_3", @"ui_map_other", @"ui_map_obj", @"ui_map_jellyRest", @"ui_map_jellyMove",];
    }
    else {
        return @[@"ui_map_flay_3", @"ui_map_other", @"ui_map_obj", @"ui_map_jellyRest", @"ui_map_jellyMove",
                 @"jelly_banana_rest", @"jelly_energy_reat_lawn", @"jelly_double_rest", @"jelly_slow_rest", @"jelly_shield_rest", @"jelly_boxer_rest", @"jelly_boom_rest", @"jelly_strom_rest", @"jelly_violent_rest",
                 @"jelly_highEnergy_rest_lawn", @"jelly_snail_rest", @"jelly_cure_rest", @"jelly_laser_rest",];
    }
    
}

-(void)loadAtlas:(void (^) ())block;
{
    self.staticAtlas = [NSMutableDictionary dictionary];
//    NSArray *names = @[@"ui_main_loading", @"ui_main_loadingBar", @"allBullet", @"ui_games_down", @"jelly_violent_bullet", @"ui_games_goldRota",
//                       @"ui_games_cookRota", @"ui_games_hand", @"ui_book_lawn",
//                       @"ui_games_bottom", @"ui_games_free",
//                       @"jelly_banana_rest", @"jelly_energy_reat_lawn", @"jelly_double_rest", @"jelly_iceThin_rest",
//                       @"jelly_slow_rest", @"jelly_shield_rest", @"jelly_iceThron_rest", @"jelly_boxer_rest",
//                       @"jelly_boom_rest", @"jelly_strom_rest", @"jelly_violent_rest", @"jelly_highEnergy_rest_lawn",
//                       @"jelly_snail_rest", @"jelly_iceThick_rest", @"jelly_cure_rest", @"jelly_aoeBoom_rest",
//                       @"jelly_dizzy_rest", @"jelly_iceMist_rest_lawn", @"jelly_laser_rest", @"ui_games_mana"];
    
    NSArray *names = @[@"ui_games_goldRota",@"ui_main_loadingBar",];
    
    loadNumber = 0;
    needLoadNumber = (int)names.count -1;
    for (NSString *name in names) {
        [self addAtlas:name];
    };
    myBlock = block;
}

-(NSArray *)loadJellyChickenAtlas:(NSArray *)array
{
    NSMutableArray *muArray = [NSMutableArray array];
    for (NSString *name in array) {
        if ([name isEqualToString:@"aoeBoom"]) {
            [muArray addObject:@"jelly_aoeBoom_create"];
        }
        else if ([name isEqualToString:@"banana"]) {
            [muArray addObject:@"jelly_banana_attack"];
        }
        else if ([name isEqualToString:@"boom"]) {
            [muArray addObject:@"jelly_boom_die"];
            [muArray addObject:@"jelly_boom_create"];
        }
        else if ([name isEqualToString:@"boxer"]) {
            [muArray addObject:@"jelly_boxer_attack"];
        }
        else if ([name isEqualToString:@"cure"]) {
            [muArray addObject:@"jelly_cure_attack"];
            [muArray addObject:@"jelly_cure_magicCreateDie"];
        }
        else if ([name isEqualToString:@"dizzy"]) {
            [muArray addObject:@"jelly_dizzy_create"];
            [muArray addObject:@"jelly_dizzy_magicCreate"];
            [muArray addObject:@"jelly_dizzy_magicRest"];
        }
        else if ([name isEqualToString:@"double"]) {
            [muArray addObject:@"jelly_double_attack"];
        }
        else if ([name isEqualToString:@"energy"]) {
            [muArray addObject:@"jelly_energy_reat"];
        }
        else if ([name isEqualToString:@"highEnergy"]) {
            [muArray addObject:@"jelly_highEnergy_create"];
            [muArray addObject:@"jelly_highEnergy_rest"];
        }
        else if ([name isEqualToString:@"iceMist"]) {
            [muArray addObject:@"jelly_iceMist_breakRest"];
            [muArray addObject:@"jelly_iceMist_rest"];
        }
        else if ([name isEqualToString:@"iceThick"]) {
            [muArray addObject:@"jelly_iceThick_breakRest"];
        }
        else if ([name isEqualToString:@"iceThin"]) {
            [muArray addObject:@"jelly_iceThin_breakRest"];
        }
        else if ([name isEqualToString:@"iceThorn"]) {
            [muArray addObject:@"jelly_iceThron_breakRest"];
        }
        else if ([name isEqualToString:@"laser"]) {
            [muArray addObject:@"jelly_laser_bulletLeft"];
            [muArray addObject:@"jelly_laser_attackRight"];
            [muArray addObject:@"jelly_laser_attackLeft"];
        }
        else if ([name isEqualToString:@"shield"]) {
            [muArray addObject:@"jelly_shield_attack"];
            [muArray addObject:@"jelly_shield_magicCreate"];
            [muArray addObject:@"jelly_shield_magicDie"];
            [muArray addObject:@"jelly_shield_magicRest"];
        }
        else if ([name isEqualToString:@"slow"]) {
            [muArray addObject:@"jelly_slow_attack"];
            [muArray addObject:@"jelly_slow_magicCreate"];
            [muArray addObject:@"jelly_slow_magicDie"];
            [muArray addObject:@"jelly_slow_magicRest"];
        }
        else if ([name isEqualToString:@"snail"]) {
            [muArray addObject:@"jelly_snail_attack"];
        }
        else if ([name isEqualToString:@"strom"]) {
            [muArray addObject:@"jelly_strom_attack"];
            [muArray addObject:@"jelly_strom_attackStar"];
            [muArray addObject:@"jelly_strom_CDing"];
            [muArray addObject:@"jelly_strom_CDStar"];
        }
        else if ([name isEqualToString:@"violent"]) {
            [muArray addObject:@"jelly_violent_attack"];
        }

        else if ([name isEqualToString:@"bird"]) {
            [muArray addObject:@"ui_scene_anime_blueBird"];
            [muArray addObject:@"ui_scene_anime_redBird"];
            [muArray addObject:@"ui_scene_anime_yellowBird"];
        }
        else if ([name isEqualToString:@"cloud"]) {
            [muArray addObject:@"ui_scene_anime_cloud"];
        }
        else if ([name isEqualToString:@"rock"]) {
            [muArray addObject:@"ui_scene_anime_rock"];
        }
        else if ([name isEqualToString:@"blue"]) {
            [muArray addObject:@"scene_blue_background"];
            [muArray addObject:@"scene_blue_shadow"];
        }
        else if ([name isEqualToString:@"desert"]) {
            [muArray addObject:@"ui_scene_desert_background"];
        }
        else if ([name isEqualToString:@"forest"]) {
            [muArray addObject:@"ui_scene_forest_background"];
            [muArray addObject:@"ui_scene_anime_treeA"];
            [muArray addObject:@"ui_scene_anime_treeB"];
        }
        else if ([name isEqualToString:@"desert"]) {
            [muArray addObject:@"ui_scene_desert_background"];
        }
        else if ([name isEqualToString:@"fruit"]) {
            [muArray addObject:@"ui_scene_fruit_background"];
        }
        else if ([name isEqualToString:@"greed"]) {
            [muArray addObject:@"ui_scene_greed_background"];
        }
        else if ([name isEqualToString:@"lava"]) {
            [muArray addObject:@"ui_scene_lava_background"];
        }
        else if ([name isEqualToString:@"snow"]) {
            [muArray addObject:@"ui_scene_snow_background"];
        }
        else if ([name isEqualToString:@"lineMask"]) {
            [muArray addObject:@"ui_scene_obj_lineMask"];
        }
        else if ([name isEqualToString:@"burron"]) {
            [muArray addObject:@"ui_scene_obj_button"];
        }
        else if ([name isEqualToString:@"grass"]) {
            [muArray addObject:@"ui_scene_obj_grass"];
        }
        else if ([name isEqualToString:@"bounce"]) {
            [muArray addObject:@"ui_scene_obj_bounce"];
        }
        else {
            [muArray addObject:name];
        }
    }
    return muArray;
}


-(void)addAtlas:(NSString *)atlasName
{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName];
    int number = (int)atlas.textureNames.count;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:number];
    [atlas preloadWithCompletionHandler:^{
        for (int i = 0; i< number; i++) {
            NSString *fileName = [NSString stringWithFormat:@"%@_%d", atlasName, i];
            [array addObject:[atlas textureNamed:fileName]];
        }
        if ([self.staticAtlas objectForKey:atlasName]) {
            loadNumber++;
        }
        else {
            [self.staticAtlas setValue:array forKey:atlasName];
            loadNumber++;
        }
        if (loadNumber == needLoadNumber) {
            if (myBlock) myBlock();
        }
    }];
}


@end
