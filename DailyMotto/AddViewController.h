//
//  AddViewController.h
//
//  Created by 鹏 吴 on 4/11/12.
//  Copyright (c) 2012 galiumsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "SCAppDelegate.h"
#import "GADBannerView.h"
#import "YouMiWallBanner.h"
#import "YouMiWall.h"
@interface AddViewController : UIViewController<ADBannerViewDelegate>
{
//    ADBannerView *bannerView;
//    GADBannerView *gAdBannerView;
    YouMiWallBanner *youmiBanner;

}
- (void)layoutAnimated:(BOOL)animated;

@end
