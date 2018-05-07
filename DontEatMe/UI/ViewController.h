//
//  ViewController.h
//  DontEatMe
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "WelcomScene.h"
#import "HomeScene.h"
#import "MapScene.h"
#import "GameScene.h"
#import "Shop.h"
#import "Book.h"

@interface ViewController : UIViewController<UITextFieldDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic) SKView *skview;
@property (nonatomic) HomeScene *homeScene;
@property (nonatomic) WelcomScene *welcomScene;
@property (nonatomic) MapScene *mapScene;
@property (nonatomic) GameScene *gameScene;
@property (nonatomic) Shop *shop;
@property (nonatomic) Book *book;
@property (nonatomic) BOOL isInTheScene;
@property (nonatomic) int isLastWin;

+(ViewController *)single;
-(void)gotoHomeScene;
-(void)gotoMapScene:(int)isWin;
-(void)gotoGameScene:(int)number classString:(NSString *)classString;
-(void)gotoWelcomeScene;
-(void)firstGotoHomeScene;
-(void)buyAlertWithTitle:(NSString *)title message:(NSString *)message type:(NSString *)type number:(int)number callBack:(void (^)())callBack;

-(void)testAlert;


@end
