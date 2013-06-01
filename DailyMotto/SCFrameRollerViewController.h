//
//  SCFrameRollerViewController.h
//  DailyMotto
//
//  Created by wupeng on 13-5-28.
//  Copyright (c) 2013年 Galiumsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCFrameRollerViewController : UIViewController{
    IBOutlet UIScrollView *_scorllView;
    NSMutableArray *imageViews;
    UIImageView *indicatorView;
}

@end
