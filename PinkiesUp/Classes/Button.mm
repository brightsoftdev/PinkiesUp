//
//  Button.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Button.h"
#import "cocos2d.h"

@implementation Button

@synthesize positionInSequence;
@synthesize isPressed;
@synthesize isOn;
//@synthesize isEnabled;
@synthesize sequenceWasChecked;

- (void) reset {
	isOn = NO;
	[self setTexture :offTexture];
	sequenceWasChecked = NO;
}

- (CGRect)rect {
    CGSize s = [self.texture contentSize];
    return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

+ (id)init:(CCTexture2D *)offTexture :(CCTexture2D *)onTexture :(CCTexture2D *)pressedTexture /*:(CGPoint)position*/ :(CGPoint *)vertices {
    return [[[self alloc] init :offTexture :onTexture :pressedTexture /*:position*/ :vertices] autorelease];
}

- (id)init:(CCTexture2D *)_offTexture :(CCTexture2D *)_onTexture :(CCTexture2D *)_pressedTexture /*:(CGPoint)position*/ :(CGPoint *)_vertices {
	if (!(self = [super initWithTexture :_offTexture])) //todo: init with texture doesn't actually set the offTexture, unnecessary?
		return nil;
	
	offTexture = _offTexture;
	onTexture = _onTexture;
	pressedTexture = _pressedTexture;
	//self.position = position;
	self.position = ccp(0 + self.contentSize.width / 2, 0 + self.contentSize.height / 2); //todo: remove this when the initWithTexture is removed
	
	// copy array
	for (int i = 0; i < 4; i++) {
		vertices[i] = _vertices[i];
	}
	
	isOn = NO;
	isPressed = NO;
	//isEnabled = YES;
	sequenceWasChecked = NO;
		
	return self;
}

- (void)draw { //todo: check function overriding	
	//glColor4f(0.0f, 1.0f, 0.0f, 1.0f);
	glColor4f(CCRANDOM_0_1(), CCRANDOM_0_1(), CCRANDOM_0_1(), 1.0f);
	[Library ccFillPoly :vertices :4 :YES];
}

- (void)dealloc {
    [offTexture release];
	[onTexture release];
    [pressedTexture release];
    [super dealloc];
}

- (void)flash {
	//[self setBlendFunc: (ccBlendFunc) { GL_SRC_ALPHA, GL_ONE }];
	//[self setColor:(ccc3(255, 255, 255))];
	[self setTexture:pressedTexture];
	[self schedule:@selector(unflash) interval:0.5];
}

// private
- (void) unflash {
	[self unschedule:@selector(unflash)];
	//[self setBlendFunc: (ccBlendFunc) { GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA }];
	[self setTexture:offTexture];
}

// check point in 

// overriden and private functions

- (void)onEnter {
    //if (buttonStatus == kButtonStatusDisabled) return;
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
    [super onEnter];
}

- (void)onExit {
    //if (buttonStatus == kButtonStatusDisabled) return;
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}

- (BOOL)containsTouchLocation:(UITouch *)touch {
    return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    //if (buttonStatus == kButtonStatusDisabled)
	//	return NO;
	
    if (isPressed || isOn)
		return NO;
	
	CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
	
	if (![Library IsPointInPolygon:4 :vertices :location.x :location.y])
		return NO;
	
    isPressed = YES;
    [self setTexture:pressedTexture];
	
    return YES;
}
/*
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    // If it weren't for the TouchDispatcher, you would need to keep a reference
    // to the touch from touchBegan and check that the current touch is the same
    // as that one.
    // Actually, it would be even more complicated since in the Cocos dispatcher
    // you get NSSets instead of 1 UITouch, so you'd need to loop through the set
    // in each touchXXX method.
	
    //if (buttonStatus == kButtonStatusDisabled)
	//	return;
	
	//todo: handle move away
	
    if ([self containsTouchLocation:touch])
		return;
	
    isPressed = NO; //todo: test
    //[self setTexture:offTexture];
}
*/
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    //if (buttonStatus == kButtonStatusDisabled)
	//	return;
	
	isPressed = NO;
	/*
	if (isOn) {
		isOn = NO;
		[self setTexture:offTexture];
	}
	*/
	if (!isOn) {
		isOn = YES;
		[self setTexture:onTexture];
	}
}

@end