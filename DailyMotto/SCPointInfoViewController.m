//
//  SCPointInfoViewController.m
//  DailyMotto
//
//  Created by wupeng on 13-6-2.
//  Copyright (c) 2013年 Galiumsoft. All rights reserved.
//

#import "SCPointInfoViewController.h"

@interface SCPointInfoViewController ()
@property (nonatomic, retain) YouMiWall *wall;

@end

@implementation SCPointInfoViewController


- (void)viewDidLoad
{
    [self setTitle:SCLocale(@"积分规则")];
    self.wall = [YouMiWall new];
    self.wall.delegate = self;

    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointsGotted:) name:kYouMiPointsManagerRecivedPointsNotification object:nil];
	// Do any additional setup after loading the view.
}

-(IBAction)buttonClicked:(id)sender{
    [self.wall showOffers];
}

-(void)viewWillAppear:(BOOL)animated{
    [labelPoints setText:[NSString stringWithFormat:@"%d正能量",[YouMiPointsManager pointsRemained]]];
    [self.wall requestOffers:YES];
    [super viewWillAppear:animated];
}

- (void)didReceiveOffers:(YouMiWall *)adWall {
}

- (void)didFailToReceiveOffers:(YouMiWall *)adWall error:(NSError *)error {
}

- (void)pointsGotted:(NSNotification *)notification {
    NSDictionary *dict = [notification userInfo];
    NSNumber *freshPoints = [dict objectForKey:kYouMiPointsManagerFreshPointsKey];
    
    // 这里的积分不应该拿来使用, 只是用于告诉一下用户, 可以通过 [YouMiPointsManager spendPoints:]来使用积分
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:[NSString stringWithFormat:@"获得%@正能量", freshPoints] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
    
    labelPoints.text = [NSString stringWithFormat:@"当前积分: %d", [YouMiPointsManager pointsRemained]];
}

-(void)viewWillUnload{
    [super viewWillUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
