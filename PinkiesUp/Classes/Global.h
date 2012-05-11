//
//  Global.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PTM_RATIO 32
#define WORLD_GRAVITY -20.0
//#define AUTO_START 1 // created static variable to avoid rebuilding
#define DEBUG_CONTROL 0
#define DEBUG_DRAW 1
#define HAROLD_PIXEL_SCALE 29.0
#define DEFAULT_HAROLD_SCALE 0.25


//#define HUD_BUTTON_WIDTH = 113?

/** static class that holds global variables */
@interface Global : NSObject {

}

+ (BOOL)AUTO_START;

@end

