//
//  ButtonGroup.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/** contains buttons and group functions */
@interface ButtonGroup : CCNode {
	//NSMutableArray *buttonsArray;
	//BOOL isJumping;
	int currentSequencePosition;
	//NSMutableArray *currentSequence;
}

+ (id)init :(BOOL)isTop; //todo: pass in buttons
- (id)init :(BOOL)isTop;
- (void)dealloc;
/** returns 1 upon successful sequence, 0 upon failed sequence, and -1 otherwise */
- (int)update;
- (void)reset;
//- (void)flashSequence;
//- (BOOL)isPressed;
- (int)numberOfOnButtons;
- (int)numberOfEnabledButtons;
- (BOOL*)isOnArray;
- (void)setIsEnabled :(BOOL*)IsEnabledArray;
- (void)setDefaultSequence :(BOOL)isTop; //todo: isReversed
@end
