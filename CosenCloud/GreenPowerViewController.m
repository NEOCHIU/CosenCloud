//
//  GreenPowerViewController.m
//  CosenCloud
//
//  Created by CosenMac on 2015/9/21.
//  Copyright © 2015年 kidmac. All rights reserved.
//

#import "GreenPowerViewController.h"
#import "GPTodayViewController.h"
#import "GPDayViewController.h"
#import "GPMonthViewController.h"
#import "YSLContainerViewController.h"
@interface GreenPowerViewController ()<YSLContainerViewControllerDelegate>

@end

@implementation GreenPowerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // SetUp ViewControllers
    
    GPTodayViewController *GPTodayVC = [[GPTodayViewController alloc]initWithNibName:@"GPTodayViewController" bundle:nil];
    GPTodayVC.title = @"今日綠能";
//    GPDayViewController *GPTodayVC = [[GPDayViewController alloc]initWithNibName:@"GPDayViewController" bundle:nil];
//    GPTodayVC.title = @"日綠能";
    
    GPDayViewController *GPDayVC = [[GPDayViewController alloc]initWithNibName:@"GPDayViewController" bundle:nil];
    GPDayVC.title = @"日綠能";
    
    GPMonthViewController *GPMonthVC = [[GPMonthViewController alloc]initWithNibName:@"GPMonthViewController" bundle:nil];
    GPMonthVC.title = @"月綠能";
    
    
    //    // ContainerView
    float statusHeight = 0;
    //    NSLog(@"statusHeight %f",statusHeight);
    float navigationHeight = 0;
    //    NSLog(@"navigationHeight %f",navigationHeight);
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[GPTodayVC,GPDayVC,GPMonthVC]topBarHeight:statusHeight + navigationHeight parentViewController:self];
    
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
