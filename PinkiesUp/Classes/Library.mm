//
//  Library.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Library.h"

@implementation Library

static int number = 0;

+ (int)getNumber {
	return number;
}

+ (void)setNumber:(int)newNumber {
	number = newNumber;
}

+ (id)alloc {
	[NSException raise:@"Cannot be instantiated!" format:@"Static class 'ClassName' cannot be instantiated!"];
	return nil;
}

/**
 * checks if a point is in a polygon
 * works for concave and convex polygons
 * @param nvert - number of verticies
 * @param vertx - array containing x verticies
 * @param verty - array containing y verticies
 * @param testx - x value of point to test
 * @param testy - y value of point to test
 * @return not sure, hoping 0 or 1
 * @source http://stackoverflow.com/questions/217578/point-in-polygon-aka-hit-test
 */
+ (int)isPointInPolygon :(int)nvert :(float *)vertx :(float *)verty :(float)testx :(float)testy {
	int i, j, c = 0;
	for (i = 0, j = nvert-1; i < nvert; j = i++) {
		if ( ((verty[i]>testy) != (verty[j]>testy)) &&
			(testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i]) )
			c = !c;
	}
	return c;
}

@end
