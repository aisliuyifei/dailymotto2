//
//  ViewController.h
//  DailyMotto
//
//  Created by 鹏 吴 on 3/20/12.
//  Copyright (c) 2012 galiumsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FXLabel.h"
#import "ScrachViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "AddViewController.h"
#import "convertGB_BIG.h"
#import "UMSocialDataDelegate.h"

@interface ViewController : AddViewController<MFMailComposeViewControllerDelegate, UIAlertViewDelegate,UMSocialUIDelegate,UIActionSheetDelegate>
{
    IBOutlet FXLabel *labelTitle;
    IBOutlet FXLabel *labelTest;
    IBOutlet FXLabel *labelDate;
    UIActivityIndicatorView *indicatorView;

    ScrachViewController *scratchViewController;
    UIView* scratchView;
    IBOutlet UIButton *buttonInfo;
    IBOutlet UIView *viewScrachContainer;
    IBOutlet UISegmentedControl *segmentControl;
    convertGB_BIG *_convertor;
    UMSocialData *_socialData;
    UMSocialControllerService *_socialController;
}
-(IBAction)infoSelected:(id)sender;

-(IBAction)segmentValueChanged:(id)sender;
@end
