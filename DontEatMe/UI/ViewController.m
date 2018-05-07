//
//  ViewController.m
//  DontEatMe
//
//  Created by ym on 14-7-2.
//  Copyright (c) 2014年 ym. All rights reserved.
//

#import "ViewController.h"
#import "LoadingScene.h"
#import "ShowAddCookGoldView.h"


@implementation ViewController
{
    void (^buyCallBack)();
//    void (^umShareCallBack)();
    NSString *buyTempType;
    int buyTmepNumber;
    NSString *productID;
}

+(ViewController *)single
{
    static ViewController *vc = nil;
    if (!vc) {
        vc = [[ViewController alloc] init];
    }
    return vc;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.skview = [[SKView alloc] initWithFrame:self.view.bounds];
    self.skview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.skview];
    
//    [self testQuickGame];
    [self gotoWelcomeScene];
    
    // test 各种进入场景的方法
//    [self testQuickGame];
//    [self gotoHomeScene];
//    [self gotoMapScene:9];
//    [self gotoGameScene:4 classString:@"first"];  //1017
    
//    self.homeScene = [HomeScene sceneWithSize:CGSizeMake(iw, ih)];
//    [self.skview presentScene:self.homeScene];
    
//    self.gameScene = [GameScene createWithNumber:4];
//    [self.skview presentScene:self.gameScene];
//    [self.gameScene createWar];
    
//    self.mapScene = [MapScene createMapWithWin:9];
//    [self.skview presentScene:self.mapScene];
    
//    StaticActions *sa = [StaticActions single];
//    AtlasController *atlasController = [AtlasController single];
//    [atlasController loadAtlas:[sa preload_map] completion:^{
//        
//    }];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    
    //缩放ipad
    float theWidth = [[UIScreen mainScreen] currentMode].size.width;  //768, 1536
    if (theWidth == 768 || theWidth == 1536 || theWidth == 1024 || theWidth == 2048) {
        self.skview.transform = CGAffineTransformMakeScale(1.13, 1);
    }
}

//test
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.skview.paused == YES) {
        self.skview.paused = NO;
    }
    
    return;
    SKScene *scene = [SKScene sceneWithSize:CGSizeMake(iw, ih)];
    [self.skview presentScene:scene];
    AtlasController *ac = [AtlasController single];
    [ac clearAtlas:nil];

    [self.homeScene removeFromParent];
    self.homeScene = nil;
    [self.mapScene removeFromParent];
    self.mapScene = nil;
    [self.gameScene removeFromParent];
    self.gameScene = nil;

    
    StaticActions *sa = [StaticActions single];
    [sa clearActions];
    sa = nil;
    
//    [self.skview removeFromSuperview];
//    self.skview = nil;
}

-(void)testQuickGame
{
    [UserCenter createDic];
    StaticActions *staicActions = [StaticActions single];
    AtlasController *ac = [AtlasController single];
    [ac loadAtlas:[staicActions preload_home] completion:^{
        [staicActions loadAtlas:^{
            
            [UserCenter createDic];
            [[UserCenter dic] setValue:@(8) forKey:@"pickNum"];
            [[UserCenter dic] setValue:@[@"banana", @"energy", @"iceThin", @"shield", @"double", @"slow",
                                         @"boom", @"boxer", @"highEnergy", @"dizzy", @"iceThick", @"strom",
                                         @"laser", @"cure", @"iceMist", @"aoeBoom", @"snail", @"iceThorn", @"violent"] forKey:@"haveJellys"];
            [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:@"highEnergy"] setValue:@0 forKey:@"price"];
            [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:@"boxer"] setValue:@0 forKey:@"price"];
            [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:@"strom"] setValue:@0 forKey:@"price"];
            [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:@"iceMist"] setValue:@0 forKey:@"price"];
            [[[[UserCenter dic] objectForKey:@"jellyData"] objectForKey:@"snail"] setValue:@0 forKey:@"price"];
            [[[UserCenter dic] objectForKey:@"userRecord"] setValue:@1 forKey:@"whistle"];
            [[[UserCenter dic] objectForKey:@"noHaveJellys"] removeAllObjects];
            [UserCenter save];
            _isInTheScene = NO;
            [self gotoGameScene:1 classString:@"first"];  //1017
        }];
    }];
}

-(void)gotoWelcomeScene
{
    [UserCenter createDic];
    self.welcomScene = [WelcomScene sceneWithSize:CGSizeMake(iw, ih)];
    [self.skview presentScene:self.welcomScene];
}

-(void)firstGotoHomeScene
{
    self.homeScene = [HomeScene sceneWithSize:CGSizeMake(iw, ih)];
    [self.skview presentScene:self.homeScene];
    
    [self.welcomScene removeFromParent];
    self.welcomScene = nil;
}

-(void)testAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"测试包"
                                                    message:@"您好，测试包只开放前24关。"
                                                   delegate:self
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil,nil];
    [alert show];
}

