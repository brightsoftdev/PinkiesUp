//  GameManager.m
//  cake
//
//  Created by Jon Stokes on 7/6/11.
//  Copyright 2011 Jon Stokes. All rights reserved.
//
// adapted from Ray Wenderlich and Rod Strougo's code on p174 of "Learning Cocos2d"

#import "GameManager.h"
#import "Global.h"

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

@end
