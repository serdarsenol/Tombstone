//
//  AIViewController.h
//  AnyIdea?
//
//  Created by Serdar Senol on 10/19/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+loadingscreen.h"
#import <QuartzCore/QuartzCore.h>
#import "AIEventCreatorVC.h"
#import "config.h"

@interface AIViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView * eventView;
@property (strong, nonatomic) AIEventCreatorVC *childEventCreatorVC;
@property (strong, nonatomic) IBOutlet UIButton *addEventButton;
@property (strong, nonatomic) IBOutlet UILabel *plusMinusLabel;

- (IBAction)createEvent:(id)sender;
@end
