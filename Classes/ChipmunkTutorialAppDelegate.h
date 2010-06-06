//
//  ChipmunkTutorialAppDelegate.h
//  ChipmunkTutorial
//
//  Created by Charlie Fulton on 5/31/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChipmunkTutorialViewController;

@interface ChipmunkTutorialAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    ChipmunkTutorialViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ChipmunkTutorialViewController *viewController;

@end

