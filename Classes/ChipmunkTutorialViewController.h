//
//  ChipmunkTutorialViewController.h
//  ChipmunkTutorial
//
//  Created by Charlie Fulton on 5/31/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chipmunk.h"

@interface ChipmunkTutorialViewController : UIViewController 
{
	UIImageView* floor; //Holds our floor image
	UIImageView* ball; //Holds our ball image
	
	cpSpace* space; // Holds our space object
}

- (void) setupChipmunk; // Bootstraps chipmunk and the timer
- (void) tick: (NSTimer *) timer; // Fires at "frame"

// guess this is a c function no - in front!
void updateShape (void *ptr, void* unused);
//- (void) updateShape(void *ptr, void* unused); // Updates a shapes visual representation (i.e. sprite)

@end

