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
	
	//===
    // Device Width & Height
    //===
    CGFloat width;
    CGFloat height;
}

- (void) setupChipmunk; // Bootstraps chipmunk and the timer
- (void) tick: (NSTimer *) timer; // Fires at "frame"

void updateShape (void *ptr, void* unused);

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;


@end

