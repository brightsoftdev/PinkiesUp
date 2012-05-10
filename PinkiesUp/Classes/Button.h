//
//  Button.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCSpriteAdd.h"

@interface Button : CCSpriteAdd <CCTargetedTouchDelegate> {
    CCTexture2D *offTexture;
	CCTexture2D *onTexture;
    CCTexture2D *pressedTexture;
	CGPoint vertices[4];
	BOOL isPressed;
	BOOL isOn;
	BOOL isEnabled;
}

@property(nonatomic, readonly) BOOL isPressed;
@property(nonatomic, readonly) BOOL isOn;
@property(nonatomic, readwrite) BOOL isEnabled;
@property(nonatomic, readwrite) int positionInSequence; //todo: should create a new class that inherits Button
@property(nonatomic, readwrite) BOOL sequenceWasChecked;

+ (id)init:(CCTexture2D *)texture :(CGPoint)position :(CGPoint *) vertices;
+ (id)init:(CCTexture2D *)offTexture :(CCTexture2D *)onTexture :(CCTexture2D *)pressedTexture :(CGPoint)position :(CGPoint *) vertices;
- (id)init:(CCTexture2D *)offTexture :(CCTexture2D *)onTexture :(CCTexture2D *)pressedTexture :(CGPoint)position :(CGPoint *) vertices;
- (void)dealloc;
- (void)reset;
- (void)flash;
- (BOOL)isEnabled;
- (void)setIsEnabled :(BOOL)_isEnabled;

@end
