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

+ (id)init:(CCTexture2D *)offTexture :(CCTexture2D *)onTexture :(CCTexture2D *)pressedTexture :(CGPoint)position :(CGPoint[])vertices {
    return [[[self alloc] init :offTexture :onTexture :pressedTexture :position :vertices] autorelease];
}

- (id)init:(CCTexture2D *)_offTexture :(CCTexture2D *)_onTexture :(CCTexture2D *)_pressedTexture :(CGPoint)position :(CGPoint[])_vertices {
	if (!(self = [super initWithTexture :_offTexture])) //todo: init with texture doesn't actually set the offTexture, unnecessary?
		return nil;
		
	offTexture = _offTexture;
	onTexture = _onTexture;
	pressedTexture = _pressedTexture;
	self.position = position;
	//self.position = ccp(position.x + self.contentSize.width / 2, position.y + self.contentSize.height / 2);
	
	isOn = NO;
	isPressed = NO;
	//isEnabled = YES;
	sequenceWasChecked = NO;
	
	vertices = _vertices;
	
	//NSLog(@"v[0] = %f", ((CGPoint)vertices[1]).x);
		
	return self;
}

- (void)draw {
	//overrides draw
	/*
	glColor4ub(255, 0, 255, 255);
	glLineWidth(2);
	CGPoint vertices2[] = { ccp(30,130), ccp(30,230), ccp(50,200) };
	ccDrawPoly( vertices2, 3, YES);
	*/
	
	// testing area
	 glColor4f(0.0f, 1.0f, 0.0f, 1.0f);
	 //CGSize s = CGSizeMake(500, 500);
	CGPoint vertices2[4] = { ccp(0,0), ccp(50, 0), ccp(50, 50), ccp(0, 50) };
	 [Library ccFillPoly :vertices2 :4 :YES];
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
	
    if (![self containsTouchLocation:touch])
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