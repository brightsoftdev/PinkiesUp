//
//  Athlete.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Athlete.h"
#import "Global.h"
#import "GameManager.h"

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
    
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    world = [GameManager sharedGameManager].world;
	
	// add torso
    torso = [CCSprite spriteWithFile:@"harold_0009_1.png"];
    torso.color = ccc3(170,255,102);
    torso.scale = 0.25f;
    [self addChild:torso];
    torsoBody = (b2Body*)[self createBodyForSprite:torso];
    
    //add head
    CCSprite *head = [CCSprite spriteWithFile:@"harold_0002_8.png"];
    head.color = ccc3(170,255,102);
    head.scale = 0.25f;
    head.position = ccp(200,200);
    [self addChild:head]; //add head to main layer, 
    
    b2Body *headBody;
    b2BodyDef boxBodyDef;
    boxBodyDef.type = b2_dynamicBody;
    boxBodyDef.position.Set(screenSize.width/2/PTM_RATIO, screenSize.height/2/PTM_RATIO); 
    boxBodyDef.userData = head;
    boxBodyDef.linearDamping = 0.0f;  //adds air resistance to box
    headBody = world->CreateBody(&boxBodyDef);
    
    b2PolygonShape boxShape;
    float height = [head boundingBox].size.height/PTM_RATIO/2.0f;
	boxShape.SetAsBox(height, height);// SetAsBox uses the half width and height (extents)
	
	b2FixtureDef fixdef;
	fixdef.shape = &boxShape;
	fixdef.density = 1.0f;
	fixdef.friction = 0.8f;
	fixdef.restitution = 0.1f;
	headBody->CreateFixture(&fixdef);
    
    b2DistanceJointDef jd;
    jd.Initialize(torsoBody, headBody, torsoBody->GetPosition(), headBody->GetPosition());
    //b2Vec2 p1, p2, d;
    
    jd.frequencyHz = 4.0f;
    jd.dampingRatio = 1.2f;
    jd.length = 4.0f;
    world->CreateJoint(&jd);
    
//    jd.bodyA = torsoBody;
//    jd.bodyB = headBody;
//    jd.localAnchorA.Set(-10.0f, 0.0f);
//    jd.localAnchorB.Set(-0.5f, -0.5f);
//    p1 = jd.bodyA->GetWorldPoint(jd.localAnchorA);
//    p2 = jd.bodyB->GetWorldPoint(jd.localAnchorB);
//    d = p2 - p1;
//    jd.length = d.Length();
//    m_joints[0] = m_world->CreateJoint(&jd);
    
    return self;
}

- (void)dealloc {
	//todo: are you supposed to dealloc box2d classes?
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
    body = world->CreateBody(&boxBodyDef);
        
    b2PolygonShape boxShape;
    float height = [sprite boundingBox].size.height/PTM_RATIO/2.0f;
	boxShape.SetAsBox(height, height);// SetAsBox uses the half width and height (extents)
	
	b2FixtureDef fixdef;
	fixdef.shape = &boxShape;
	fixdef.density = 1.0f;
	fixdef.friction = 0.8f;
	fixdef.restitution = 0.1f;
	//fixdef.filter.groupIndex = kittyCollisionFilter;
	body->CreateFixture(&fixdef);
    
    return body;
}

@end
