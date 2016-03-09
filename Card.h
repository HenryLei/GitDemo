//
//  Card.h
//  GitDemo
//
//  Created by App Team on 16/3/1.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSManagedObject
@property(nonatomic, strong) NSString *no;
@property(nonatomic, strong) Person *person;
// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Card+CoreDataProperties.h"
