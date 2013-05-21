//
//  convertGB_BIG.m
//  myTest
//
//  Created by sffofn on 11-8-17.
//  Copyright 2011 keke.com. All rights reserved.
//

#import "convertGB_BIG.h"

@implementation convertGB_BIG
@synthesize string_GB = _string_GB;
@synthesize string_BIG5 = _string_BIG5;

-(void)dealloc
{
	[_string_GB release];
	[_string_BIG5 release];
	
	[super dealloc];
}

-(id)init
{
	if(self = [super init])
	{
		NSError *error;
		NSString *resourcePath = [ [NSBundle mainBundle] resourcePath];
		self.string_GB = [NSString stringWithContentsOfFile:[resourcePath stringByAppendingPathComponent:@"gb.txt"]
												   encoding:NSUTF8StringEncoding
													  error:&error];
		self.string_BIG5 = [NSString stringWithContentsOfFile:[resourcePath stringByAppendingPathComponent:@"big5.txt"]
												   encoding:NSUTF8StringEncoding
													  error:&error];
	}
	
	return self;
}


//简体转繁体 
-(NSString*)gbToBig5:(NSString*)srcString
{
	NSInteger length = [srcString length];
	for (NSInteger i = 0; i< length; i++)
	{
		NSString *string = [srcString substringWithRange:NSMakeRange(i, 1)];
		NSRange gbRange = [_string_GB rangeOfString:string];
		if(gbRange.location != NSNotFound)
		{
			NSString *big5String = [_string_BIG5 substringWithRange:gbRange];
			srcString = [srcString stringByReplacingCharactersInRange:NSMakeRange(i, 1)
											   withString:big5String];
		}
	}
	
	return srcString;
}

//繁体转简体
-(NSString*)big5ToGb:(NSString*)srcString
{
	NSInteger length = [srcString length];
	for (NSInteger i = 0; i< length; i++)
	{
		NSString *string = [srcString substringWithRange:NSMakeRange(i, 1)];
		NSRange big5Range = [_string_BIG5 rangeOfString:string];
		if(big5Range.location != NSNotFound)
		{
			NSString *gbString = [_string_GB substringWithRange:big5Range];
			srcString = [srcString stringByReplacingCharactersInRange:NSMakeRange(i, 1)
											   withString:gbString];
		}
	}
	
	return srcString;
}

@end
