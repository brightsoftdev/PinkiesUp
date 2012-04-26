//http://getsetgames.com/2009/08/30/the-objective-c-singleton/

#import <Foundation/Foundation.h>
 
@interface Singleton : NSObject {
 
}

/** holds global stuff */
+(Singleton*)sharedSingleton;
-(void)sayHello;

@end