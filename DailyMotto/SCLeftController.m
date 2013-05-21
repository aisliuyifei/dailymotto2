//
//  LeftController.m
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCLeftController.h"
#import "DDMenuController.h"
#import "SCMenuCell.h"
#import "ViewController.h"
#import "ADVTheme.h"
@implementation SCLeftController

@synthesize tableView=_tableView;

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [ADVThemeManager customizeTableView:self.tableView];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.tableView = nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"remove_ads"] boolValue]==YES) {
        return 6;
    }
    return 7;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    static NSString *CellIdentifier = @"SCMenuCell";
    SCMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[SCMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-element.png"]];
    
    switch (indexPath.row) {
        case 0:
            cell.imgIcon.image = [UIImage imageNamed:@"home.png"];
            cell.titleLabel.text = SCLocale(@"返回首页");
            break;
        case 1:
            cell.imgIcon.image = [UIImage imageNamed:@"share.png"];
            cell.titleLabel.text = SCLocale(@"分享设置");
            break;
        case 2:
            cell.imgIcon.image = [UIImage imageNamed:@"123.png"];
            cell.titleLabel.text = SCLocale(@"Workouts");
            break;
        case 3:
            cell.imgIcon.image = [UIImage imageNamed:@"alert.png"];
            cell.titleLabel.text = SCLocale(@"Notification");
            break;
        case 4:
            cell.imgIcon.image = [UIImage imageNamed:@"chart.png"];
            cell.titleLabel.text = SCLocale(@"Chart");
            break;
        case 5:
            cell.imgIcon.image = [UIImage imageNamed:@"profile.png"];
            cell.titleLabel.text = SCLocale(@"Feedback");
            break;
        case 6:
            cell.imgIcon.image = [UIImage imageNamed:@"cart.png"];
            cell.titleLabel.text = SCLocale(@"Remove ADs");
        default:
            break;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *imgBkg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchBackground.png"]];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 300, 22)];
    lblTitle.text = SCLocale(@"MENU");
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.00f];
    lblTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    [imgBkg addSubview:lblTitle];
    return imgBkg;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    // set the root controller
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    SCAppDelegate *delegate = (SCAppDelegate *)[UIApplication sharedApplication].delegate;
    DDMenuController *menuController = (DDMenuController*)((SCAppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    UIViewController *controller;
   
    switch (indexPath.row) {
        case 0:
            controller = [delegate.storyboard instantiateViewControllerWithIdentifier:@"navController"];
            break;
        case 1:
            controller = [delegate.storyboard instantiateViewControllerWithIdentifier:@"navSocial"];
            break;
        case 2:
            controller = [delegate.storyboard instantiateViewControllerWithIdentifier:@"navUserInfoViewController"];
            break;
            
//        case 2:
//            controller = [delegate.storyboard instantiateViewControllerWithIdentifier:@"navExcisesViewController"];
//            break;
//        case 3:
//            controller = [delegate.storyboard instantiateViewControllerWithIdentifier:@"navSettingViewController"];
//            break;
//
//        default:
//            controller = [delegate.storyboard instantiateViewControllerWithIdentifier:@"navController"];
//            break;
    }
    [menuController setRootController:controller animated:YES];
}

@end
