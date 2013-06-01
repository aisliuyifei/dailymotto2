//
//  SCPointInfoViewController.h
//  DailyMotto
//
//  Created by wupeng on 13-6-2.
//  Copyright (c) 2013年 Galiumsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"
@interface SCPointInfoViewController : AddViewController<YouMiWallDelegate>{
    IBOutlet UILabel *labelPoints;
}

-(IBAction)buttonClicked:(id)sender;
@end
