//
//  ViewController.m
//  GitDemo
//
//  Created by App Team on 16/2/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "ViewController.h"

#import "FirstViewController.h"
#import <CoreData/CoreData.h>

@interface ViewController (){
    NSMutableArray *array1;
    NSArray *array2;
    
    NSManagedObjectContext *context;
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
    [button addTarget:self action:@selector(addDataToSqlite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(100, 200, 100, 100);
    [addButton setTitle:@"addButton" forState:UIControlStateNormal];
    addButton.backgroundColor = [UIColor redColor];
    [addButton addTarget:self action:@selector(addDataToSqlite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(100, 300, 100, 100);
    [searchButton setTitle:@"searchButton" forState:UIControlStateNormal];
    searchButton.backgroundColor = [UIColor redColor];
    [searchButton addTarget:self action:@selector(searcData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    
//    [self changeThe];
//    [self initCoreData];
}


- (void)initCoreData{
    //从应用程序包中加载模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    //传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //构建SQLite数据库文件的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"person.data"]];
    //添加持久化存储库，这里使用SQLite作为存储库
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) {
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }else{
        NSLog(@"add data success");
    }
    //初始化上下文，设置persistentStoreCoordinator属性
    context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = psc;
    
    
    
}

- (void)addDataToSqlite{
    //传入上下文，创建一个Person实体对象
    NSManagedObject *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    [person setValue:@"MJ" forKey:@"name"];
    [person setValue:[NSNumber numberWithInt:27] forKey:@"age"];
    //传入上下文，创建一个Card实体对象
    NSManagedObject *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
    [card setValue:@"244482972" forKey:@"no"];
    //设置Person和Card之间的关联关系
    [person setValue:card forKey:@"card"];
    
    //利用上下文对象，将数据同步到持久化存储库
    NSError *error = nil;
    BOOL success = [context save:&error];
    if (!success) {
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }else{
        NSLog(@"add data success");
    }
}

- (void)searcData{
    //初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    //设置排序(按照age降序)
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    //设置条件过滤(搜索name中包含字符串"Itcast-1"的记录,注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*Itcast-1*)
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@",@"*Itcast-1*"];
    request.predicate = predicate;
    NSError *error = nil;
    NSArray *objs = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@",[error localizedDescription]];
    }else{
        NSLog(@"search data success");
    }
    NSLog(@"%@", objs);
    for (NSManagedObject *obj in objs) {
        NSLog(@"name = %@", [obj valueForKey:@"name"]);
    }
}

- (void)removeData{
//    [context deleteObject:man]
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
