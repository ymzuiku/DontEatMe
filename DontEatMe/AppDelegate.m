//
//  AppDelegate.m
//  DontEatMe
//
//  Created by ymMac on 14-9-19.
//  Copyright (c) 2014年 ymMac. All rights reserved.
//

#import "AppDelegate.h"



@interface AppDelegate ()
{
    SK_BackgroundSound *music_BG;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.vc = [ViewController single];
    self.window.rootViewController = self.vc;
    [self.window makeKeyAndVisible];
    music_BG = [SK_BackgroundSound singleton];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
//    NSLog(@"applicationWillResignActive");
     self.vc.skview.paused = YES;
    [music_BG stopSound];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //NSLog(@"applicationDidEnterBackground");
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition fromthe changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
//    NSLog(@"applicationDidBecomeActive");
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    self.vc.skview.paused = NO;
    [music_BG playSound];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
//    NSLog(@"application:(UIApplication *)application handleOpenURL:(NSURL *)url");
    return YES;
}
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return  [UMSocialSnsService handleOpenURL:url];
//}

@end
