//
//  Athlete.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "Global.h"
#import "AthletePart.h"
#import "Team.h"

/** the main character sprite */
@interface Athlete : CCNode {
    CCSprite *torso;
    b2Body *torsoBody;
    b2World* world;
    AthletePart *head;
	NSMutableArray *partSprites;
}

@property (nonatomic, readwrite) b2World *world;
@property (nonatomic, readwrite) b2Body *torsoBody;

+ (id)init;
- (id)init;
- (void)dealloc;
- (void)update :(int)x :(float)velocity;

@end
