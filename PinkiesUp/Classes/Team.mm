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

@implementation Team

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
	
	return self;
}

-(void)update :(float)dt {
	//when a sequence is successful or failed, update velocity
	//update athlete animation based on new velocity
	//update player icon, using distance continuously, based on velocity
	
	int isSuccessful = [buttonGroup update]; //returns sequence success or failure
	
	if (isSuccessful == 1) {
		velocity += 25;
	}
	else if (isSuccessful == 0) {
		if (velocity >= 25)
			velocity -= 25;
	}
	
	// will likely be replaced by box2d's force
	x += velocity * dt;
	
	[athlete update :x :velocity];
	//[hud update :x];
	
	velocity *= friction;
	
	//[Global setVelocity:velocity];
	
	//todo: testing
    //[Global setNumber:[Global getNumber] + 1];
    //NSLog(@"number = %d", [Global velocity]);	
}
@end
