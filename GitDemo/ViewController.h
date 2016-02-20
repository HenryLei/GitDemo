//
//  ViewController.h
//  GitDemo
//
//  Created by App Team on 16/2/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FirstViewDelegate
- (void)passFirstViewValue:(NSString *)string;
@end



@interface ViewController : UIViewController

@property(nonatomic, strong) id<FirstViewDelegate>delegate;

@end

