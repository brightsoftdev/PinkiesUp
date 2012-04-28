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
+ (int)IsPointInPolygon :(int)nvert :(float *)vertx :(float *)verty :(float)testx :(float)testy {
	int i, j, c = 0;
	for (i = 0, j = nvert-1; i < nvert; j = i++) {
		if ( ((verty[i]>testy) != (verty[j]>testy)) &&
			(testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i]) )
			c = !c;
	}
	return c;
}

/** draw a filled polygon to the screen */
/* example:
	- (void)draw {
		glColor4f(0.0f, 1.0f, 0.0f, 1.0f);
		CGSize s = CGSizeMake(150, 200);
		CGPoint vertices[4]={
		ccp(50,50),ccp(s.width,0),
		ccp(s.width,s.height),ccp(0,s.height),
	};
	ccFillPoly(vertices, 4, YES);
*/
// todo: should extend ccDrawPrimitives
+ (void)ccFillPoly :(CGPoint *)poli :(int)points :(BOOL)closePolygon;
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states: GL_VERTEX_ARRAY,
	// Unneeded states: GL_TEXTURE_2D, GL_TEXTURE_COORD_ARRAY, GL_COLOR_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	
	glVertexPointer(2, GL_FLOAT, 0, poli);
	if( closePolygon )
		//	 glDrawArrays(GL_LINE_LOOP, 0, points);
		glDrawArrays(GL_TRIANGLE_FAN, 0, points);
	else
		glDrawArrays(GL_LINE_STRIP, 0, points);
	
	// restore default state
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
}

@end
