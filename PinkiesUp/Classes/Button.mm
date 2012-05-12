//
//  Button.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Button.h"
#import "Library.h"

@interface Button (Private)
@property(nonatomic, readwrite) BOOL isPressed;
@property(nonatomic, readwrite) BOOL isOn;
/*
- (void) reset;
- (void) updateFlash;
- (void) updateFlash2;
*/
@end

@implementation Button

@dynamic isPressed, isOn, isEnabled;
@synthesize canTurnOff, positionInSequence, sequenceWasChecked;

#pragma mark - overridden functions
+ (id)init:(CCTexture2D *)texture :(CGPoint)position :(CGPoint *) vertices {
	//todo: ignore textures
	return [[[self alloc] init :texture :texture :texture :position :vertices] autorelease];
}

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
	//self.position = ccp(0 + self.contentSize.width / 2, 0 + self.contentSize.height / 2);
	self.position = ccp(position.x + self.contentSize.width / 2, position.y - self.contentSize.height / 2); // todo: oops, used top left vertex, instead of bottom left
	
	
	// copy array
	for (int i = 0; i < 4; i++) {
		vertices[i] = _vertices[i];
	}
	
	self.isEnabled = YES;
	//self.isOn = NO;
	self.isPressed = NO;
	self.canTurnOff = YES;
	sequenceWasChecked = NO;
	positionInSequence = -1;
		  
	//[self setTexture:_offTexture];
	//[self setOpacity:255 / 2];
	[self setColor:(ccc3(0, 0, 0))]; // needed to use CCSpriteAdd
		
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
    if (!isEnabled)
		return NO;
	
    if (isPressed) // || isOn
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
    if (!isEnabled)
		return;
	
	self.isPressed = NO;
	self.isOn = canTurnOff ? !isOn : YES;
}

- (void)dealloc {
	[offTexture release];
	[onTexture release];
    [pressedTexture release];
    [super dealloc];
}

#pragma mark - public functions
- (void)flash {
	[self schedule:@selector(updateFlash)];
}

#pragma mark - private functions
- (void) reset {
	self.isOn = NO;
	[self setTexture :offTexture];
	sequenceWasChecked = NO;
}

- (void) updateFlash {
	[self setColor:(ccc3([self color].r + 30, [self color].g + 30, [self color].b + 30))];
	if ([self color].r >= 240) {
		[self unschedule:@selector(updateFlash)];
		[self schedule:@selector(updateFlash2)];
	}
}

- (void) updateFlash2 {
	[self setColor:(ccc3([self color].r - 30, [self color].g - 30, [self color].b - 30))];
	if ([self color].r == 0) {
		[self unschedule:@selector(updateFlash2)];
	}
}

#pragma mark - public properties
- (BOOL)isEnabled {
	return isEnabled;
}

- (void)setIsEnabled :(BOOL)_isEnabled {
	if (_isEnabled) {
		isEnabled = YES;
		self.isOn = NO;
	}
	else {
		isEnabled = NO;
		[self setTexture:offTexture];
		[self setOpacity:255 / 5];
	}
}

#pragma mark - private properties
- (BOOL)isPressed {
	return isPressed;
}

- (void)setIsPressed :(BOOL)_isPressed {
	if (_isPressed) {
		isPressed = YES;
		[self setTexture:pressedTexture];
		[self flash];
	}
	else {
		isPressed = NO;
	}
}

- (BOOL)isOn {
	return isOn;
}

- (void)setIsOn :(BOOL)_isOn {
	if(_isOn) {
		isOn = YES;
		[self setTexture:onTexture];
		[self setOpacity:255];
	}
	else {
		isOn = NO;
		[self setTexture:offTexture];
		[self setOpacity:255 / 2]; //todo: should be in subclass
	}
}

@end