-(void)gotoHomeScene
{
    if (_isInTheScene == YES) return;
    _isInTheScene = YES;
    
    StaticActions *sa = [StaticActions single];
    LoadingScene *loading = [LoadingScene createAtlas:[sa preload_home] block:^{
        self.homeScene = [HomeScene sceneWithSize:CGSizeMake(iw, ih)];
        [self.skview presentScene:self.homeScene];
    }];
    [self.skview presentScene:loading];
    [self.mapScene removeFromParent];
    self.mapScene = nil;
    
    
}

-(void)gotoMapScene:(int)isWin;
{
    if (_isInTheScene == YES) return;
    _isInTheScene = YES;
    self.isLastWin = isWin;
    StaticActions *sa = [StaticActions single];
    LoadingScene *loading = [LoadingScene createAtlas:[sa preload_map] block:^{
        self.mapScene = [MapScene createMapWithWin:isWin];
        [self.skview presentScene:self.mapScene];
    }];
    [self.skview presentScene:loading];
    
    [self.gameScene  removeFromParent];
    self.gameScene = nil;
    [self.homeScene  removeFromParent];
    self.homeScene = nil;
}

-(void)gotoGameScene:(int)number classString:(NSString *)classString;
{
    if (_isInTheScene == YES) return;
    _isInTheScene = YES;
    
    StaticActions *sa = [StaticActions single];
    LoadingScene *loading = [LoadingScene createAtlas:[sa preload_game:number] block:^{
        self.gameScene = [GameScene createWithNumber:number];
        [self.skview presentScene:self.gameScene];
        if (![classString isEqualToString:@"first"]) {
            self.gameScene.isAgainClass = 1;
        }
        [self.gameScene createWar];
    }];
    [self.skview presentScene:loading];
    
    [self.mapScene removeFromParent];
    self.mapScene = nil;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)buyAlertWithTitle:(NSString *)title message:(NSString *)message type:(NSString *)type number:(int)number callBack:(void (^)())callBack;
{
    buyCallBack = callBack;
    buyTempType = type;
    buyTmepNumber = number;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:iString(@"Cancel") otherButtonTitles:@"Buy", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
    }
    if (buttonIndex == 1) {
        
        [self purchaseFunc:self]; //test 内付费
        
        if ([buyTempType isEqualToString:@"gold"]) {
            return;     //test 测试包不给购买金币
            ShowAddCookGoldView *addGoldView = [ShowAddCookGoldView createWithIsGold:YES number:buyTmepNumber backCall:nil];
            addGoldView.position = CGPointMake(iw/2, ih/2);
            if (self.mapScene) {
                [self.mapScene addChild:addGoldView];
            }
            else if (self.gameScene) {
                [self.gameScene addChild:addGoldView];
            }
        }
        else if ([buyTempType isEqualToString:@"cook"]) {
            ShowAddCookGoldView *addGoldView = [ShowAddCookGoldView createWithIsGold:NO number:buyTmepNumber backCall:nil];
            addGoldView.position = CGPointMake(iw/2, ih/2);
            if (self.mapScene) {
                [self.mapScene addChild:addGoldView];
            }
            else if (self.gameScene) {
                [self.gameScene addChild:addGoldView];
            }
        }
        else if ([buyTempType isEqualToString:@"maxCookTime"]) {
            [UserCenter addMaxCookTime:buyTmepNumber];
            [UserCenter addMaxCook];
        }
        else if ([buyTempType isEqualToString:@"fishFarmOpen"]) {
            NSDate *nowTime = [[NSDate alloc] init];
            [[UserCenter dic] objectForKey:@"fishFarm"][0][1] = nowTime;
            [[UserCenter dic] objectForKey:@"fishFarm"][0][0] = @1;
        }
        
        if (self.mapScene.topBar) {
            [self.mapScene.topBar reloadLabel:nil];
        }
        else if (self.gameScene.topBar) {
            [self.gameScene.topBar reloadLabel:nil];
        }
        
        if (buyCallBack) {
            buyCallBack();
        }
    }
}


// !!!:内付费
-(void)purchaseFunc:(id)sender
{
    productID = @"DontEatMe_BuyGolds_150";
    if ([SKPaymentQueue canMakePayments]) {
        [self requestProductData:productID];
    }
    else {
        NSLog(@"不允许内付费");
    }
}

//请求商品
-(void)requestProductData:(NSString *)type
{
    NSLog(@"-------------请求对应的产品信息----------------");
    NSArray *product = [[NSArray alloc] initWithObjects:type, nil];
    NSSet *theSet = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:theSet];
    request.delegate = self;
    [request start];
}

//收到产品返回信息
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if (product.count == 0) {
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%d", (int)product.count);
    
    SKProduct *p = nil;
    
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        if ([pro.productIdentifier isEqualToString:productID]) {
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//请求失败
-(void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"---------------------错误--------------------:%@", error);
}

//请求结束
- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------");
}

//监听购买结果
-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *tran in transactions) {
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"交易完成");
                
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
                
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
                
                break;
            default:
                break;
        }
    }
}

//交易结束
-(void)completTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"交易结束");
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}



@end














