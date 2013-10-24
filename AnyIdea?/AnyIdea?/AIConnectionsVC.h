//
//  AIConnectionsVC.h
//  AnyIdea?
//
//  Created by Serdar Senol on 10/19/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIConnectionsCell.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AIPerson.h"
#import "UIViewController+loadingscreen.h"

@interface AIConnectionsVC : UITableViewController

@property (strong, nonatomic) AIPerson * person;
@property (nonatomic, strong) NSMutableArray *tableData;

@end
