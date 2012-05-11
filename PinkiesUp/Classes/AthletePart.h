//
//  AthletePart.h
//  PinkiesUp
//
//  Created by Jon Stokes on 5/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface AthletePart : CCSprite {
    
	CGPoint homePosition;
	b2Body *body;
	
}

@property (nonatomic, assign) CGPoint homePosition;
@property (nonatomic, assign) b2Body *body;


@end
