//
//  HUD.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HUD.h"

@implementation HUD

+ (id)init {
	return [[self alloc] init]; //lesson: this is like a static function, cannot access instance variables from here, but can somehow call a non-static function that can...WTF
}

- (id)init {
    if (!(self = [super init]))
		return nil;
	
	CGSize s = [CCDirector sharedDirector].winSize;

    //removing so the game layer's draw calls show up
//	// add background image
//	CCSprite *background = [CCSprite spriteWithFile:@"Hud.png"];
//	background.position = ccp(s.width/2, s.height/2);
//	[self addChild:background];
	
	// add score label
	scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:64];
	scoreLabel.position = ccp(s.width / 2 - scoreLabel.contentSize.width / 2, s.height / 2 - scoreLabel.contentSize.width / 2);
	//[self addChild:scoreLabel]; //todo: temp
	
	// add player icons
	playerIconTop = [CCSprite spriteWithFile:@"PlayerIcon.png"];
	playerIconTop.position = ccp(s.width * 3 / 20, s.height / 2); // x = 167
	[self addChild:playerIconTop];
	
	playerIconBottom = [CCSprite spriteWithFile:@"PlayerIcon.png"];
	playerIconBottom.position = ccp(s.width * 3 / 20, s.height/2); // x = 856
	[self addChild:playerIconBottom];
	 
    return self;
}

- (void)dealloc {
	[super dealloc];
}

- (void)update :(int)x {
	playerIconTop.position = ccp(x + 167, playerIconBottom.position.y);
	playerIconBottom.position = ccp(x + 167, playerIconBottom.position.y);
}

- (void)setScore :(int)integer {
    scoreLabel.string = [NSString stringWithFormat:@"%d", integer];
}

- (int)score {
	return [scoreLabel.string intValue];
}

@end
