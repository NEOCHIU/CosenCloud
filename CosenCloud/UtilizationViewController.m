//
//  UtilizationViewController.m
//  CosenCloud
//
//  Created by kid chiu on 2015/9/12.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "UtilizationViewController.h"
#import "UtilizationTodayViewController.h"
#import "UtilizationDayViewController.h"
#import "UtilizationMonthViewController.h"
#import "UtilizationWeekViewController.h"
#import "YSLContainerViewController.h"
@interface UtilizationViewController ()<YSLContainerViewControllerDelegate>

@end

@implementation UtilizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // SetUp ViewControllers
    UtilizationTodayViewController *utiliTodayVC = [[UtilizationTodayViewController alloc]initWithNibName:@"UtilizationTodayViewController" bundle:nil];
    utiliTodayVC.title = @"今日稼動率";
    
    UtilizationDayViewController *utiliDayVC = [[UtilizationDayViewController alloc]initWithNibName:@"UtilizationDayViewController" bundle:nil];
    utiliDayVC.title = @"日稼動率";
    
    UtilizationWeekViewController *utiliWeekVC = [[UtilizationWeekViewController alloc]initWithNibName:@"UtilizationWeekViewController" bundle:nil];
    utiliWeekVC.title = @"星期稼動率";
    
    UtilizationMonthViewController *utiliMonthVC = [[UtilizationMonthViewController alloc]initWithNibName:@"UtilizationMonthViewController" bundle:nil];
    utiliMonthVC.title = @"月稼動率";
    
    
//    // ContainerView
    float statusHeight = 0;
//    NSLog(@"statusHeight %f",statusHeight);
    float navigationHeight = 0;
//    NSLog(@"navigationHeight %f",navigationHeight);
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[utiliTodayVC,utiliDayVC,utiliWeekVC,utiliMonthVC]topBarHeight:statusHeight + navigationHeight parentViewController:self];
    
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    containerVC.menuItemTitleColor = [UIColor blackColor];//未選到顏色
    containerVC.menuItemSelectedTitleColor = [UIColor redColor];//選到顏色
    
    containerVC.menuIndicatorColor = [UIColor blueColor];
    [self.view addSubview:containerVC.view];
}
#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //    NSLog(@"current Index : %ld",(long)index);
    //    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
