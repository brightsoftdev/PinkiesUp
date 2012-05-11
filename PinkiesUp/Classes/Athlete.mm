//
//  Athlete.m
//  Pinkies-Up
//
//  Created by Rahil Patel on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Athlete.h"
#import "Global.h"
#import "GameManager.h"
/*
@interface Athlete (Private)
- (b2Body *) createBoxBodyForSprite: (CCSprite*)sprite density:(float)density friction:(float)friction restiution:(float)restitution;
@end
*/

@implementation Athlete

@synthesize torsoBody, world;

#pragma mark - overridden functions
+ (id)init {
	return [[self alloc] init];
}

- (id) init {
    if(!(self = [super init]))
		return nil;
    
    //CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    world = [GameManager sharedGameManager].world;
	partSprites = [[NSMutableArray alloc] init];
    
    float spineLength = sqrtf(pow(10.5,2) + pow(10.5,2))*DEFAULT_HAROLD_SCALE * HAROLD_PIXEL_SCALE / PTM_RATIO;
    CCLOG(@"spineLength: %f", spineLength);
	
	//torso
    torso = [CCSprite spriteWithFile:@"harold_0009_1.png"];
    //torso.color = ccc3(170,255,102);
    torso.scale = 0.25f;
    [self addChild:torso z:0];
    torsoBody = (b2Body*)[self createBoxBodyForSprite:torso density:1.0f friction:0.8f restiution:0.1f];
	
	//parts
    NSString *partsString = @"harold_0008_2.png:harold_0007_3.png:harold_0006_4.png:harold_0005_5.png:harold_0004_6.png:harold_0003_7.png:harold_0003_8.png";
    [self addMidParts:partsString];
    
	head = [partSprites lastObject];
	
    //todo: consider using the flood fill class for his eyes, HAROLD ANGRY!!
    CCSprite *leftEye = [CCSprite spriteWithFile:@"harold_0000_eye.png"];
    leftEye.tag = 0;
    leftEye.position = ccp(2.5*HAROLD_PIXEL_SCALE, 5.5*HAROLD_PIXEL_SCALE);
    [head addChild:leftEye];
    
    CCSprite *rightEye = [CCSprite spriteWithFile:@"harold_0000_eye.png"];
    rightEye.tag = 1;
    rightEye.position = ccp(5.5*HAROLD_PIXEL_SCALE, 5.5*HAROLD_PIXEL_SCALE);
    [head addChild:rightEye];
    
    CCSprite *mouth = [CCSprite spriteWithFile:@"harold_0001_mouth.png"];
    mouth.tag = 2;
    mouth.position = ccp(4.0*HAROLD_PIXEL_SCALE, 3.5*HAROLD_PIXEL_SCALE);
    [head addChild:mouth];
	
	[self colorParts];
	

    
//    b2Body *headBody;
//    b2BodyDef boxBodyDef;
//    boxBodyDef.type = b2_dynamicBody;
//    boxBodyDef.position.Set(spineLength + torsoBody->GetPosition().x, spineLength + torsoBody->GetPosition().y); 
//    boxBodyDef.userData = head;
//    boxBodyDef.linearDamping = 0.0f;  //adds air resistance to box
//    headBody = world->CreateBody(&boxBodyDef);
//    
//    b2PolygonShape boxShape;
//    float height = [head boundingBox].size.height/PTM_RATIO/2.0f;
//	boxShape.SetAsBox(height, height);// SetAsBox uses the half width and height (extents)
//	
//	b2FixtureDef fixdef;
//	fixdef.shape = &boxShape;
//	fixdef.density = 0.4f;
//	fixdef.friction = 0.8f;
//	fixdef.restitution = 0.1f;
//	headBody->CreateFixture(&fixdef);
//    
//    headBody->SetFixedRotation(TRUE);
    
    
//    //spine
//    //distance from middle of torso to middle of head = 10.5,10.5
//    b2BodyDef bd;
//    bd.type = b2_dynamicBody;
//    bd.position.Set(spineLength/2.0f + torsoBody->GetPosition().x, spineLength/2.0f + torsoBody->GetPosition().y); 
//    bd.angle = M_PI/4;
//    bd.linearDamping = 0.0f;  //adds air resistance to box
//    b2Body *spine = world->CreateBody(&bd);
//    
//	boxShape.SetAsBox(spineLength, 0.2f);// SetAsBox uses the half width and height (extents)
//	
//	fixdef.shape = &boxShape;
//	fixdef.density = 0.1f;
//	fixdef.friction = 0.8f;
//	fixdef.restitution = 0.3f;
//	spine->CreateFixture(&fixdef);
//    
//    //torso spine joint
//    b2RevoluteJointDef rjd;
//    rjd.Initialize(torsoBody, spine, torsoBody->GetPosition());
//    rjd.motorSpeed = -0.1f * b2_pi;
//    rjd.maxMotorTorque = 3.0f;
//    rjd.enableMotor = true;
//    rjd.lowerAngle = 0;
//    rjd.upperAngle = 0.5f * b2_pi;
//    rjd.enableLimit = true;
//    rjd.collideConnected = false;
//    world->CreateJoint(&rjd);
//    
//    //head spine joint
//    b2RevoluteJointDef rjd2;
//    rjd2.Initialize(headBody, spine, headBody->GetPosition());
//    rjd2.motorSpeed = 1.0f * b2_pi;
//    rjd2.maxMotorTorque = 10000.0f;
//    rjd2.enableMotor = false;
//    rjd2.lowerAngle = -M_PI;
//    rjd2.upperAngle = M_PI;
//    rjd2.enableLimit = true;
//    rjd2.collideConnected = false;
//    world->CreateJoint(&rjd2);
	
	[self scheduleUpdate];
		
    
    return self;
}

