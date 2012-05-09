//
//  ButtonGroup.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Button;

/** contains buttons and group functions */
@interface ButtonGroup : CCNode {
	//NSMutableArray *buttonsArray;
	//BOOL isJumping;
	int currentSequencePosition;
	//NSMutableArray *currentSequence;
}

+ (id)init;
+ (id)initWithButtons :(NSArray*)buttons;
- (id)init;
- (id)initWithButtons :(NSArray*)buttons;
- (void)dealloc;
- (void)addButton :(Button*)button;
- (void)addButtons :(NSArray*)buttons;
/** returns 1 upon successful sequence, 0 upon failed sequence, and -1 otherwise */
- (int)update;
- (void)reset;
//- (void)flashSequence;
//- (BOOL)isPressed;
- (int)numberOfOnButtons;
- (int)numberOfEnabledButtons;
- (BOOL*)isOnArray;
- (void)setIsEnabled :(BOOL*)IsEnabledArray;
- (void)setLinearSequence :(BOOL)isInReverse;
@end
