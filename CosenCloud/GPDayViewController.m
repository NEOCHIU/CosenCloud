//
//  GPDayViewController.m
//  CosenCloud
//
//  Created by CosenMac on 2015/9/21.
//  Copyright © 2015年 kidmac. All rights reserved.
//

#import "GPDayViewController.h"

@interface GPDayViewController ()
{
    NSMutableArray *dataTitle;
    
}
@end

@implementation GPDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.barTable.delegate=self;
    self.barTable.dataSource=self;
    
    self.dataX = [[NSArray alloc]init];
    self.dataY = [[NSArray alloc]init];
    dataTitle = [[NSMutableArray alloc]init];
    
    
    
    self.dataX=@[@"8/18",@"8/19",@"8/20",@"8/21",@"8/22",@"8/23",@"8/24",@"8/25",@"8/26",@"8/27"];
    
    
    
    NSArray *arr1 =@[@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"9"];
    NSArray *arr2 =@[@"12",@"19",@"3",@"17",@"13",@"17",@"6",@"7",@"18",@"9"];
    NSArray *arr3 =@[@"14",@"1",@"14",@"16",@"4",@"6",@"12",@"7",@"18",@"9"];
    NSArray *arr4 =@[@"15",@"9",@"5",@"3",@"9",@"10",@"14",@"7",@"18",@"9"];
    
    
    self.dataY=@[arr1,arr2,arr3,arr4];
    
    //Y軸一個陣列元素
    //  self.dataY=@[@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19"];
    
    [dataTitle addObject:@"M1"];
    [dataTitle addObject:@"M2"];
    [dataTitle addObject:@"M3"];
    [dataTitle addObject:@"M4"];
    
    
    
    
    NSLog(@"dataTitle count==%lu",(unsigned long)dataTitle.count);
    NSLog(@"dataX=%@",self.dataX);
    NSLog(@"dataY=%@",self.dataY);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataTitle.count;
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return @"機台詳細列表";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"GPDayMonthCell";
    
    GPDayMonthCell *cell = (GPDayMonthCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GPDayMonthCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //charts的設定
    cell.barView.delegate = self;
    //charts的資料連結顯示狀態
    cell.barView.noDataTextDescription = @"You need to provide data for the chart.";
    //charts的動畫
    [cell.barView animateWithYAxisDuration:2.5];
    
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    
    //charts的x軸顯示
    ChartXAxis *xAxis = cell.barView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.spaceBetweenLabels = 2.0;
    
    //charts的y軸顯示
    ChartYAxis *leftAxis = cell.barView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    //  leftAxis.labelCount = 10;
    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];
    leftAxis.valueFormatter.maximumFractionDigits = 1;
    leftAxis.valueFormatter.negativeSuffix = @" %";
    leftAxis.valueFormatter.positiveSuffix = @" %";
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    //    leftAxis.spaceTop = 0.15;
    
    //將Ｙ軸陣列值給予charts的Ｙ軸
    for (int i = 0; i < _dataY.count; i++)
    {
        //每跑完一個元素刪除裡面值;
        [yVals removeAllObjects];
        
        for (int j = 0; j < [self.dataY[i] count]; j++)
        {
            NSString *val = [self.dataY[i] objectAtIndex:j];
            double val1 = (val.doubleValue);
            NSLog(@"val=%f",val1);
            [yVals addObject:[[BarChartDataEntry alloc] initWithValue:val1 xIndex:j]];
            
        }
        
        BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"DataSet"];
        set1.barSpace = 0.35;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        //設定x軸與y軸的資料
        BarChartData *data = [[BarChartData alloc] initWithXVals:self.dataX dataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        [datas addObject:data];
    }
    
    cell.barView.data = datas[indexPath.row];
    cell.titleLabel.text = dataTitle[indexPath.row];
    
    return cell;
    
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
