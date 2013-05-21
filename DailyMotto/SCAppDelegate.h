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

@class ViewController;

@interface SCAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) DDMenuController *menuController;
@property (strong, nonatomic) UIStoryboard *storyboard;

-(NSString*)dbPath;

@end
