//
//  GameLayer.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/18/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "GameLayer.h"
#import "Library.h"
#import "Global.h"
#import "GameManager.h"
#import "Team.h"
#import "HUD.h"
#import "Athlete.h"
#import "ReadyScreen.h"

@interface GameLayer (Private)
- (void)setupWorld;
- (void)showEndMenu;
- (void)restart;
- (void)goToReadyScreen;
@end

@implementation GameLayer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	[scene addChild: layer];
	return scene;
}

#pragma mark overridden functions
-(id) init {
	if(!(self=[super init]))
		return nil;
		
	self.isTouchEnabled = YES;
    screenSize = [CCDirector sharedDirector].winSize;
    [GameManager sharedGameManager].screenSize = screenSize;
	hasEnded = NO;
    
    // box2d
    [self setupWorld];
	
	// add sprites
	hud = [HUD init];
	[self addChild:hud];
	
	topTeam = [Team init:1];
	[self addChild:topTeam];
	
	bottomTeam = [Team init:0];
	[self addChild:bottomTeam];
	
	// add countdown
	countdown = 5;
    countdownLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", countdown] 
							fontName:@"Arial" fontSize:32];
    countdownLabel.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [self addChild:countdownLabel];
	
	// add schedulers (event listeners)
	//[self schedule: @selector(update:) interval:0.0f repeat:kCCRepeatForever delay:5.0f]; //default interval is set to 60, in CCDirector, kDefaultFPS directive constant
    [self schedule:@selector(updateCountdown:) interval:0.5f];
	
	return self;
}

- (void) dealloc {
	// box2d
	delete world;
	world = NULL;
	delete m_debugDraw;
    
	[super dealloc];
}

- (void) draw {
	
    
    if(DEBUG_DRAW == 1 ) {
        
        // Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
        // Needed states:  GL_VERTEX_ARRAY, 
        // Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
        glDisable(GL_TEXTURE_2D);
        glDisableClientState(GL_COLOR_ARRAY);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        
        world->DrawDebugData();
        
        // restore default GL states
        glEnable(GL_TEXTURE_2D);
        glEnableClientState(GL_COLOR_ARRAY);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    }
    
}

#pragma mark main function
- (void) update: (ccTime)dt { // delta time
	
    [topTeam update: dt];
	[bottomTeam update: dt];
    
	// box2d
    int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);
    
    for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			//Synchronize the sprite position and rotation with the corresponding body
			CCSprite *myActor = (CCSprite*)b->GetUserData();
            if(myActor.parent != nil) {
                //child positioning is relative to parent, so you have to convert from absolute to node space
                myActor.position = [myActor.parent convertToNodeSpace:CGPointMake(b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO)];
            }
            else 
                myActor.position = CGPointMake(b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
                
            myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());

        }
    }
    
    topTeam.athlete.torsoBody->ApplyForce(b2Vec2(0.0f,-WORLD_GRAVITY), topTeam.athlete.torsoBody->GetPosition());
    bottomTeam.athlete.torsoBody->ApplyForce(b2Vec2(0.0f,WORLD_GRAVITY), bottomTeam.athlete.torsoBody->GetPosition());
	
    // after box2d
	
	// check if game is over
	if ((topTeam.athlete.torsoBody->GetPosition().x * PTM_RATIO > END_OF_TRACK
		|| bottomTeam.athlete.torsoBody->GetPosition().x * PTM_RATIO > END_OF_TRACK)
		&& !hasEnded) {
		hasEnded = YES;
		[self showEndMenu];
	}
	
}

