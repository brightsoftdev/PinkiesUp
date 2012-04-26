//
//  Team.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h";
#import "ButtonGroup.h";
#import "Athlete.h";

/** kinda overkill for object oriented programming, but who knows, maybe more will be added to this class! */
@interface Team : CCNode {
	ButtonGroup *buttonGroup;
	Athlete *athlete;
	//todo: HUD icon?
}

+(id)init :(int)teamId;
-(id)init :(int)teamId;
-(void)update :(float)dt;

@end
