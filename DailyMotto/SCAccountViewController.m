//
//  SCAccountViewController.m
//  DailyMotto
//
//  Created by wupeng on 13-5-20.
//  Copyright (c) 2013年 Galiumsoft. All rights reserved.
//

#import "SCAccountViewController.h"

@interface SCAccountViewController ()

@end

@implementation SCAccountViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"分享设置"];
    _socialData = [UMSocialData defaultData];
    _socialUIController = [[UMSocialControllerService alloc] initWithUMSocialData:_socialData];
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)buttonClicked:(id)sender{
    UINavigationController *accountViewController =[_socialUIController getSocialAccountController];

    [self presentModalViewController:accountViewController animated:YES];

}

@end
