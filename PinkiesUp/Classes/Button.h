//
//  Button.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Library.h"

/*
typedef enum tagButtonState {
	kButtonStateNotPressed,
    kButtonStatePressed//,
	//kButtonStateIsOff,
	//kButtonStateOn
} ButtonState;
*/

/** this class was used because CCMenuItemToggle does not expose IsPressed */
// hmm should double check that http://www.cocos2d-iphone.org/forum/topic/14536
@interface Button : CCSprite <CCTargetedTouchDelegate> {
@private
   // ButtonState buttonState;
    CCTexture2D *offTexture;
	CCTexture2D *onTexture;
    CCTexture2D *pressedTexture;
	CGPoint *vertices;
}

@property(nonatomic, readonly) CGRect rect;

@property(nonatomic, readwrite) BOOL isPressed; //todo: should be readonly, http://stackoverflow.com/questions/2736762/initializing-a-readonly-property
@property(nonatomic, readwrite) BOOL isOn; //todo: learn nonatomic
//@property(nonatomic, readonly) int isEnabled;
@property(nonatomic, readwrite) int positionInSequence; //todo: should create a new class that inherits Button
@property(nonatomic, readwrite) BOOL sequenceWasChecked;

+ (id)init:(CCTexture2D *)offTexture :(CCTexture2D *)onTexture :(CCTexture2D *)pressedTexture :(CGPoint)position :(CGPoint[]) vertices;
- (id)init:(CCTexture2D *)offTexture :(CCTexture2D *)onTexture :(CCTexture2D *)pressedTexture :(CGPoint)position :(CGPoint[]) vertices;
- (void)reset;
- (void)flash;
- (void)dealloc;

@end
