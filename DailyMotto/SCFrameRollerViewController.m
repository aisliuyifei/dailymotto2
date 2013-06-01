//
//  SCFrameRollerViewController.m
//  DailyMotto
//
//  Created by wupeng on 13-5-28.
//  Copyright (c) 2013年 Galiumsoft. All rights reserved.
//

#import "SCFrameRollerViewController.h"

@interface SCFrameRollerViewController ()
{
    int currentSelectedIndex;
}
@end

@implementation SCFrameRollerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageViews = [[NSMutableArray alloc] initWithCapacity:nFrames];
    [self setTitle:SCLocale(@"边框切换")];
    int margin =20,size = 80;
    int x = margin,y = margin;
    for (int i =0;i<nFrames;i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, size, size)];
        imageView.tag = i;
        NSString *imageName = [NSString stringWithFormat:@"frame_%03d.png",i];
        imageView.image = [UIImage imageNamed:imageName];
        [imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped:)];
        [imageView addGestureRecognizer:tapGestureRecognizer];
        [imageViews addObject:imageView];
        [_scorllView addSubview:imageView];
        if (i%3 == 2 && i!=nFrames-1) {
            x = margin;
            y += size+margin;
        }else{
            x += size+margin;
        }
        [_scorllView setContentSize:CGSizeMake(320, y+size+margin)];
    }
    [self addCurrentSelectedIndicator];
}

-(void)taped:(UITapGestureRecognizer *)tapedGestureRecognizer{
    NSLog(@"taped");
    int index = [tapedGestureRecognizer view].tag;
    currentSelectedIndex = index;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:kFrameIndex] intValue]!=index) {

        if ([YouMiPointsManager pointsRemained]>=1) {
            NSString *msg = [NSString stringWithFormat:@"更换边框需需要消耗1点正能量，\n您当前剩余积分：%d正能量\n是否确认继续？",[YouMiPointsManager pointsRemained]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"积分消耗" message:msg delegate:self cancelButtonTitle:@"不了" otherButtonTitles:@"确认", nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"积分不够" message:@"更换边框需要消耗1点正能量,您当前正能量点数不太够哦。" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            [alert show];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [YouMiPointsManager spendPoints:1];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:currentSelectedIndex] forKey:kFrameIndex];
        [self updateIndicator];
    }
    if ([YouMiPointsManager pointsRemained]<1 &&buttonIndex==0) {
        [YouMiSpot showSpotDismiss:^{
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [_scorllView setFrame:CGRectMake(_scorllView.frame.origin.x, _scorllView.frame.origin.y, _scorllView.frame.size.width, _scorllView.frame.size.height-50)];
}

-(void) addCurrentSelectedIndicator{
    indicatorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [indicatorView setImage: [UIImage imageNamed:@"overlay.png"]];
    
    int selectedIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:kFrameIndex] intValue];
    [[imageViews objectAtIndex:selectedIndex] addSubview:indicatorView];
}

-(void)updateIndicator{
    int selectedIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:kFrameIndex] intValue];
    [[imageViews objectAtIndex:selectedIndex] addSubview:indicatorView];

}

@end
