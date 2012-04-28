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
	
	CGSize s = [CCDirector sharedDirector].winSize; //todo: should really create a singleton class to hold constants
	
	// add background image
	CCSprite *background = [CCSprite spriteWithFile:@"Hud.png"];
	background.position = ccp(s.width/2, s.height/2);
	[self addChild:background];
	
	// add score label
	scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:64];
	scoreLabel.position = ccp(s.width / 2 - scoreLabel.contentSize.width / 2, s.height / 2 - scoreLabel.contentSize.width / 2);
	//[self addChild:scoreLabel]; //todo: temp
	
	// add player icons
	playerIconTop = [CCSprite spriteWithFile:@"PlayerIcon.png"]; //todo: should draw icon according to color
	playerIconTop.position = ccp(s.width * 3 / 20, s.height / 2); // x = 167
	[self addChild:playerIconTop];
	
	playerIconBottom = [CCSprite spriteWithFile:@"PlayerIcon.png"];
	playerIconBottom.position = ccp(s.width * 3 / 20, s.height/2); // x = 856
	[self addChild:playerIconBottom];
	 
    return self;
}

- (void)update :(int)x {
	//playerIconBottom.position.x = x; //lesson: goddamnit cocos2d
	playerIconBottom.position = ccp(x + 167, playerIconBottom.position.y);

	//self.score += velocityDelta;
}

- (void)setScore :(int)integer {
    scoreLabel.string = [NSString stringWithFormat:@"%d", integer];
}

- (int)score {
	return [scoreLabel.string intValue];
}

@end
