//
//  ADVRoundProgressView.h
//  Fitpulse
//
//  Created by Valentin Filip on 8/31/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADVRoundProgressView : UIView

@property (nonatomic)           float    progress;
@property (nonatomic)           float    piePadding;
@property (nonatomic)           float    fontSize;
@property (nonatomic, strong)   UIImage *image;
@property (nonatomic, retain) UIColor *tintColor UI_APPEARANCE_SELECTOR;

@end
