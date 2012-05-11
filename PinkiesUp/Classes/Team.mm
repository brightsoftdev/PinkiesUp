//
//  Team.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Global.h"
#import "GameManager.h"
#import "Team.h"
#import "ButtonGroup.h"
#import "Athlete.h"

@implementation Team

@synthesize buttonGroup, athlete, isTop_;

#pragma mark - overridden functions
+ (id)init :(BOOL)isTop {
	return [[self alloc] init :isTop];
}

- (id)init :(BOOL)isTop {
	if (!(self = [super init]))
		return nil;
	
	isTop_ = isTop;
	
	GameManager *gameManager = [GameManager sharedGameManager];
	CGSize screenSize = gameManager.screenSize;
	
	// add buttons
	NSArray* buttons = [[GameManager sharedGameManager] createButtons:isTop];
	buttonGroup = [ButtonGroup initWithButtons:buttons];
	isTop ? [buttonGroup setIsEnabledWithArray:gameManager.topEnabledButtons] : [buttonGroup setIsEnabledWithArray:gameManager.bottomEnabledButtons];
	[buttonGroup setLinearSequence:isTop];
	[self addChild:buttonGroup];
	
	// add athlete
	athlete = [Athlete init];
	[self addChild:athlete];
	
    if(isTop) {
        athlete.torsoBody->SetTransform(b2Vec2(screenSize.width/8.0f/PTM_RATIO, screenSize.height*3/4.0f/PTM_RATIO), 0);
	}
    else {
        athlete.torsoBody->SetTransform(b2Vec2(screenSize.width/8.0f/PTM_RATIO, screenSize.height*1/4.0f/PTM_RATIO), 0);
		
	}
    
	return self;
}

- (void)dealloc {
	[buttonGroup dealloc];
	[athlete dealloc];
	[super dealloc];
}

#pragma mark - public functions
- (void)update :(float)dt {
	//when a sequence is completed successfully or failed, update velocity
	//update athlete animation based on new velocity
	//update player icon, using distance continuously, based on velocity
	
	int isSuccessful = [buttonGroup update]; //returns sequence success or failure
	
	if (isSuccessful == 1 && DEBUG_CONTROL != 1) {
        athlete.torsoBody->ApplyLinearImpulse(b2Vec2(25.0f, 0.0f), athlete.torsoBody->GetPosition());
	}
	else if (isSuccessful == 0) {
		// slow down athlete
	}
    
}

#pragma mark - private functions
- (void)setIsEnabled :(BOOL)isEnabled {
	GameManager *gameManager = [GameManager sharedGameManager];
	
	if (isEnabled)
		isTop_ ? [buttonGroup setIsEnabledWithArray:gameManager.topEnabledButtons] : [buttonGroup setIsEnabledWithArray:gameManager.bottomEnabledButtons];
	else
		[buttonGroup setIsEnabled:NO];
}

@end
