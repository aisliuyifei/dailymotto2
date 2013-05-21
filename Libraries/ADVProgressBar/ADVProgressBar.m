//
//  ADVPopoverProgressBar.m
//  ADVPopoverProgressBar
//
//
/*
 The MIT License
 
 Copyright (c) 2011 Tope Abayomi
 http://www.appdesignvault.com/
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#define LEFT_PADDING 5.0f
#define RIGHT_PADDING 3.0f
#define PERCENT_VIEW_WIDTH 29.0f
#define MIN_WIDTH 10.0f

#import "ADVProgressBar.h"
#import "SCAppDelegate.h"
#import "ADVTheme.h"

@implementation ADVProgressBar

@synthesize progress;


- (id)initWithFrame:(CGRect)frame {    
    if (self = [super initWithFrame:frame]) {
        id <ADVTheme> theme = [ADVThemeManager sharedTheme];
        
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [bgImageView setImage:[theme progressTrackImage]];
        [self addSubview:bgImageView];
        
        progressFillImage = [theme progressProgressImage];
        CGSize fillImageSize = progressFillImage.size;
        progressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, fillImageSize.width, fillImageSize.height)];
        [self addSubview:progressImageView];
                
        //self.progress = 0.0f;
    }
    
    return self;
}


- (void)setProgress:(CGFloat)theProgress {
    
    if (self.progress != theProgress) {        
        if (theProgress >= 0 && theProgress <= 1) {            
            progress = theProgress;
            
            progressImageView.image = progressFillImage;
            
            CGRect frame = progressImageView.frame;
            
            CGFloat width = (bgImageView.frame.size.width - 4 - MIN_WIDTH) * progress;
            width += MIN_WIDTH;
            
            float percentage = progress*100;
            BOOL display = percentage == 0;
            
            frame.size.width = width;
            
            progressImageView.frame = CGRectIntegral(frame);
            progressImageView.hidden = display;            
        }
    }
}


@end
