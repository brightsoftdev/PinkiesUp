//
//  ReadyScreen.m
//  PinkiesUp
//
//  Created by Rahil Patel on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ReadyScreen.h"
#import "GameManager.h"
#import "ButtonGroup.h"
#import "GameLayer.h"

@implementation ReadyScreen

+ (CCScene *)scene {
	CCScene *scene = [CCScene node];
	ReadyScreen *layer = [ReadyScreen node];
	[scene addChild: layer];
	return scene;
}

- (id)init {
	if(!(self=[super init]))
		return nil;
	
	self.isTouchEnabled = YES;
	
	bottomButtonGroup = [ButtonGroup init:0];
	[self addChild:bottomButtonGroup]; //todo: memory leak?
	
	topButtonGroup = [ButtonGroup init:1];
	[self addChild:topButtonGroup];
	
	// add start button
	CGSize s = [CCDirector sharedDirector].winSize;
	CCLabelTTF *label = [CCLabelTTF labelWithString:@"Start" fontName:@"Arial" fontSize:32];
    startButton = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(beginGame)];
    startButton.position = ccp(s.width / 2, s.height / 2);
    CCMenu *menu = [CCMenu menuWithItems:startButton, nil];
    menu.position = CGPointZero;
    [self addChild:menu];
	
	[self schedule: @selector(update:)];
	
	return self;
}

- (void)dealloc {
	//[bottomButtonGroup dealloc]; //todo: dealloc is run because it is a child of this class?
	//[topButtonGroup dealloc];
	//delete bottomButtonGroup; //todo: why does deleting a pointer make it crash?
	//delete topButtonGroup;
	[super dealloc];
}

- (void)update: (ccTime)dt {
	// if number of players ready is more than 2v2, show start button
	if ([bottomButtonGroup numberOfOnButtons] > 1 && [topButtonGroup numberOfOnButtons] > 1) {
		[startButton setIsEnabled: YES];
	}
	else {
		[startButton setIsEnabled: NO];
	}
}

- (void)beginGame {
	// save an array which holds which buttons are on to the singleton
	[GameManager sharedGameManager].topEnabledButtons = [topButtonGroup isOnArray];
	[GameManager sharedGameManager].bottomEnabledButtons = [bottomButtonGroup isOnArray];
	
	[[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
}

@end

