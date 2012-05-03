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
+ (id)init :(BOOL)isTop {
	return [[self alloc] init:isTop];
}

- (id)init :(BOOL)isTop {
    if (!(self = [super init]))
		return nil;
	
	CGSize s = [CCDirector sharedDirector].winSize;
	
	// add buttons
	// todo: this should be done outside of the class
	CCTexture2D *buttonOffTexture = [[CCTextureCache sharedTextureCache] addImage:@"RedSquare.png"];
	CCTexture2D *buttonOnTexture = [[CCTextureCache sharedTextureCache] addImage:@"BlueSquare.png"];
	CCTexture2D *buttonPressedTexture = [[CCTextureCache sharedTextureCache] addImage:@"GreenSquare.png"];
	
	CCTexture2D* bottomTextures[5] = {
		[[CCTextureCache sharedTextureCache] addImage:@"BottomButton1.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"BottomButton2.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"BottomButton3.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"BottomButton4.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"BottomButton5.png"]
	};
	
	CCTexture2D* topTextures[5] = {
		[[CCTextureCache sharedTextureCache] addImage:@"TopButton1.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"TopButton2.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"TopButton3.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"TopButton4.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"TopButton5.png"]
	};
	
	// iPad's resolution is 1024x768
	// C++ array ftw
	
	// buttons, from left to right
	// vertices, beginning polygon from top left point and going clockwise
	
	// vertices using screen coordinates
	CGPoint bottomVertices[5][4] = {
		{ ccp(0, 0), ccp(100, 100), ccp(100, s.height / 2), ccp(0, s.height / 2) },
		{ ccp(0, 0), ccp(s.width / 3, 0), ccp(s.width / 3 + 100, 100), ccp(100, 100) },
		{ ccp(s.width / 3, 0), ccp(s.width * 2 / 3, 0), ccp(s.width * 2 / 3 - 100, 100), ccp(s.width / 3 + 100, 100) },
		{ ccp(s.width * 2 / 3, 0), ccp(s.width, 0), ccp(s.width - 100, 100), ccp(s.width * 2 / 3 - 100, 100) },
		{ ccp(s.width - 100, 100), ccp(s.width, 0), ccp(s.width, s.height / 2), ccp(s.width - 100, s.height / 2) }
	};
	
	CGPoint topVertices[5][4] = {
		{ ccp(0, s.height), ccp(100, s.height - 100), ccp(100, s.height / 2), ccp(0, s.height / 2) },
		{ ccp(0, s.height), ccp(s.width / 3, s.height), ccp(s.width / 3 + 100, s.height - 100), ccp(100, s.height - 100) },
		{ ccp(s.width / 3, s.height), ccp(s.width * 2 / 3, s.height), ccp(s.width * 2 / 3 - 100, s.height - 100), ccp(s.width / 3 + 100, s.height - 100) },
		{ ccp(s.width * 2 / 3, s.height), ccp(s.width, s.height), ccp(s.width - 100, s.height - 100), ccp(s.width * 2 / 3 - 100, s.height - 100) },
		{ ccp(s.width - 100, s.height - 100), ccp(s.width, s.height), ccp(s.width, s.height / 2), ccp(s.width - 100, s.height / 2) }
	};
	/*	
	CGPoint bottomPositions[5] = {
		ccp(0, s.height / 2),
		ccp(0, 100),
		ccp(s.width / 3, 100),
		ccp(s.width * 2 / 3, 100),
		ccp(s.width - 100, s.height / 2)
	};
	
	CGPoint topPositions[5] = {
		ccp(0, s.height),
		ccp(0, s.height),
		ccp(s.width / 3, s.height),
		ccp(s.width * 2 / 3, s.height),
		ccp(s.width - 100, s.height)
	};
	 
	*/
	CGPoint bottomPositions[5] = {
		ccp(0, 384),
		ccp(0, 113),
		ccp(333, 113),
		ccp(635, 113),
		ccp(904, 384)
	};
	
	CGPoint topPositions[5] = {
		ccp(0, 739),
		ccp(0, s.height),
		ccp(333, s.height),
		ccp(635, s.height),
		ccp(899, 743)
	};
	
	/*
	// vertices relative to sprite's position
	CGPoint bottomVertices[5][4] = {
		{ ccp(0, 0), ccp(100, 100), ccp(100, s.height / 2), ccp(0, s.height / 2) },
		{ ccp(0, 0), ccp(s.width / 3, 0), ccp(s.width / 3 + 100, 100), ccp(100, 100) },
		{ ccp(s.width / 3, 0), ccp(s.width * 2 / 3, 0), ccp(s.width * 2 / 3 - 100, 100), ccp(s.width / 3 + 100, 100) },
		{ ccp(s.width * 2 / 3, 0), ccp(s.width, 0), ccp(s.width - 100, 100), ccp(s.width * 2 / 3 - 100, 100) },
		{ ccp(s.width - 100, 100), ccp(s.width, 0), ccp(s.width, s.height / 2), ccp(s.width - 100, s.height / 2) }
	};
	
	CGPoint topVertices[5][4] = {
		{ ccp(0, s.height), ccp(100, s.height - 100), ccp(100, s.height / 2), ccp(0, s.height / 2) },
		{ ccp(0, s.height), ccp(s.width / 3, s.height), ccp(s.width / 3 + 100, s.height - 100), ccp(100, s.height - 100) },
		{ ccp(s.width / 3, s.height), ccp(s.width * 2 / 3, s.height), ccp(s.width * 2 / 3 - 100, s.height - 100), ccp(s.width / 3 + 100, s.height - 100) },
		{ ccp(s.width * 2 / 3, s.height), ccp(s.width, s.height), ccp(s.width - 100, s.height - 100), ccp(s.width * 2 / 3 - 100, s.height - 100) },
		{ ccp(s.width - 100, s.height - 100), ccp(s.width, s.height), ccp(s.width, s.height / 2), ccp(s.width - 100, s.height / 2) }
	};
	*/
	
	Button *button;
	for (int i = 0; i < 5; i++) {
		CCTexture2D* buttonTexture = isTop ? topTextures[i] : bottomTextures[i];
		
		button = [Button init :buttonTexture :buttonTexture :buttonTexture
							  :isTop ? topPositions[i] : bottomPositions[i]
							  :isTop ? topVertices[i] : bottomVertices[i]];
		button.tag = i;
		[self addChild:button];
	}
		
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

- (void)dealloc {
	//[currentSequence release];
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

- (int)numberOfOnButtons {
	int n = 0;
	
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		
		if (currentButton.isOn)
			n++;
	}
	
	return n;
}

/*
- (void)disableOffButtons {
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		
		if (!currentButton.isOn)
			currentButton.isEnabled = NO;
	}
}
*/

- (void)disableOffButtons :(BOOL*)isOnArray {	
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		
		if (!isOnArray[i])
			currentButton.isEnabled = NO;
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
- (BOOL)isPressed {
	BOOL b = NO;
	for (int i = 0; i < [[self children]count]; i++) {
		Button *currentButton = (Button *)[self getChildByTag:i];
		b = b && [currentButton isPressed];
	}
	return b;
}
@end
