//
//  AppDelegate.h
//  MatchingGame
//
//  Created by Jeremy Jacques on 12-03-11.
//  Copyright Jacques Development 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
