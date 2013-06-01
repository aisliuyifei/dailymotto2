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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointsGotted:) name:kYouMiPointsManagerRecivedPointsNotification object:nil];

    [ADVThemeManager customizeTableView:self.tableView];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.tableView = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (void)pointsGotted:(NSNotification *)notification {
    NSDictionary *dict = [notification userInfo];
    NSNumber *freshPoints = [dict objectForKey:kYouMiPointsManagerFreshPointsKey];
    
    // 这里的积分不应该拿来使用, 只是用于告诉一下用户, 可以通过 [YouMiPointsManager spendPoints:]来使用积分
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:[NSString stringWithFormat:@"获得%@正能量", freshPoints] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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
            cell.imgIcon.image = [UIImage imageNamed:@"frame.png"];
            cell.titleLabel.text = SCLocale(@"边框切换");
            break;
        case 3:
            cell.imgIcon.image = [UIImage imageNamed:@"cart.png"];
            
            cell.titleLabel.text = [NSString stringWithFormat:@"%@: %d正能量",SCLocale(@"我的积分"), [YouMiPointsManager pointsRemained]];
            
            break;
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
    UINavigationController *controller;
   
    switch (indexPath.row) {
        case 0:
            controller = [delegate.storyboard instantiateViewControllerWithIdentifier:@"navController"];
            delegate.viewController = [controller.viewControllers objectAtIndex:0];
            break;
        case 1:
            controller = [delegate.storyboard instantiateViewControllerWithIdentifier:@"navSocial"];
            break;
        case 2:
            controller = [delegate.storyboard instantiateViewControllerWithIdentifier:@"navFrameRollerController"];
            break;
        case 3:
            controller = [delegate.storyboard instantiateViewControllerWithIdentifier:@"navPointInfoViewController"];
            break;
        default:
            break;
    }
    [menuController setRootController:controller animated:YES];
}

@end
