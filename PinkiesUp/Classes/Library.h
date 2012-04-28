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

+ (int)getNumber;
+ (void)setNumber:(int)number;
+ (int)IsPointInPolygon :(int)nvert :(float *)vertx :(float *)verty :(float)testx :(float)testy;
+ (void)ccFillPoly :(CGPoint *)poli :(int)points :(BOOL)closePolygon;

@end

