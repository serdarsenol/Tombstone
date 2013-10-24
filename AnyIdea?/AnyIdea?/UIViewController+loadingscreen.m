//
//  UIViewController+loadingscreen.m
//  AnyIdea?
//
//  Created by Serdar Senol on 10/19/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import "UIViewController+loadingscreen.h"

@implementation UIViewController (loadingscreen)
UIActivityIndicatorView *spinner;
UIView *backgroundSpinner;

-(void)setLoadingScreenIsShown:(BOOL)isShown
{

        if (isShown) {
            
            spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            spinner.center = CGPointMake(self.navigationController.view.frame.size.width/2, self.navigationController.view.frame.size.height/2-32);
            spinner.hidesWhenStopped = YES;
            
           // backgroundSpinner =[[UIView alloc]initWithFrame:self.navigationController.view.frame];
            backgroundSpinner =[[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.view.frame.size.height-(self.navigationController.view.frame.size.height-64), self.navigationController.view.frame.size.width, (self.navigationController.view.frame.size.height-44))];
            backgroundSpinner.backgroundColor=[UIColor blackColor];
            backgroundSpinner.alpha=0.5;
            [backgroundSpinner addSubview:spinner];
            [[UIApplication sharedApplication].keyWindow addSubview:backgroundSpinner];
         //   [self.navigationController.view addSubview:backgroundSpinner];
            [spinner startAnimating];
        } else {
            [spinner stopAnimating];
            [backgroundSpinner removeFromSuperview];
        }
}

@end
