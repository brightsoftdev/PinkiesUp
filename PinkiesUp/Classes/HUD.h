//
//  HUD.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/** This class should display the same data for all devices */
@interface HUD : CCNode { // todo: should use CCLayer
	CCLabelTTF *scoreLabel;
	CCSprite *playerIconTop;
	CCSprite *playerIconBottom;
}

@property (nonatomic, readwrite) int score;

+ (id)init;
- (id)init;
- (void)update :(int)x;
- (int)score;
- (void)setScore :(int)integer;
	
@end
