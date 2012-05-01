//
//  Button.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Button.h"
#import "cocos2d.h"

@interface Button (Private)
@property(nonatomic, readwrite) BOOL isPressed;
@property(nonatomic, readwrite) BOOL isOn;
@end

@implementation Button

@synthesize positionInSequence;
@dynamic isPressed;
@dynamic isOn;
@dynamic isEnabled;
@synthesize sequenceWasChecked;

#pragma mark overridden functions
+ (id)init:(CCTexture2D *)offTexture :(CCTexture2D *)onTexture :(CCTexture2D *)pressedTexture :(CGPoint)position :(CGPoint *)vertices {
    return [[[self alloc] init :offTexture :onTexture :pressedTexture :position :vertices] autorelease];
}

- (id)init:(CCTexture2D *)_offTexture :(CCTexture2D *)_onTexture :(CCTexture2D *)_pressedTexture :(CGPoint)position :(CGPoint *)_vertices {
	if (!(self = [super initWithTexture :_offTexture]))
		return nil;
	
	offTexture = _offTexture;
	onTexture = _onTexture;
	pressedTexture = _pressedTexture;
	self.position = position;
	//NSLog(@"%f, %f, %f, %f", position.x, position.y, self.contentSize.width, self.contentSize.height);
	//self.position = ccp(0 + self.contentSize.width / 2, 0 + self.contentSize.height / 2); //todo: remove this when the initWithTexture is removed
	self.position = ccp(position.x + self.contentSize.width / 2, position.y - self.contentSize.height / 2); // todo: oops, used top left vertex, instead of bottom left
	
	
	// copy array
	for (int i = 0; i < 4; i++) {
		vertices[i] = _vertices[i];
	}
	
	self.isOn = NO;
	self.isPressed = NO;
	self.isEnabled = NO;
	sequenceWasChecked = NO;
		  
	//[self setTexture:_offTexture];
		
	return self;
}

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

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    //if (buttonStatus == kButtonStatusDisabled)
	//	return NO;
	
    if (isPressed || isOn)
		return NO;
	
	CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
	
	if (![Library IsPointInPolygon:4 :vertices :location.x :location.y])
		return NO;
	
    self.isPressed = YES;
	
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
	
	self.isPressed = NO;
	self.isOn = !isOn;
}

- (void)dealloc {
    [offTexture release];
	[onTexture release];
    [pressedTexture release];
    [super dealloc];
}

#pragma mark public functions
- (void)flash {
	//[self setBlendFunc: (ccBlendFunc) { GL_SRC_ALPHA, GL_ONE }];
	//[self setColor:(ccc3(255, 255, 255))];
	[self setTexture:pressedTexture];
	[self schedule:@selector(unflash) interval:0.5];
}

#pragma mark private functions
- (void) reset {
	self.isOn = NO;
	[self setTexture :offTexture];
	sequenceWasChecked = NO;
}

- (void) unflash {
	[self unschedule:@selector(unflash)];
	//[self setBlendFunc: (ccBlendFunc) { GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA }];
	[self setTexture:offTexture];
}

#pragma mark properties
- (BOOL)isEnabled {
	return isEnabled;
}

- (void)setIsEnabled :(BOOL)_isEnabled {
	if (_isEnabled) {
		isEnabled = YES;
		[self setOpacity:255];
	}
	else {
		isEnabled = NO;
		[self setOpacity:255 / 2];
	}
}

- (BOOL)isPressed {
	return isPressed;
}

- (void)setIsPressed :(BOOL)_isPressed {
	if (_isPressed) {
		isPressed = YES;
		[self setTexture:pressedTexture];
		[self setColor:ccc3(0, 0, 255)]; //todo: hackish
	}
	else {
		isPressed = NO;
		[self setColor:ccWHITE];
	}
}

- (BOOL)isOn {
	return isOn;
}

- (void)setIsOn :(BOOL)_isOn {
	if(_isOn) {
		isOn = YES;
		[self setTexture:onTexture];
	}
	else {
		isOn = NO;
		[self setTexture:offTexture];
	}

}
@end