#pragma mark private functions
- (void) setupWorld {
    
    // Define the gravity vector.
    b2Vec2 gravity;
    gravity.Set(0.0f, 0.0f);
    
    // Do we want to let bodies sleep?
    // This will speed up the physics simulation
    bool doSleep = true;
    
    // Construct a world object, which will hold and simulate the rigid bodies.
    world = new b2World(gravity, doSleep);
    
    world->SetContinuousPhysics(true);
    
    // Debug Draw functions
    m_debugDraw = new GLESDebugDraw(PTM_RATIO);
    world->SetDebugDraw(m_debugDraw);
    
    uint32 flags = 0;
    flags += b2DebugDraw::e_shapeBit;
    flags += b2DebugDraw::e_jointBit;
    flags += b2DebugDraw::e_aabbBit;
    flags += b2DebugDraw::e_pairBit;
    flags += b2DebugDraw::e_centerOfMassBit;
    m_debugDraw->SetFlags(flags);		
    
    
    // Define the ground body.
    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(0, 0); // bottom-left corner
    
    // Call the body factory which allocates memory for the ground body
    // from a pool and creates the ground box shape (also from a pool).
    // The body is also added to the world.
    b2Body* groundBody = world->CreateBody(&groundBodyDef);
    
    // Define the ground box shape.
    b2PolygonShape groundBox;		
    
    // bottom
    groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(screenSize.width/PTM_RATIO,0));
    groundBody->CreateFixture(&groundBox,0);
    
    // top
    groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO));
    groundBody->CreateFixture(&groundBox,0);
    
    // left
    groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(0,0));
    groundBody->CreateFixture(&groundBox,0);
    
    // right
    groundBox.SetAsEdge(b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,0));
    groundBody->CreateFixture(&groundBox,0);
    
    [GameManager sharedGameManager].world = world;
}

-(void)updateCountdown:(ccTime)delta {
	countdown--;

	if (countdown > 0 ) {
		[countdownLabel setString:[NSString stringWithFormat:@"%i", countdown]];
	}
	else if (countdown <= 0 && countdown > -2) {
		[countdownLabel setString:[NSString stringWithString:@"GO"]];
		[self schedule: @selector(update:)];
	}
	else if (countdown <= -2) {
		[self removeChild:countdownLabel cleanup:YES];
		[self unschedule:@selector(updateCountdown:)];
	}
}

- (void) showEndMenu {
	// todo: make this a layer
	
	// dim the game layer
	CCLayerColor* colorLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 255)];
	[colorLayer setOpacity:175];
	[self addChild:colorLayer z:1];
	
	// indicate winning player
	BOOL topTeamWon = topTeam.athlete.torsoBody->GetPosition().x * PTM_RATIO >= END_OF_TRACK;
	NSString *labelString;
	
	labelString = topTeamWon ? @"Top Team Wins!" : @"Bottom Team Wins!";
	
	CCLabelTTF *winnerLabel = [CCLabelTTF labelWithString:labelString fontName:@"Arial" fontSize:32];
	winnerLabel.position = ccp(screenSize.width/2, screenSize.height * 3 / 4);
	[self addChild:winnerLabel z:2];
	
	// adjust and add score
	topTeamWon ? [GameManager sharedGameManager].topTeamScore++ : [GameManager sharedGameManager].bottomTeamScore++;
	
	int topTeamScore = [GameManager sharedGameManager].topTeamScore;
	int bottomTeamScore = [GameManager sharedGameManager].bottomTeamScore;
	
	NSString *scoreLabelString = [NSString stringWithFormat:@"%i-%i %@",
								  topTeamScore >= bottomTeamScore ? topTeamScore : bottomTeamScore,
								  topTeamScore < bottomTeamScore ? topTeamScore : bottomTeamScore,
								  topTeamScore >= bottomTeamScore ? @"Top" : @"Bottom"];
								  
	CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:scoreLabelString fontName:@"Arial" fontSize:32];
	scoreLabel.position = ccp(screenSize.width/2, screenSize.height * 3 / 4 - 50);
	[self addChild:scoreLabel z:2];
	
	// add menu
	CGSize s = [CCDirector sharedDirector].winSize;
	
	CCLabelTTF* replayLabel = [CCLabelTTF labelWithString:@"Replay" fontName:@"Arial" fontSize:32];
	CCMenuItemLabel* replayMenuItem = [CCMenuItemLabel itemWithLabel:replayLabel target:self selector:@selector(restart)];
	replayMenuItem.position = ccp(s.width / 2, s.height / 2);
	
	CCLabelTTF* changePlayersLabel = [CCLabelTTF labelWithString:@"Change Players" fontName:@"Arial" fontSize:32];
	CCMenuItemLabel* changePlayersMenuItem = [CCMenuItemLabel itemWithLabel:changePlayersLabel target:self selector:@selector(goToReadyScreen)];
	changePlayersMenuItem.position = ccp(s.width / 2, s.height / 2 - 50);
	
	CCMenu *menu = [CCMenu menuWithItems:replayMenuItem, changePlayersMenuItem, nil];
	menu.position = CGPointZero;
	[self addChild:menu z:2];
}

- (void) restart {
	[[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
}

- (void) goToReadyScreen {
	[[CCDirector sharedDirector] replaceScene:[ReadyScreen scene]];
}

@end
