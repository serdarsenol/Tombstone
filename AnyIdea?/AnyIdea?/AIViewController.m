//
//  AIViewController.m
//  AnyIdea?
//
//  Created by Serdar Senol on 10/19/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import "AIViewController.h"

@interface AIViewController ()

@end

@implementation AIViewController

@synthesize eventView;
@synthesize childEventCreatorVC;
@synthesize addEventButton;
@synthesize plusMinusLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar addSubview:lineView];
    [self viewEvent];
    addEventButton.backgroundColor=crimsonColor;
    
}

- (IBAction)startLoading:(id)sender {
    [self setLoadingScreenIsShown:YES];
}

- (IBAction)createEvent:(id)sender {
    NSLog(@"Button pressed");
    if ([sender isSelected])
    {
        eventView.hidden=YES;
        plusMinusLabel.text=@"+";
        [sender setSelected:NO];

    }
    else
    {
        eventView.hidden=NO;
        plusMinusLabel.text=@"-";
        [sender setSelected:YES];
    }
    
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    AIEventCreatorVC *viewController = (AIEventCreatorVC *)[storyboard instantiateViewControllerWithIdentifier:@"AIEventCreatorVC"];
//    [self presentViewController:viewController animated:YES completion:nil];
    
    
}

-(void) viewEvent
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    childEventCreatorVC = [sb instantiateViewControllerWithIdentifier:@"AIEventCreatorVC"];


    [self addChildViewController:childEventCreatorVC];
    childEventCreatorVC.view.frame = self.eventView.bounds;
    [eventView addSubview:childEventCreatorVC.view];
    
//    [childEventCreatorVC.view setAlpha:0];
//    [eventView addSubview:childEventCreatorVC.view];
//    [UIView beginAnimations:@"FadeIn" context:nil];
//    [UIView setAnimationDuration:4.5];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [childEventCreatorVC.view setAlpha:1];
//    [UIView commitAnimations];
    
    eventView.hidden = YES;
}

@end
