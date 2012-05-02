//  GameManager.h
//  cake
//
//  Created by Jon Stokes on 7/6/11.
//  Copyright 2011 Jon Stokes. All rights reserved.
//
// adapted from Ray Wenderlich and Rod Strougo's code on p174 of "Learning Cocos2d"

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@class ButtonGroup;

@interface GameManager : NSObject {
    
	b2World *world;
    CGSize screenSize;
	ButtonGroup *bottomButtonGroup;
	ButtonGroup *topButtonGroup;
}

@property (readwrite) b2World *world;
@property (nonatomic, readwrite) CGSize screenSize;
@property (nonatomic, readwrite, retain) ButtonGroup *bottomButtonGroup;
@property (nonatomic, readwrite, retain) ButtonGroup *topButtonGroup;

+(GameManager*)sharedGameManager;                                  

@end
