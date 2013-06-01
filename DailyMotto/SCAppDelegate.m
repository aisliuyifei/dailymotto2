//
//  SCAppDelegate.m
//  DailyMotto
//
//  Created by wupeng on 13-5-20.
//  Copyright (c) 2013年 Galiumsoft. All rights reserved.
//

#import "SCAppDelegate.h"
#define UMENG_KEY @"5199eabc56240bb64307fb7d"
#import "SCLeftController.h"
//#define UMENG_KEY @"5110ae04527015686d00001a" //rid
#import "ViewController.h"
#import "ADVTheme.h"
#import "UMSocialSnsService.h"
@implementation SCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    _storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UINavigationController *navigationController = (UINavigationController *)[_storyboard instantiateViewControllerWithIdentifier:@"navController"];
    self.viewController = [navigationController.viewControllers objectAtIndex:0];
    
    [self createEditableCopyOfDatabaseIfNeeded];
    [navigationController setNavigationBarHidden:NO];
    
    DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:navigationController];
    _menuController = rootController;
    
    SCLeftController *leftController = (SCLeftController *)[_storyboard instantiateViewControllerWithIdentifier:@"leftController" ];
    rootController.leftViewController = leftController;
    rootController.rightViewController = nil;
    self.window.rootViewController = _menuController;
    
    [self.window makeKeyAndVisible];
    [self setupUmeng];
    [WXApi registerApp:@"wx99d07ed906cd47b1"];
    [ADVThemeManager customizeAppAppearance];
    if (![[NSUserDefaults standardUserDefaults] valueForKey:kFrameIndex]) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:0] forKey:kFrameIndex];
    }
    return YES;
}
-(void)setupUmeng{
    [MobClick startWithAppkey:UMENG_KEY reportPolicy:(ReportPolicy) REALTIME channelId:@"App Store"];
    [MobClick updateOnlineConfig];
    [UMFeedback checkWithAppkey:UMENG_KEY];
    [UMSocialData setAppKey:UMENG_KEY];
    [UMSocialData openLog:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(umCheck:) name:UMFBCheckFinishedNotification object:nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"2661882060",UMShareToSina,nil];
    [UMSocialConfig setFollowWeiboUids:dictionary];
    [UMSocialControllerService defaultControllerService].socialData.extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger launchCount = [prefs integerForKey:kLaunchCount];
    launchCount++;
    [prefs setInteger:launchCount  forKey:kLaunchCount];
    if ([[MobClick getConfigParams:@"RateAlert"] intValue]==1) {
        if ( launchCount!=0 && (launchCount%4==0))
            [self rateApp];
    }

}
- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"mottos_db"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success){
        NSLog(@"Do not need to copy db");
        return;
    }
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"mottos_db"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self.viewController viewWillAppear:NO];
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
-(NSString*)dbPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"mottos_db"];
    return writableDBPath;
}
							
- (void)rateApp {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![prefs boolForKey:kReviewed]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"亲，给个评价吧", nil)  message:NSLocalizedString(@"你喜欢这个app吗? 给我\n★★★★★吧!\n或者你有什么好的建议，写给我吧.", nil)  delegate:self cancelButtonTitle:NSLocalizedString(@"才不要咧!", nil)  otherButtonTitles:NSLocalizedString(@"马上就去!",nil) , nil];
        [alertView show];
    }
}
- (void)alertView:(UIAlertView *)alertView_ clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setBool:YES forKey:@"Reviewed"];
        [alertView_ dismissWithClickedButtonIndex:buttonIndex animated:YES];
        NSString* url = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", APP_STORE_APP_ID];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
}

- (void)umCheck:(NSNotification *)notification {
//    if (notification.userInfo) {
//        UIAlertView *alertView;
//        NSArray * newReplies = [notification.userInfo objectForKey:@"newReplies"];
//        NSLog(@"newReplies = %@", newReplies);
//        NSString *title = [NSString stringWithFormat:@"有%d条新回復", [newReplies count]];
//        NSMutableString *content = [NSMutableString string];
//        for (int i = 0; i < [newReplies count]; i++) {
//            NSString * dateTime = [[newReplies objectAtIndex:i] objectForKey:@"datetime"];
//            NSString *_content = [[newReplies objectAtIndex:i] objectForKey:@"content"];
//            [content appendString:[NSString stringWithFormat:@"%d .......%@.......\r\n", i+1,dateTime]];
//            [content appendString:_content];
//            [content appendString:@"\r\n\r\n"];
//        }
//        
////        alertView = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
////        ((UILabel *) [[alertView subviews] objectAtIndex:1]).textAlignment = NSTextAlignmentLeft ;
////        [alertView show];
//        
//    }else{
//        //        alertView = [[UIAlertView alloc] initWithTitle:@"没有新回復" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
@end
