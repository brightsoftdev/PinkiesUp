//
//  Athlete.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Athlete.h"

@interface Athlete (Private)
- (b2Body *) createBodyForSprite: (CCSprite*)sprite;
@end


@implementation Athlete

@synthesize torsoBody;

#pragma mark overridden functions
+ (id)init {
	return [[self alloc] init];
}

- (id) init {
    if(!(self = [super init]))
		return nil;
	
	// add torso
    torso = [CCSprite spriteWithFile:@"harold_0009_1.png"];
    torso.color = ccc3(170,255,102);
    torso.scale = 0.25f;
    [self addChild:torso];
    torsoBody = (b2Body*)[self createBodyForSprite:torso];
    
    return self;
}

- (void)dealloc {
	[super dealloc];
}

#pragma mark public functions
- (void)update :(int)x :(float)velocity {
	//CGSize s = [CCDirector sharedDirector].winSize;
	//self.bear.position = ccp(x + s.width/4, self.position.y + s.height/4);
	//[self setAnimationSpeed:velocity];
}

#pragma mark private functions
- (b2Body *) createBodyForSprite: (CCSprite*)sprite {
    
    CGSize screenSize = [CCDirector sharedDirector].winSize;

    b2Body *body;
    b2BodyDef boxBodyDef;
    boxBodyDef.type = b2_dynamicBody;
    boxBodyDef.position.Set(screenSize.width/2/PTM_RATIO, screenSize.height/2/PTM_RATIO); 
    boxBodyDef.userData = self;
    boxBodyDef.linearDamping = 0.0f;  //adds air resistance to box
    body = [GameManager sharedGameManager].world->CreateBody(&boxBodyDef);
        
    b2PolygonShape platformShape;
    float height = [sprite boundingBox].size.height/PTM_RATIO/2.0f;
	platformShape.SetAsBox(height, height);// SetAsBox uses the half width and height (extents)
	
	b2FixtureDef fixdef;
	fixdef.shape = &platformShape;
	fixdef.density = 2.0f;
	fixdef.friction = 0.5f;
	fixdef.restitution = 0.0f;
	//fixdef.filter.groupIndex = kittyCollisionFilter;
	body->CreateFixture(&fixdef);
    
    return body;
}

@end
