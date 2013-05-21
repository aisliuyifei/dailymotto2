//
//  SCAccountViewController.h
//  DailyMotto
//
//  Created by wupeng on 13-5-20.
//  Copyright (c) 2013年 Galiumsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCAppDelegate.h"
#import "AddViewController.h"
@interface SCAccountViewController : AddViewController{
    UMSocialData *_socialData;
    UMSocialControllerService *_socialUIController;
}

@end
