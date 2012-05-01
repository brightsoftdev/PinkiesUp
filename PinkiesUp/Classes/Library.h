//
//  Library.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h";

/** static class that holds common variables and functions */ //todo: should make a C++ library, should actually make a library in Xcode
@interface Library : NSObject {

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
+ (int)IsPointInPolygon :(int)nvert :(float *)vertx :(float *)verty :(float)testx :(float)testy;
+ (int)IsPointInPolygon :(int)nvert :(CGPoint *)vert :(float)testx :(float)testy;

/** draw a filled polygon to the screen
 * @example:
 * - (void)draw {
 *	glColor4f(0.0f, 1.0f, 0.0f, 1.0f);
 *	CGSize s = CGSizeMake(150, 200);
 *	CGPoint vertices[4]={
 *	ccp(50,50),ccp(s.width,0),
 *	ccp(s.width,s.height),ccp(0,s.height),
 *	ccFillPoly(vertices, 4, YES);
 * };
 */
+ (void)ccFillPoly :(CGPoint *)poli :(int)points :(BOOL)closePolygon; // todo: should extend ccDrawPrimitives

@end

