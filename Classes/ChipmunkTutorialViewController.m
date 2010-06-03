//
//  ChipmunkTutorialViewController.m
//  ChipmunkTutorial
//
// Following the "An Introduction to game physics with Chipmunk found at
// http://www.alexandre-gomes.com/articles/chipmunk/

//  Created by Charlie Fulton on 5/31/10.
//

#import "ChipmunkTutorialViewController.h"
#import "chipmunk.h"

@implementation ChipmunkTutorialViewController


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	//TODO get the size dynamically
	
	floor = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"floor.png"]];
	
	floor.center = CGPointMake(350, 350);
	
	ball =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
	ball.center = CGPointMake(350,230);
	
	[self.view addSubview:floor];
	[self.view addSubview:ball];
	
	[self setupChipmunk];
}

// our chipmunk methods!

/*
 * Bootstraps chipmunk and the timer
 */
- (void) setupChipmunk
{
	// Start chipmunk
	cpInitChipmunk();
	
	
	// -- Space Setup --//
	
	// create out space object, this holds everything! it's space man!
	space = cpSpaceNew();
	
	// setup gravity! DUDE! 
	// cpv is a helper method that returns vectors
	space->gravity = cpv(0,-100);
	
	// Note here that if you are using too much CPU the real frame rate will be lower and 
	// the timer might fire before the last frame was complete
	
	// there are techniques you can use to avoid this (look into these!!!)
	[NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(tick:) userInfo:nil repeats:YES];
	
	
	// -- Ball object setup --//
	
	// define the bodies that will be in our space
	// gives the ball a mass of 100 with infinite moment
	cpBody* ballBody = cpBodyNew(100.0, INFINITY);
	
	// set the initial position
	ballBody->p = cpv(350,250);
	
	// now add the body to the space
	cpSpaceAddBody(space, ballBody);
	
	// now define shape for the body
	
	cpShape* ballShape = cpCircleShapeNew(ballBody, 20.0, cpvzero);
	
	ballShape->e = 0.5; //Elasticity
	ballShape->u = 0.8; //Friction
	ballShape->data = ball; //Associate with our ball's UIImageView
	ballShape->collision_type = 1; // Collisions are groupd by types
	
	// add the shape to the space
	cpSpaceAddShape(space, ballShape);
	
	// -- Floor object setup --//
	
	// we now need to setup the floor. 
	// Note: since the floor is a static(doesn't move ever) object we don't want to add it to the space
	// because if we did then gravity would act upon it. Also the mass doesn't matter on it. 
	
	// create the floor object
	cpBody* floorBody = cpBodyNew(INFINITY, INFINITY);
	floorBody->p = cpv(160, 480-350);
	
	cpVect verts1[] = { cpv(0.0, 0.0), cpv(50.0, 0.0), cpv(45.0, -15.0), cpv(0.0, -15.0)};
	cpVect verts2[] = { cpv(50.0, 0.0), cpv(116.0, -66.0), cpv(110.0, -81.0), cpv(45.0, -15.0)};
	cpVect verts3[] = { cpv(116.0, -66.0), cpv(204.0, -66.0), cpv(210.0, -81.0), cpv(110.0, -81.0)};
	cpVect verts4[] = { cpv(204.0, -66.0), cpv(270.0, 0.0), cpv(275.0, -15.0), cpv(210.0, -81.0)};
	cpVect verts5[] = { cpv(270.0, 0.0), cpv(320.0, 0.0), cpv(320.0, -15.0), cpv(275.0, -15.0)};
	
	
	
	
	
}



/**
 Tracking the ball's movements:
 
 We need to link chipmunk simulation with the graphics in a way that the ball moves correctly.
 This is done by extending the tick method and reading new positions from Chipmunk with with we 
 update our image's coordinates. This process can be achived in many different ways.
 
 Chipmunk is designed to keep things as simple and as abstract as a possible. This next piece of code is something
 you usually need to write once and rarely bother to update it unless there is one or another details that 
 was left out
 
 Called at each "frame" of the simulation
 
*/
- (void) tick:(NSTimer *)timer
{
	// tell chipmunk to take another "step" in the simulation
	cpSpaceStep(space, 1.0f/60.0f);
	
	
	// This function takes a hash(an array), a function to be called for each element in the the array
	// and optionally a custom data parameter
	cpSpaceHashEach(space->activeShapes, &updateShape, nil);
	
	
	
}


void updateShape(void* ptr, void* unused)
{
	// get our shape
	cpShape* shape = (cpShape*) ptr;
	
	// make sure everything is as expected or exit
	if (shape == nil || shape->body == nil || shape->data == nil) 
	{
	   NSLog(@"Unexpected shape please debug here...");
	}
	
	// Check if the object is an UIView of any kind and update position
	if ([shape->data isKindOfClass:[UIView class]])
	{
	
		[(UIView *)shape->data setCenter:CGPointMake(shape->body->p.x, 200 - shape->body->p.y)];
		
	}
	else
	{
		NSLog(@"The shape data wasn't updateable using this code.");
	
	}
	
	return;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
}

- (void)didReceiveMemoryWarning 
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
