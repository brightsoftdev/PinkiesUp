//
//  Library.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Library.h"

@implementation Library

+ (id)alloc {
	[NSException raise:@"Cannot be instantiated!" format:@"Static class 'ClassName' cannot be instantiated!"];
	return nil;
}

+ (int)IsPointInPolygon :(int)nvert :(float *)vertx :(float *)verty :(float)testx :(float)testy {
	int i, j, c = 0;
	for (i = 0, j = nvert-1; i < nvert; j = i++) {
		if ( ((verty[i]>testy) != (verty[j]>testy)) &&
			(testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i]) )
			c = !c;
	}
	return c;
}

+ (int)IsPointInPolygon :(int)nvert :(CGPoint *)vert :(float)testx :(float)testy {
	int i, j, c = 0;
	for (i = 0, j = nvert-1; i < nvert; j = i++) {
		if ( ((vert[i].y>testy) != (vert[j].y>testy)) &&
			(testx < (vert[j].x-vert[i].x) * (testy-vert[i].y) / (vert[j].y-vert[i].y) + vert[i].x) )
			c = !c;
	}
	return c;
}

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
