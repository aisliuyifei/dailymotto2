//
//  ADVRoundProgressView.m
//  Fitpulse
//
//  Created by Valentin Filip on 8/31/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "ADVRoundProgressView.h"
#import "CERoundProgressView.h"
#import "UIImage+iPhone5.h"


@interface ADVRoundProgressView ()

@property (nonatomic, strong) CERoundProgressView   *pieView;
@property (nonatomic, strong) UIImageView           *imgView;
@property (nonatomic, strong) UILabel               *lblValue;

- (void)_initIVars;

@end




@implementation ADVRoundProgressView

@synthesize pieView;
@synthesize piePadding;
@synthesize imgView;
@synthesize lblValue;
@synthesize progress;
@synthesize image;
@synthesize fontSize;
@synthesize tintColor;


#pragma mark - View lifecycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initIVars];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self _initIVars];
    }
    return self;
}

- (void)_initIVars {
    self.backgroundColor = [UIColor clearColor];
    
    self.pieView = [[CERoundProgressView alloc] initWithFrame:self.bounds];
    self.pieView.tintColor = self.tintColor;
    self.pieView.startAngle = M_PI/2;
    [self addSubview:self.pieView];
    
    self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imgView.image = [UIImage tallImageNamed:@"progress-circle-large"];
    [self addSubview:self.imgView];
    
    self.lblValue = [[UILabel alloc] initWithFrame:self.bounds];
    lblValue.backgroundColor = [UIColor clearColor];
    lblValue.textAlignment = NSTextAlignmentCenter;
    lblValue.font = [UIFont fontWithName:@"DINPro-CondBold" size:60.0f];
    lblValue.textColor = [UIColor colorWithRed:0.70f green:0.70f blue:0.70f alpha:1.00f];
    lblValue.shadowColor = [UIColor whiteColor];
    lblValue.shadowOffset = CGSizeMake(0, 1);
    [self addSubview:self.lblValue];
    
    
    self.piePadding = 1.5;
}


#pragma mark - Accessors

- (void)setProgress:(float)newProgress {
    if (newProgress < 0) {
        newProgress = 0.0;
    } else if(newProgress > 1.0) {
        newProgress = 1.0;
    }
    
    if (progress == newProgress) {
        return;
    }
    
    progress = newProgress;
    self.pieView.progress = progress;
    self.lblValue.text = [NSString stringWithFormat:@"%2.0f%%", progress*100];
}

- (void)setFontSize:(float)newFontSize {
    if (fontSize == newFontSize) {
        return;
    }
    
    fontSize = newFontSize;
    self.lblValue.font = [UIFont fontWithName:self.lblValue.font.fontName size:fontSize];
}

- (void)setImage:(UIImage *)newImage {
    if ([image isEqual:newImage]) {
        return;
    }
    
    image = newImage;
    self.imgView.image = image;
}

- (void)setTintColor:(UIColor *)newTintColor {
    if ([tintColor isEqual:newTintColor]) {
        return;
    }
    
    tintColor = newTintColor;
    self.pieView.tintColor = tintColor;
}

- (void)setPiePadding:(float)newPiePadding {
    if (piePadding == newPiePadding) {
        return;
    }
    
    piePadding = newPiePadding;
    CGRect pieFrame = self.bounds;
    pieFrame.origin.x = piePadding;
    pieFrame.origin.y = piePadding;
    pieFrame.size.width -= 2*pieFrame.origin.x;
    pieFrame.size.height -= 2*pieFrame.origin.y;
    
    self.pieView.frame = pieFrame;
}


@end
