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
    
    //CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    world = [GameManager sharedGameManager].world;
    
    float spineLength = 4.0f;
	
	//torso
    torso = [CCSprite spriteWithFile:@"harold_0009_1.png"];
    torso.color = ccc3(170,255,102);
    torso.scale = 0.25f;
    [self addChild:torso];
    torsoBody = (b2Body*)[self createBodyForSprite:torso];
    
    //head
    CCSprite *head = [CCSprite spriteWithFile:@"harold_0002_8.png"];
    head.color = ccc3(170,255,102);
    head.scale = 0.25f;
    head.position = ccp(200,200);
    [self addChild:head]; //add head to main layer, 
    
    b2Body *headBody;
    b2BodyDef boxBodyDef;
    boxBodyDef.type = b2_dynamicBody;
    boxBodyDef.position.Set(spineLength + torsoBody->GetPosition().x, spineLength + torsoBody->GetPosition().y); 
    boxBodyDef.userData = head;
    boxBodyDef.linearDamping = 0.0f;  //adds air resistance to box
    headBody = world->CreateBody(&boxBodyDef);
    
    b2PolygonShape boxShape;
    float height = [head boundingBox].size.height/PTM_RATIO/2.0f;
	boxShape.SetAsBox(height, height);// SetAsBox uses the half width and height (extents)
	
	b2FixtureDef fixdef;
	fixdef.shape = &boxShape;
	fixdef.density = 0.4f;
	fixdef.friction = 0.8f;
	fixdef.restitution = 0.1f;
	headBody->CreateFixture(&fixdef);
    
    headBody->SetFixedRotation(TRUE);
    
    
    //spine
    b2BodyDef bd;
    bd.type = b2_dynamicBody;
    bd.position.Set(spineLength/2.0f + torsoBody->GetPosition().x, spineLength/2.0f + torsoBody->GetPosition().y); 
    bd.angle = M_PI/4;
    bd.linearDamping = 0.0f;  //adds air resistance to box
    b2Body *spine = world->CreateBody(&bd);
    
	boxShape.SetAsBox(spineLength, 0.2f);// SetAsBox uses the half width and height (extents)
	
	fixdef.shape = &boxShape;
	fixdef.density = 0.1f;
	fixdef.friction = 0.8f;
	fixdef.restitution = 0.3f;
	spine->CreateFixture(&fixdef);
    
    //torso spine joint
    b2RevoluteJointDef rjd;
    rjd.Initialize(torsoBody, spine, torsoBody->GetPosition());
    rjd.motorSpeed = -0.1f * b2_pi;
    rjd.maxMotorTorque = 3.0f;
    rjd.enableMotor = true;
    rjd.lowerAngle = 0;
    rjd.upperAngle = 0.5f * b2_pi;
    rjd.enableLimit = true;
    rjd.collideConnected = false;
    world->CreateJoint(&rjd);
    
    //head spine joint
    b2RevoluteJointDef rjd2;
    rjd2.Initialize(headBody, spine, headBody->GetPosition());
    rjd2.motorSpeed = 1.0f * b2_pi;
    rjd2.maxMotorTorque = 10000.0f;
    rjd2.enableMotor = false;
    rjd2.lowerAngle = -M_PI;
    rjd2.upperAngle = M_PI;
    rjd2.enableLimit = true;
    rjd2.collideConnected = false;
    world->CreateJoint(&rjd2);

    
//    b2DistanceJointDef jd;
//    jd.Initialize(torsoBody, headBody, torsoBody->GetPosition(), headBody->GetPosition());
//    //b2Vec2 p1, p2, d;
//    
//    jd.frequencyHz = 4.0f;
//    jd.dampingRatio = 1.2f;
//    jd.length = 4.0f;
//    world->CreateJoint(&jd);
    
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
