//
//  GameLayer.h
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "HUD.h"
#import "Team.h"

// GameLayer
@interface GameLayer : CCLayer {
	Team *topTeam;
	Team *bottomTeam;
	HUD *hud; // todo: best practice? use this to keep reference to HUD vs getChildByTag
}

// returns a CCScene that contains the GameLayer as the only child
+(CCScene *) scene;

@end
