//
//  ReadyScreen.m
//  PinkiesUp
//
//  Created by Rahil Patel on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ReadyScreen.h"
//#import "GameLayer.h"

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
	[self addChild:bottomButtonGroup];
	
	topButtonGroup = [ButtonGroup init:1];
	[self addChild:topButtonGroup];
	
	CGSize s = [CCDirector sharedDirector].winSize;
	
	CCLabelTTF *label = [CCLabelTTF labelWithString:@"Start" fontName:@"Arial" fontSize:32];
    startButton = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(beginGame)]; //todo: why did beginGame: make it crash?
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

- (void) update: (ccTime)dt {
	// if number of players ready is more than 2v2, show ready button
	[bottomButtonGroup update2];
	[topButtonGroup update2];
	
	int bottom = [bottomButtonGroup numberOfEnabledButtons];
	int top = [topButtonGroup numberOfEnabledButtons];
	
	//NSLog(@"%i, %i", bottom, top);
	
	if ([bottomButtonGroup numberOfEnabledButtons] > 2 && [topButtonGroup numberOfEnabledButtons] > 2) {
		// show menuItem
		[startButton setIsEnabled: YES];
	}
	else {
		// hide menuItem
		[startButton setIsEnabled: NO];
	}
	
}

- (void)beginGame {
	//[[CCDirector sharedDirector] replaceScene:[GameLayer scene]]; //todo: pass in the buttonGroups
}

@end

