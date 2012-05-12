//  GameManager.m
//  cake
//
//  Created by Jon Stokes on 7/6/11.
//  Copyright 2011 Jon Stokes. All rights reserved.
//
// adapted from Ray Wenderlich and Rod Strougo's code on p174 of "Learning Cocos2d"

#import "GameManager.h"
#import "Global.h"
#import "Button.h"

@implementation GameManager

static GameManager* _sharedGameManager = nil;

@synthesize world, screenSize, topEnabledButtons, bottomEnabledButtons, topTeamScore, bottomTeamScore;

+(GameManager*)sharedGameManager 
{
    @synchronized([GameManager class])                             
    {
        if(!_sharedGameManager)                                    
            [[self alloc] init]; 
		
        return _sharedGameManager;                                
    }
    return nil; 
}

+(id)alloc 
{
    @synchronized ([GameManager class])                          
    {
        NSAssert(_sharedGameManager == nil, @"Attempted to allocated a second instance of the Game Manager singleton");
        _sharedGameManager = [super alloc];
        return _sharedGameManager;                                
    }
    return nil;  
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // Game Manager initialized
        CCLOG(@"Game Manager Singleton, init");
		
		// for AUTO_START
		if ([Global AUTO_START]) {
			BOOL* a = new BOOL[5];
			a[0] = NO; a[1] = YES; a[2] = YES; a[3] = YES; a[4] = NO;
			topEnabledButtons = a;
			bottomEnabledButtons = a;
		}
		
		self.topTeamScore = 0;
		self.bottomTeamScore = 0;
    }
    return self;
}

- (NSArray*)createButtons :(BOOL)isTop {	
	CGSize s = [CCDirector sharedDirector].winSize;
	
	CCTexture2D* bottomTextures[5] = {
		[[CCTextureCache sharedTextureCache] addImage:@"BottomButton1.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"BottomButton2.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"BottomButton3.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"BottomButton4.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"BottomButton5.png"]
	};
	
	CCTexture2D* topTextures[5] = {
		[[CCTextureCache sharedTextureCache] addImage:@"TopButton1.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"TopButton2.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"TopButton3.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"TopButton4.png"],
		[[CCTextureCache sharedTextureCache] addImage:@"TopButton5.png"]
	};
	
	// iPad's resolution is 1024x768
	// C++ array ftw
	
	// buttons, from left to right
	// vertices, beginning polygon from top left point and going clockwise
	
	// vertices using screen coordinates
	CGPoint bottomVertices[5][4] = {
		{ ccp(0, 0), ccp(100, 100), ccp(100, s.height / 2), ccp(0, s.height / 2) },
		{ ccp(0, 0), ccp(s.width / 3, 0), ccp(s.width / 3 + 100, 100), ccp(100, 100) },
		{ ccp(s.width / 3, 0), ccp(s.width * 2 / 3, 0), ccp(s.width * 2 / 3 - 100, 100), ccp(s.width / 3 + 100, 100) },
		{ ccp(s.width * 2 / 3, 0), ccp(s.width, 0), ccp(s.width - 100, 100), ccp(s.width * 2 / 3 - 100, 100) },
		{ ccp(s.width - 100, 100), ccp(s.width, 0), ccp(s.width, s.height / 2), ccp(s.width - 100, s.height / 2) }
	};
	
	CGPoint topVertices[5][4] = {
		{ ccp(0, s.height), ccp(100, s.height - 100), ccp(100, s.height / 2), ccp(0, s.height / 2) },
		{ ccp(0, s.height), ccp(s.width / 3, s.height), ccp(s.width / 3 + 100, s.height - 100), ccp(100, s.height - 100) },
		{ ccp(s.width / 3, s.height), ccp(s.width * 2 / 3, s.height), ccp(s.width * 2 / 3 - 100, s.height - 100), ccp(s.width / 3 + 100, s.height - 100) },
		{ ccp(s.width * 2 / 3, s.height), ccp(s.width, s.height), ccp(s.width - 100, s.height - 100), ccp(s.width * 2 / 3 - 100, s.height - 100) },
		{ ccp(s.width - 100, s.height - 100), ccp(s.width, s.height), ccp(s.width, s.height / 2), ccp(s.width - 100, s.height / 2) }
	};
	/*	
	 CGPoint bottomPositions[5] = {
	 ccp(0, s.height / 2),
	 ccp(0, 100),
	 ccp(s.width / 3, 100),
	 ccp(s.width * 2 / 3, 100),
	 ccp(s.width - 100, s.height / 2)
	 };
	 
	 CGPoint topPositions[5] = {
	 ccp(0, s.height),
	 ccp(0, s.height),
	 ccp(s.width / 3, s.height),
	 ccp(s.width * 2 / 3, s.height),
	 ccp(s.width - 100, s.height)
	 };
	 
	 */
	CGPoint bottomPositions[5] = {
		ccp(0, 384),
		ccp(0, 113),
		ccp(333, 113),
		ccp(635, 113),
		ccp(904, 384)
	};
	
	CGPoint topPositions[5] = {
		ccp(0, 739),
		ccp(0, s.height),
		ccp(333, s.height),
		ccp(635, s.height),
		ccp(899, 743)
	};
	
	/*
	 // vertices relative to sprite's position
	 CGPoint bottomVertices[5][4] = {
	 { ccp(0, 0), ccp(100, 100), ccp(100, s.height / 2), ccp(0, s.height / 2) },
	 { ccp(0, 0), ccp(s.width / 3, 0), ccp(s.width / 3 + 100, 100), ccp(100, 100) },
	 { ccp(s.width / 3, 0), ccp(s.width * 2 / 3, 0), ccp(s.width * 2 / 3 - 100, 100), ccp(s.width / 3 + 100, 100) },
	 { ccp(s.width * 2 / 3, 0), ccp(s.width, 0), ccp(s.width - 100, 100), ccp(s.width * 2 / 3 - 100, 100) },
	 { ccp(s.width - 100, 100), ccp(s.width, 0), ccp(s.width, s.height / 2), ccp(s.width - 100, s.height / 2) }
	 };
	 
	 CGPoint topVertices[5][4] = {
	 { ccp(0, s.height), ccp(100, s.height - 100), ccp(100, s.height / 2), ccp(0, s.height / 2) },
	 { ccp(0, s.height), ccp(s.width / 3, s.height), ccp(s.width / 3 + 100, s.height - 100), ccp(100, s.height - 100) },
	 { ccp(s.width / 3, s.height), ccp(s.width * 2 / 3, s.height), ccp(s.width * 2 / 3 - 100, s.height - 100), ccp(s.width / 3 + 100, s.height - 100) },
	 { ccp(s.width * 2 / 3, s.height), ccp(s.width, s.height), ccp(s.width - 100, s.height - 100), ccp(s.width * 2 / 3 - 100, s.height - 100) },
	 { ccp(s.width - 100, s.height - 100), ccp(s.width, s.height), ccp(s.width, s.height / 2), ccp(s.width - 100, s.height / 2) }
	 };
	 */
	
	NSMutableArray *buttons = [NSMutableArray array];
	
	for (int i = 0; i < 5; i++) {
		CCTexture2D* buttonTexture = isTop ? topTextures[i] : bottomTextures[i];
		
		Button* button = [Button init :buttonTexture
							  :isTop ? topPositions[i] : bottomPositions[i]
							  :isTop ? topVertices[i] : bottomVertices[i]];
		button.tag = i;
		button.canTurnOff = NO;
		[buttons addObject:button];
	}
	
	return buttons;
}

@end
