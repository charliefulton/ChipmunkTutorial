//
//  ChipmunkTutorialAppDelegate.m
//  ChipmunkTutorial
//
//  Created by Charlie Fulton on 5/31/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ChipmunkTutorialAppDelegate.h"
#import "ChipmunkTutorialViewController.h"

@implementation ChipmunkTutorialAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    


    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	return YES;
}


- (void)dealloc 
{
    [viewController release];
    [window release];
    [super dealloc];
}


@end
