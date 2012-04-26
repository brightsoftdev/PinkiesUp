//
//  StartMenuScene.mm
//  PyramidSinker
//
//  Created by Jon Stokes on 1/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "StartMenuScene.h"
#import "GameLayer.h"


@implementation StartMenuScene


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	StartMenuScene *layer = [StartMenuScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// initialize your instance here
-(id) init
{
	if( (self=[super initWithColor:ccc4(0,255,0,255)])) {
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
		
		CCSprite * gameLogo = [CCSprite spriteWithFile:@"GameLogoBig.png"];
		[gameLogo setPosition:ccp(screenSize.width / 2, screenSize.height - 300)];
		[self addChild:gameLogo z:0];
		
		CCMenuItem * playButton = [CCMenuItemImage itemFromNormalImage:@"PlayButtonBig.png" selectedImage:@"PlayButtonBig.png" target:self selector:@selector(playButtonTouched:)];
        
        CCMenu *menu = [CCMenu menuWithItems:playButton, nil];
        menu.position = ccp(screenSize.width / 2, screenSize.height - 600);
        [self addChild:menu];                                  
    }
    
    return self;
}

-(void) playButtonTouched:(id)sender {
	
	[[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
	
}

@end
