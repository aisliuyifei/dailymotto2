//
//  SCFrameRollerViewController.h
//  DailyMotto
//
//  Created by wupeng on 13-5-28.
//  Copyright (c) 2013年 Galiumsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"

@interface SCFrameRollerViewController : AddViewController{
    IBOutlet UIScrollView *_scorllView;
    NSMutableArray *imageViews;
    UIImageView *indicatorView;
}

@end
