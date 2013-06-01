//
//  AddViewController.m
//  便利记事贴
//
//  Created by 鹏 吴 on 4/11/12.
//  Copyright (c) 2012 galiumsoft. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addYoumiBanner];
    // Do any additional setup after loading the view from its nib.
}

-(void)addYoumiBanner{
    youmiBanner = [[YouMiWallBanner alloc] initRewarded:YES unit:@"正能量"];
    youmiBanner.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationBackground@2x_.png"]];

}

-(void)viewWillAppear:(BOOL)animated{
    [youmiBanner setFrame:CGRectMake(0.0,
                                     self.view.frame.size.height -
                                     GAD_SIZE_320x50.height,
                                     GAD_SIZE_320x50.width,
                                     GAD_SIZE_320x50.height)];
    [self.view bringSubviewToFront:youmiBanner];
    [self.view addSubview:youmiBanner];
    [super viewWillAppear:animated];
}

@end