- (void)dealloc {
	[super dealloc];
}

#pragma mark - public functions
- (void)update :(int)x :(float)velocity {
	//CGSize s = [CCDirector sharedDirector].winSize;
	//self.bear.position = ccp(x + s.width/4, self.position.y + s.height/4);
	//[self setAnimationSpeed:velocity];
}

#pragma mark private functions
- (b2Body *) createBoxBodyForSprite: (CCSprite*)sprite density:(float)density friction:(float)friction restiution:(float)restitution {
    
    b2Body *body;
    b2BodyDef boxBodyDef;
    boxBodyDef.type = b2_dynamicBody;
    CGPoint worldPoint = [self convertToWorldSpace:sprite.position];
    boxBodyDef.position.Set(worldPoint.x/PTM_RATIO, worldPoint.y/PTM_RATIO); 
    boxBodyDef.userData = self;
    boxBodyDef.linearDamping = 1.0f;  //adds air resistance to box
    body = world->CreateBody(&boxBodyDef);
        
    b2PolygonShape boxShape;
    float height = [sprite boundingBox].size.height/PTM_RATIO/2.0f;
	boxShape.SetAsBox(height, height);// SetAsBox uses the half width and height (extents)
	
	b2FixtureDef fixdef;
	fixdef.shape = &boxShape;
	fixdef.density = density;
	fixdef.friction = friction;
	fixdef.restitution = restitution;
	fixdef.filter.groupIndex = -1;  //todo: separate top athlete from bottom athlete, and use different groupIndeces
	body->CreateFixture(&fixdef);
    
    return body;
}

-(void) addMidParts: (NSString*) midParts {
    
    NSArray *partNames = [midParts componentsSeparatedByString:@":"];

    for(int i = 0; i < [partNames count]; ++i) {
        NSString *filename = [partNames objectAtIndex:i];
        AthletePart *part = [AthletePart spriteWithFile:filename];
		float fudge = 0.75f;  //not sure why I need this?
        part.position = ccp(HAROLD_PIXEL_SCALE*DEFAULT_HAROLD_SCALE*(i+1)*2.0f*fudge, HAROLD_PIXEL_SCALE*DEFAULT_HAROLD_SCALE*(i+1)*2.0f*fudge);
		part.homePosition = part.position;
		part.scale = DEFAULT_HAROLD_SCALE;
		part.body = [self createBoxBodyForSprite:part density:1.0f friction:0.8f restiution:0.1f];
		
		CCLOG(@"part pos: %@", NSStringFromCGPoint(part.position));
			  
        [self addChild:part z:1];
		[partSprites addObject:part];
		
    }
    
}

-(void) colorParts {
	
	//torso to head colors
	torso.color = ccc3(216,27,101);
	
	NSString *partColorsString = @"204,68,204;40,68,224;69,176,255;168,255,255;0,204,85;238,238,119;170,255,102";
	NSArray *partColors = [partColorsString componentsSeparatedByString:@";"];
		
	for(int i = 0; i < [partSprites count]; ++i) {
		NSArray *colors = [[partColors objectAtIndex:i] componentsSeparatedByString:@","];
		CCSprite *spr = [partSprites objectAtIndex:i];
		spr.color = ccc3([[colors objectAtIndex:0] intValue], [[colors objectAtIndex:1] intValue], [[colors objectAtIndex:2] intValue]);
	
	}
	
	//color eyes and mouth
	for(CCSprite *spr2 in head.children)
		spr2.color = ccc3(204,68,204);
	
}

- (void) update:(ccTime) dt {
	
	//make parts move towards original position
	for(AthletePart *part in partSprites) {
		
		CGPoint bodyWorldPos = ccp(part.body->GetPosition().x*PTM_RATIO, 
								   part.body->GetPosition().y*PTM_RATIO);
		part.position = [self convertToNodeSpace:bodyWorldPos];
		
		// f = kx
		CGPoint homePosWorld = [self convertToWorldSpace:part.homePosition];
		b2Vec2 d = part.body->GetPosition() - b2Vec2(homePosWorld.x/PTM_RATIO, homePosWorld.y/PTM_RATIO);
		float l = d.Length();
		float k = -40.0f;
		part.body->ApplyForce(k*l*d, part.body->GetPosition());
	}
	
}
@end
