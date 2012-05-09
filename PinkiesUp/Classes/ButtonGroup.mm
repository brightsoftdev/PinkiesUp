//
//  ButtonGroup.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ButtonGroup.h"
#import "Button.h"
#import "NSMutableArray_Shuffling.h"

@implementation ButtonGroup

#pragma mark overridden functions
+ (id)init {
	return [[self alloc] init];
}

+ (id)initWithButtons :(NSArray*)buttons {
	return [[self alloc] initWithButtons :buttons];
}

- (id)init {
    if (!(self = [super init]))
		return nil;
	
	return self;
}

- (id)initWithButtons :(NSArray*)buttons {
    if (!(self = [self init]))
		return nil;
	[self addButtons:buttons];
	[self setLinearSequence :0];
	return self;
}

- (void)addButton :(Button*)button { //todo: could use args ...
	[self addChild:button];
}
 
- (void)addButtons :(NSArray*)buttons {
	for (int i = 0; i < buttons.count; i++) {
		[self addChild:[buttons objectAtIndex:i]];
	}
}

- (void)dealloc {
	[super dealloc];
}

#pragma mark public functions
- (int)update {
	// check if buttons are being pressed in the correct sequence:
	// if button was pressed, check sequence
	// if last button pressed is correct, continue
	// if last button pressed is not correct, fail
	// if last button pressed is the last button in the sequence, success
	// reset button group
	// return if successful
	
	int isSuccessful = -1; // 1 is successful, 0 is failure, -1 otherwise
	int enabledButtonsCount = [self numberOfEnabledButtons]; //todo: sloppy
	
	for (int i = 0; i < [[self children]count]; i++) {
		
		Button *currentButton = (Button *)[self getChildByTag:i];
		
		if (currentButton.isEnabled && currentButton.isOn && !currentButton.sequenceWasChecked) {
			if (currentButton.positionInSequence == currentSequencePosition) {
				currentButton.sequenceWasChecked = YES;
				currentSequencePosition++;
			}
			else {
				isSuccessful = 0;
				[self reset];
				currentSequencePosition = 0;
			}
			
			// if last button was pressed, sucesss!
			if (currentSequencePosition == enabledButtonsCount) {
				isSuccessful = 1;
				[self reset];
				currentSequencePosition = 0;
			}
			
			return isSuccessful; // limit: early return, only checks the first button pressed within 1/60th of a second
		}
	}
	
	return isSuccessful;
}

- (int)numberOfOnButtons {
	int n = 0;
	
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		
		if (currentButton.isOn)
			n++;
	}
	
	return n;
}

- (int)numberOfEnabledButtons {
	int n = 0;
	
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		
		if (currentButton.isEnabled)
			n++;
	}
	
	return n;
}

- (void)setIsEnabled :(BOOL*)IsEnabledArray {	
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		currentButton.isEnabled = IsEnabledArray[i];
	}
}

- (BOOL*)isOnArray {
	BOOL* a = new BOOL[[[self children]count]];
	
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		a[i] = currentButton.isOn;
	}
	
	return a;
}

- (void)setLinearSequence :(BOOL)isInReverse {
	//set sequence
	
	// use array instead of getChildByTag?
	//buttonsArray = [NSMutableArray arrayWithObjects: button, button2, button3, button4, nil];
	//for (int i = 0; i < buttonsArray.count; i++)
	//NSLog (@"Element %i = %@", i, [buttonsArray objectAtIndex: i]);
	
	NSUInteger childrenCount = [[self children]count];
	int positionInSequence = 0;
		
	if (isInReverse) {
		for (int i = childrenCount - 1; i > -1; i--) {
			Button *currentButton = (Button *)[self getChildByTag:i];
			if (currentButton.isEnabled) {
				currentButton.positionInSequence = positionInSequence; // top buttons have inverted sequence
				positionInSequence++;
			}
		}
	}
	else {
		for (int i = 0; i < childrenCount; i++) {
			Button *currentButton = (Button *)[self getChildByTag:i];
			if (currentButton.isEnabled) {
				currentButton.positionInSequence = positionInSequence;
				positionInSequence++;
			}
		}
	}
		
	currentSequencePosition = 0;
}


/*
- (void)setRandomSequence {
	// shuffle array http://stackoverflow.com/questions/56648/whats-the-best-way-to-shuffle-an-nsmutablearray
	// fudge objective-c, just use C++ STL from now on!
	
	currentSequence = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < [[self children]count]; i++) {
		NSNumber *n = [NSNumber numberWithInt:i];
		[currentSequence addObject :n];
	}
	
	[currentSequence shuffle];
	
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		currentButton.positionInSequence = [[currentSequence objectAtIndex:i]intValue];
	}
}
*/

#pragma mark private functions
- (void)reset {
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		if (currentButton.isEnabled)
			[currentButton reset];
	}
}
/*
- (void)flashSequence {
	for (int i = 0; i < [[self children]count]; i++) {
		int currentSequenceElement = [[currentSequence objectAtIndex:i]intValue];
		Button *currentButton = (Button *)[self getChildByTag:currentSequenceElement];
		[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:(0.75*i) + 0.75], 
						 [CCCallFunc actionWithTarget:currentButton selector:@selector(flash)],
						 nil]];
	}
}
*/

#pragma mark properties
/*
- (BOOL)isPressed {
	BOOL b = NO;
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		if (currentButton.isEnabled)
			b = b && [currentButton isPressed];
	}
	return b;
}
*/
@end
