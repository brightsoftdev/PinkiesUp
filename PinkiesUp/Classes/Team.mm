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

@synthesize athlete;

+ (id)init :(BOOL)isTop {
	return [[self alloc] init :isTop];
}

- (id)init :(BOOL)isTop {
	if (!(self = [super init]))
		return nil;
	
	GameManager *gameManager = [GameManager sharedGameManager];
	
	NSArray* buttons = [[GameManager sharedGameManager] createButtons:isTop];
	buttonGroup = [ButtonGroup initWithButtons:buttons];
	isTop ? [buttonGroup setIsEnabled:gameManager.topEnabledButtons] : [buttonGroup setIsEnabled:gameManager.bottomEnabledButtons];
	[buttonGroup setLinearSequence:isTop];
	[self addChild:buttonGroup];
	
	athlete = [Athlete init];
	[self addChild:athlete];
    
    CGSize screenSize = [GameManager sharedGameManager].screenSize;
	
    if(isTop)
        athlete.torsoBody->SetTransform(b2Vec2(screenSize.width/8.0f/PTM_RATIO, screenSize.height*3/4.0f/PTM_RATIO), 0);
    else
        athlete.torsoBody->SetTransform(b2Vec2(screenSize.width/8.0f/PTM_RATIO, screenSize.height*1/4.0f/PTM_RATIO), 0);
    
	return self;
}

- (void)dealloc {
	[buttonGroup dealloc];
	[athlete dealloc];
	[super dealloc];
}

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
@end
