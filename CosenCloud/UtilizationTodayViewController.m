//
//  UtilizationTodayViewController.m
//  CosenCloud
//
//  Created by CosenMac on 2015/9/11.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "UtilizationTodayViewController.h"
#import "PNChart.h"

@interface UtilizationTodayViewController ()

@end

@implementation UtilizationTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //For Pie Chart 給予值
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:6 color:PNRed description:@"總警報"],
                       [PNPieChartDataItem dataItemWithValue:6 color:PNBlue description:@"總閒置"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"總加工"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNYellow description:@"總離線"],
                       ];
    
    
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 155.0, 240.0, 240.0) items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    [pieChart strokeChart];
     [self.view addSubview:pieChart];
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
