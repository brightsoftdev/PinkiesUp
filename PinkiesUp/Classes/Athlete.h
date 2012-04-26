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
#import "GameManager.h"

/** the main character sprite */
@interface Athlete : CCNode {
    CCSprite *_bear;
    CCAction *_walkAction;
	CCAnimation *_walkAnim;
    CCSprite *torso;
    b2Body *torsoBody;
    b2World* world;

}

@property (nonatomic, retain) CCSprite *bear; //todo: need to learn why retain, or forget this and do it the other way!
@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) CCAnimation *walkAnim;
@property (nonatomic, readwrite) b2World *world;
@property (nonatomic, readwrite) b2Body *torsoBody;



+ (id)init;
- (id)init;
- (void)update :(int)x :(float)velocity;
- (void)dealloc;
- (void)setAnimationSpeed :(float)velocity;

@end
