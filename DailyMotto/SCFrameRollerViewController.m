//
//  SCFrameRollerViewController.m
//  DailyMotto
//
//  Created by wupeng on 13-5-28.
//  Copyright (c) 2013年 Galiumsoft. All rights reserved.
//

#import "SCFrameRollerViewController.h"

@interface SCFrameRollerViewController ()

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
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:index] forKey:kFrameIndex];
    [self updateIndicator];
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
