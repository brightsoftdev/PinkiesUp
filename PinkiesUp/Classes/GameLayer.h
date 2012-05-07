//
//  GameLayer.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"

#define END_OF_TRACK 911 // screenSize.width - 113

@class Team;
@class HUD;

@interface GameLayer : CCLayer {
	Team *topTeam;
	Team *bottomTeam;
	HUD *hud;
    b2World* world;
	GLESDebugDraw *m_debugDraw;
    CGSize screenSize;
	BOOL hasEnded;
}

+(CCScene *) scene;

@end
