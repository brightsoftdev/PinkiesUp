//
//  Team.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class ButtonGroup;
@class Athlete;

/** kinda overkill for object oriented programming, but who knows, maybe more will be added to this class! */
@interface Team : CCNode {
	ButtonGroup *buttonGroup;
	Athlete *athlete;
	//todo: HUD icon?
}

@property (nonatomic, readwrite, retain) Athlete *athlete;

+ (id)init :(BOOL)isTop;
- (id)init :(BOOL)isTop;
- (void)dealloc;
- (void)update :(float)dt;

@end
