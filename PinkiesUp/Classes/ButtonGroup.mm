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

@interface ButtonGroup (Private)
- (void)setRandomSequence;
@end

@implementation ButtonGroup
+ (id)init :(BOOL)isTop {
	return [[self alloc] init:isTop];
}

- (id)init :(BOOL)isTop {
    if (!(self = [super init]))
		return nil;
	
	CGSize s = [CCDirector sharedDirector].winSize;
	
	// add buttons
	CCTexture2D *buttonOffTexture = [[CCTextureCache sharedTextureCache] addImage:@"RedSquare.png"];
	CCTexture2D *buttonOnTexture = [[CCTextureCache sharedTextureCache] addImage:@"BlueSquare.png"];
	CCTexture2D *buttonPressedTexture = [[CCTextureCache sharedTextureCache] addImage:@"GreenSquare.png"];
	
	// iPad's resolution is 1024x768
	// C++ array ftw
	CGPoint positionsArrayBottom[5] = {ccp(s.width / 6, 0), ccp(s.width * 2 / 6, 0), ccp(s.width * 3 / 6, 0), ccp(s.width * 4 / 6, 0), ccp(s.width * 5 / 6, 0)};
	CGPoint positionsArrayTop[5] = {ccp(s.width / 6, s.height), ccp(s.width * 2 / 6, s.height), ccp(s.width * 3 / 6, s.height), ccp(s.width * 4 / 6, s.height), ccp(s.width * 5 / 6, s.height)};
	
	CGPoint vertices[4] = { ccp(0,0), ccp(50, 0), ccp(50, 50), ccp(0, 50) };
	
	Button *button;
	for (int i = 0; i < 5; i++) {
		button = [Button init :buttonOffTexture :buttonOnTexture :buttonPressedTexture :isTop ? positionsArrayTop[i] : positionsArrayBottom[i] :vertices];
		button.tag = i;
		[self addChild:button];
	}
	
	// new buttons by drawing polygons
	
	// buttons, beginning from top left and going clockwise
	// verticies, beginning polygon from top left point and going clockwise
	// todo: should create some kind of static data structure
	//CGPoint vertices1[4] = { ccp(0,0), ccp(s.width / 3, 0), ccp(s.width / 3 + 100, 100), ccp(100, 100) }
	//CGPoint vertices2[4] = { ccp(s.width / 3, 0), ccp(s.width * 2 / 3, 0), ccp(s.width / 3, 100), ccp(100, 100) }
	//CGPoint vertices3[4] = { ccp(0,0), ccp(s.width / 3, 0), ccp(s.width / 3 + 100, 100), ccp(100, 100) }
	//CGPoint vertices4[4] = { ccp(0,0), ccp(s.width / 3, 0), ccp(s.width / 3 + 100, 100), ccp(100, 100) }
		
	//set sequence
	
	// use array instead of getChildByTag?
	//buttonsArray = [NSMutableArray arrayWithObjects: button, button2, button3, button4, nil];
	//for (int i = 0; i < buttonsArray.count; i++)
	//NSLog (@"Element %i = %@", i, [buttonsArray objectAtIndex: i]);
	
	NSUInteger childrenCount = [[self children]count];
	
	for (int i = 0; i < childrenCount; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		currentButton.positionInSequence = isTop ? childrenCount - i - 1 : i;
	}
	
	currentSequencePosition = 0;
	
	return self;
}

- (int)update {
	// check if buttons are being pressed in the correct sequence:
	// if button was pressed, check sequence
	// if last button pressed is correct, continue
	// if last button pressed is not correct, fail
	// if last button pressed is the last button in the sequence, success
	// reset button group
	// return if successful
	
	int isSuccessful = -1; // 1 is successful, 0 is failure, -1 otherwise
	
	for (int i = 0; i < [[self children]count]; i++) {
		
		Button *currentButton = (Button *)[self getChildByTag:i];
		
		if (currentButton.isOn && !currentButton.sequenceWasChecked) {
			if (currentButton.positionInSequence == currentSequencePosition) { //todo: can't debug properties? WTF http://stackoverflow.com/questions/3270248/seeing-the-value-of-a-synthesized-property-in-the-xcode-debugger-when-there-is-n
				//NSLog(@"%d, %d", (int)currentButton.positionInSequence, (int)currentSequencePosition);
				currentButton.sequenceWasChecked = YES;
				currentSequencePosition++;
			}
			else {
				isSuccessful = 0;
				[self reset];
				currentSequencePosition = 0;
			}
			
			// if last button was pressed, sucesss!
			if (currentSequencePosition == [[self children]count]) {
				isSuccessful = 1;
				[self reset];
				currentSequencePosition = 0;
			}
			
			return isSuccessful; // limit: early return, only checks the first button pressed within 1/60th of a second
		}
	}
	
	return isSuccessful;
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

- (void)reset {
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
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
- (BOOL)isPressed {
	BOOL b = NO;
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		b = b && [currentButton isPressed];
	}
	return b;
}
@end
