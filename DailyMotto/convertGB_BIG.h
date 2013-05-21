//
//  convertGB_BIG.h
//  myTest
//
//  Created by sffofn on 11-8-17.
//  Copyright 2011 keke.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface convertGB_BIG : NSObject {
	NSString*	_string_GB;
	NSString*	_string_BIG5;
}

@property(nonatomic, retain) NSString*	string_GB;
@property(nonatomic, retain) NSString*	string_BIG5;

-(NSString*)gbToBig5:(NSString*)srcString;
-(NSString*)big5ToGb:(NSString*)srcString;

@end
