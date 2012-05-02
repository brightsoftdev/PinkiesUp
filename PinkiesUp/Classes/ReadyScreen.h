//
//  ReadyScreen.h
//  PinkiesUp
//
//  Created by Rahil Patel on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class ButtonGroup;

@interface ReadyScreen : CCLayer {
	ButtonGroup *bottomButtonGroup;
	ButtonGroup *topButtonGroup;
	CCMenuItemLabel *startButton;
}

+ (CCScene *) scene;

@end