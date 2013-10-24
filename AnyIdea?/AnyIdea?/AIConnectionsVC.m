//
//  AIConnectionsVC.m
//  AnyIdea?
//
//  Created by Serdar Senol on 10/19/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import "AIConnectionsVC.h"

@interface AIConnectionsVC ()

@end

@implementation AIConnectionsVC

@synthesize person;
@synthesize tableData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    tableData = [[NSMutableArray alloc] init];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar addSubview:lineView];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [self getPersonOutOfAddressBook];    
    NSSortDescriptor * sortDesc = [[NSSortDescriptor alloc] initWithKey:@"fullName" ascending:YES];
    [tableData sortUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
    [self.tableView reloadData];
    [self setLoadingScreenIsShown:NO];

}

-(void)viewWillAppear:(BOOL)animated
{
    NSMutableArray *emails = [NSMutableArray array];
    for (person in tableData) {
        if (person.homeEmail != nil) {
            [emails addObject:person.homeEmail];
        } else if (person.workEmail != nil){
            [emails addObject:person.workEmail];
        }
    }
}

- (void)getPersonOutOfAddressBook
{
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    __block BOOL accessGranted = NO;
    
    if (ABAddressBookRequestAccessWithCompletion != NULL) {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     accessGranted = granted;
                                                     dispatch_semaphore_signal(sema);
                                                 });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else {
        accessGranted = YES;
    }
    if (accessGranted)
    {
        if (addressBook != nil)
        {
            NSArray *allContacts = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
            NSUInteger i = 0;
            for (i = 0; i < [allContacts count]; i++)
            {
                person = [[AIPerson alloc] init];
                ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
                NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty);
                NSString *lastName =  (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
                NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
                NSData * imageData = (__bridge NSData *)ABPersonCopyImageData(contactPerson);
                UIImage * userImage = [UIImage imageWithData:imageData];
                //email
                ABMultiValueRef emails = ABRecordCopyValue(contactPerson, kABPersonEmailProperty);
                
                NSUInteger j = 0;
                for (j = 0; j < ABMultiValueGetCount(emails); j++)
                {
                    NSString *email = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, j);
                    if (j == 0)
                    {
                        person.homeEmail = email;
                    }
                    
                    else if (j==1)
                        person.workEmail = email;
                }
                NSString *fullText = [NSString stringWithFormat:@"%@ %@ %@", firstName, lastName, emails];
                NSMutableArray *arrayOfEmails = [NSMutableArray array];
                for (int i = 0; i < ABMultiValueGetCount(emails); i++)
                {
                    NSString *email = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, i);
                    [arrayOfEmails addObject:email];
                }
                person.fullText=fullText;
                person.firstName = firstName;
                person.lastName = lastName;
                person.userImage =userImage;
                
                if (firstName==nil && lastName)
                {
                    person.fullName=lastName;
                    [tableData addObject:person];
                } else  if (lastName==nil && firstName)
                {
                    person.fullName=firstName;
                    [tableData addObject:person];
                } else  if (firstName && fullName)
                {
                    person.fullName=fullName;
                    [tableData addObject:person];
                }
                
            }
        }
    }
    CFBridgingRelease(addressBook);
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    int rowCount;
        rowCount = tableData.count;
    return rowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AIConnectionsCell";
    AIConnectionsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];



        cell.inviteButton.tag = indexPath.row;
        [cell.inviteButton addTarget:self action:@selector(onAlertPressed:) forControlEvents:UIControlEventTouchUpInside];
        person=[tableData objectAtIndex:indexPath.row];
        cell.contactNameLabel.text = person.fullName;
        cell.contactImageView.image = person.userImage;
        if (person.userImage==nil)
        {
            [cell.contactImageView setImage:[UIImage imageNamed:@"checkbox.png"]];
        }

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 63, self.view.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:98/255.0 green:87.0/255.0 blue:84.0/255.0 alpha:1.0];
    [cell.contentView addSubview:lineView];
        
    return cell;
}

-(void) onAlertPressed:(id)sender
{
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
