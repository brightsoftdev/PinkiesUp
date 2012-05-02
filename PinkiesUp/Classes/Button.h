//
//  Button.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Button : CCSprite <CCTargetedTouchDelegate> {
   // ButtonState buttonState;
    CCTexture2D *offTexture;
	CCTexture2D *onTexture;
    CCTexture2D *pressedTexture;
	CGPoint vertices[4];
	ccColor4F color4f;
	
	BOOL isPressed;
	BOOL isOn;
	BOOL isEnabled;
}

@property(nonatomic, readonly) BOOL isPressed;
@property(nonatomic, readonly) BOOL isOn;
@property(nonatomic, readwrite) BOOL isEnabled;
@property(nonatomic, readwrite) int positionInSequence; //todo: should create a new class that inherits Button
@property(nonatomic, readwrite) BOOL sequenceWasChecked;

+ (id)init:(CCTexture2D *)offTexture :(CCTexture2D *)onTexture :(CCTexture2D *)pressedTexture :(CGPoint)position :(CGPoint *) vertices;
- (id)init:(CCTexture2D *)offTexture :(CCTexture2D *)onTexture :(CCTexture2D *)pressedTexture :(CGPoint)position :(CGPoint *) vertices;
- (void)dealloc;
- (void)reset;
- (BOOL)isEnabled;
- (void)setIsEnabled :(BOOL)_isEnabled;
- (void)flash;

@end
