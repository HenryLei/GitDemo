//
//  ViewController.m
//  GitDemo
//
//  Created by App Team on 16/2/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "ViewController.h"

#import "FirstViewController.h"

@interface ViewController (){
    NSMutableArray *array1;
    NSArray *array2;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    array1 = [NSMutableArray arrayWithObjects:@"1",@"21",@"33",@"10",@"7",@"90",@"15",@"18",@"77",@"54",@"43",@"49",@"38",@"22", nil];
    
    
    array2 = [NSArray arrayWithObjects:@"2",@"3",@"71",@"82",@"29",@"30",@"55",@"66",@"65",@"58",@"42",@"41",@"85",@"78", nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"1" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttongClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    [self changeThe];
}


- (void)changeThe{
    for (int i = 0 ; i < array1.count - 1; i++) {
        for(int j = 0 ; j < array1.count - 1 - i; j++){
            int a = [[array1 objectAtIndex:j] intValue];
            int b = [[array1 objectAtIndex:j+1] intValue];
            if (a>b) {
                [array1 replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%d",b]];
                
                [array1 replaceObjectAtIndex:j+1 withObject:[NSString stringWithFormat:@"%d",a]];
            }
        }
    }
    
    NSLog(@"%@",array1);
}

- (void)buttongClick{
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    self.delegate = firstVC;
    [self.delegate passFirstViewValue:@"Henry lei test"];
    [self performSegueWithIdentifier:@"firstView" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
