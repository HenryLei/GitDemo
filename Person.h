//
//  Person.h
//  GitDemo
//
//  Created by App Team on 16/3/1.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSManagedObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *age;
@property(nonatomic, strong) Card *card;

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Person+CoreDataProperties.h"
