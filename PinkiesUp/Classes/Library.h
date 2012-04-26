//
//  Library.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/** static class that holds common variables and functions */ //todo: should make a C++ library, should actually make a library in Xcode
@interface Library : NSObject {

}

+ (int)getNumber;
+ (void)setNumber:(int)number;

@end

