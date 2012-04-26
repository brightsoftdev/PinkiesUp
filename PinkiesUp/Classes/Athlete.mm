//
//  Athlete.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Athlete.h"

int const ANIMATION_SETS = 10; //todo: should depend on velocity
float const ANIMATION_DELAY_BOUND = 0.2f; //todo: are these global?

@implementation Athlete

@synthesize bear = _bear;
@synthesize walkAction = _walkAction;
@synthesize walkAnim = _walkAnim;

+ (id)init {
	return [[self alloc] init];
}

- (id) init {
    if(!(self = [super init]))
		return nil;
        
	// This loads an image of the same name (but ending in png), and goes through the
	// plist to add definitions of each frame to the cache.
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AnimBear.plist"];        
	
	// Create a sprite sheet with the Happy Bear images
	CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AnimBear.png"];
	[self addChild:spriteSheet];
	
	// Load up the frames of our animation
	NSMutableArray *walkAnimFrames = [NSMutableArray array];
	for(int i = 1; i <= 8; ++i) {
		[walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bear%d.png", i]]];
	}
	self.walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.0f];
	
	// Create a sprite for our bear
	CGSize s = [CCDirector sharedDirector].winSize;
	self.bear = [CCSprite spriteWithSpriteFrameName:@"bear1.png"];        
	_bear.position = ccp(s.width/4, s.height/4);
	[spriteSheet addChild:_bear];
        
    return self;
}

- (void)update :(int)x :(float)velocity {
	CGSize s = [CCDirector sharedDirector].winSize;
	
	self.bear.position = ccp(x + s.width/4, self.position.y + s.height/4);
//	[self setAnimationSpeed:velocity];
}

- (void)dealloc {
	self.bear = nil;
    self.walkAction = nil;
	self.walkAnim = nil;
	[super dealloc];
}

- (void)setAnimationSpeed :(float)velocity {
	float maxVelocity = 100;
    
    //JS: commenting out some of this an
    
	//using a limit function, (x-c)/x
//	self.walkAnim.delay = 0.2f - (velocity / maxVelocity) * 0.2f;
//	NSLog(@"%f", self.walkAnim.delay);
//	
//	if (self.walkAnim.delay == 0.2f) {
//		[_bear stopAction:_walkAction]; // seems okay to run even if already stopped
//		return;
//	}
	
	//todo: not working. Stops every frame. Need to only update when a certain velocity is reached, divide by sets!
	// restore original frame?
	
	// have to restart action in order to update CCAnimation delay
	[_bear stopAllActions]; //todo: try stopAction
	self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.walkAnim restoreOriginalFrame:YES]];
	[_bear runAction:self.walkAction];
}
@end
