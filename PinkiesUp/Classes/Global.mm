//
//  Global.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Global.h"

@implementation Global

static float velocity = 0;

+ (float)velocity {
	return velocity;
}

+ (void)setVelocity:(float)v {
	velocity = v;
}

+ (id)alloc {
	[NSException raise:@"Cannot be instantiated!" format:@"Static class 'ClassName' cannot be instantiated!"];
	return nil;
}

@end
