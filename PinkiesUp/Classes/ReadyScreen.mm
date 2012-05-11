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
	
	// add buttons
	NSArray* bottomButtons = [[GameManager sharedGameManager] createButtons:0];
	bottomButtonGroup = [ButtonGroup initWithButtons:bottomButtons];
	[self addChild:bottomButtonGroup];
	
	NSArray* topButtons = [[GameManager sharedGameManager] createButtons:1];
	topButtonGroup = [ButtonGroup initWithButtons:topButtons];
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
	[super dealloc];
}

- (void)update: (ccTime)dt {
	// if number of players ready is more than 2v2, show start button
	if ([bottomButtonGroup numberOfOnButtons] > 1 && [topButtonGroup numberOfOnButtons] > 1)
		[startButton setIsEnabled: YES];
	else
		[startButton setIsEnabled: NO];
}

- (void)beginGame {
	// save which buttons to enable
	[GameManager sharedGameManager].topEnabledButtons = [topButtonGroup isOnArray];
	[GameManager sharedGameManager].bottomEnabledButtons = [bottomButtonGroup isOnArray];
	
	// reset score
	[GameManager sharedGameManager].topTeamScore = 0;
	[GameManager sharedGameManager].bottomTeamScore = 0;
	
	[[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
}

@end

