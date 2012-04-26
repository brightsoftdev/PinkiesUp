//
//  Team.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Team.h"
#import "ButtonGroup.h";
#import "Athlete.h";
#import "Box2D.h"

@implementation Team

@synthesize athlete;

//todo: temp
float velocity = 0;
float friction = .99;
float x = 0; // x value of position //todo: should probably use a distance unit

+(id)init :(int)teamId {
	return [[self alloc] init :teamId];
}

-(id)init :(int)teamId {
	if (!(self = [super init]))
		return nil;
	
	buttonGroup = [ButtonGroup init:teamId];
	[self addChild:buttonGroup];
	
	athlete = [Athlete init];
	[self addChild:athlete];
    
    CGSize screenSize = [GameManager sharedGameManager].screenSize;
    if(teamId == 1)//bottom, this is reversed I think
        athlete.torsoBody->SetTransform(b2Vec2(screenSize.width/8.0f/PTM_RATIO, screenSize.height*3/4.0f/PTM_RATIO), 0);
    if(teamId == 0)//top
        athlete.torsoBody->SetTransform(b2Vec2(screenSize.width/8.0f/PTM_RATIO, screenSize.height*1/4.0f/PTM_RATIO), 0);
    
	return self;
}

-(void)update :(float)dt {
	//when a sequence is successful or failed, update velocity
	//update athlete animation based on new velocity
	//update player icon, using distance continuously, based on velocity
	
	int isSuccessful = [buttonGroup update]; //returns sequence success or failure
	
	if (isSuccessful == 1) {
		velocity += 25;
        athlete.torsoBody->ApplyLinearImpulse(b2Vec2(25.0f, 0.0f), athlete.torsoBody->GetPosition());

	}
	else if (isSuccessful == 0) {
		if (velocity >= 25)
			velocity -= 25;
	}
	
	// will likely be replaced by box2d's force
	x += velocity * dt;
	
	//[athlete update :x :velocity];
	//[hud update :x];
	
	velocity *= friction;
	
	//[Global setVelocity:velocity];
	
	//todo: testing
    //[Global setNumber:[Global getNumber] + 1];
    //NSLog(@"number = %d", [Global velocity]);	
}
@end
