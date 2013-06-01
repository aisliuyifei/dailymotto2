//
//  SCAppDelegate.h
//  DailyMotto
//
//  Created by wupeng on 13-5-20.
//  Copyright (c) 2013年 Galiumsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"
#import "UMFeedback.h"
#import "UMSocialData.h"
#import "UMSocialControllerService.h"
#import "WXApi.h"
#import "DDMenuController.h"
#define SCLocale(x,...) NSLocalizedString(x, nil)
#define kFrameIndex @"kFrameIndex"
#define kReviewed @"Reviewed"
#define nFrames 11
#define kLaunchCount @"launchCount"
#define APP_STORE_APP_ID @"526349543"

#define YOUMI_ID @"d0bd8a2f1fe82032"
#define YOUMI_KEY @"b5ce95be5322ca26"
#import "YouMiConfig.h"
#import "YouMiSpot.h"
#import "YouMiPointsManager.h"
@class ViewController;

@interface SCAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) DDMenuController *menuController;
@property (strong, nonatomic) UIStoryboard *storyboard;

-(NSString*)dbPath;

@end
