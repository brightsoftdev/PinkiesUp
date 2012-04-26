//
//  GameLayer.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "GameLayer.h"
#import "HUD.h"
#import "Team.h";

@interface GameLayer (Private)
//- (void)initPlatforms;
@end

@implementation GameLayer

+(CCScene *) scene {
	//Singleton *sharedSingleton = [Singleton sharedSingleton];
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init {
	if(!(self=[super init]))
		return nil;
		
	self.isTouchEnabled = YES;
	
	// add sprites
	hud = [HUD init];
	[self addChild:hud];
	
	topTeam = [Team init:0];
	[self addChild:topTeam];
	
	bottomTeam = [Team init:1];
	[self addChild:bottomTeam];

	// add schedulers (event listeners)
	[self schedule: @selector(update:)]; //default interval is set to 60, in CCDirector, kDefaultFPS directive constant
	
	return self;
}

- (void) update: (ccTime)dt { // delta time
	[topTeam update: dt];
	[bottomTeam update: dt];
}

- (void) dealloc {
	// todo: dealloc stuff here
	[super dealloc];
}

@end
