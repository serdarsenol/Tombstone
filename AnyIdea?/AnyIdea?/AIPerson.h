//
//  AIPerson.h
//  AnyIdea?
//
//  Created by Serdar Senol on 10/19/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIPerson : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *homeEmail;
@property (nonatomic, copy) NSString *workEmail;
@property (nonatomic, copy) UIImage * userImage;
@property (nonatomic, copy) NSString *fullText;

@end
