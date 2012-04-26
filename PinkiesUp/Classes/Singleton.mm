#import "Singleton.h"

@implementation Singleton
static Singleton* _sharedSingleton = nil;
 
+(Singleton*)sharedSingleton
{
	@synchronized([Singleton class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
 
		return _sharedSingleton;
	}
 
	return nil;
}
 
+(id)alloc
{
	@synchronized([Singleton class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
 
	return nil;
}
 
-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
	}
 
	return self;
}
 
-(void)sayHello {
	NSLog(@"Hello World!");
}
@end