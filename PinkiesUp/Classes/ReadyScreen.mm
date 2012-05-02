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
	//[bottomButtonGroup dealloc]; //todo: fail
	//[topButtonGroup dealloc];
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
	// disable buttons that are off
	//[bottomButtonGroup disableOffButtons];
	//[topButtonGroup disableOffButtons];
	
	// pass the buttonGroups using a singleton
	//GameManager *gameManager = [GameManager sharedGameManager];
	//gameManager.bottomButtonGroup = bottomButtonGroup; //todo: multiple pointers, bad? copy and retain failed
	//gameManager.topButtonGroup = topButtonGroup;
	
	//[self dealloc];
	
	[[CCDirector sharedDirector] replaceScene:[GameLayer scene]]; //todo: pass in the buttonGroups classes or pass which ones are on (can use child tag)
	//STOPPED HERE. GameLayere inits fine, but bad access after replacing the scene?
}

@end

