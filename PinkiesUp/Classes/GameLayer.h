//
//  GameLayer.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"
#import "HUD.h"
#import "Team.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "GameManager.h"
#import "Library.h"

@interface GameLayer : CCLayer {
	Team *topTeam;
	Team *bottomTeam;
	HUD *hud;
    b2World* world;
	GLESDebugDraw *m_debugDraw;
    CGSize screenSize;
}

+(CCScene *) scene;
-(void) setupWorld;

@end
