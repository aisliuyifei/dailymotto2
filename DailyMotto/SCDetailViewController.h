//
//  SCDetailViewController.h
//  DailyMotto
//
//  Created by wupeng on 13-5-20.
//  Copyright (c) 2013年 Galiumsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
