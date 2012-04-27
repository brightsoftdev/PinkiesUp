//
//  Global.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PTM_RATIO 32
#define WORLD_GRAVITY -10.0
//#define HUD_BUTTON_WIDTH = 113?

/** static class that holds global variables */
@interface Global : NSObject {

}

+ (float)velocity;
+ (void)setVelocity:(float)v;

@end

