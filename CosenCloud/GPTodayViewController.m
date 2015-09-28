//
//  GPTodayViewController.m
//  CosenCloud
//
//  Created by CosenMac on 2015/9/21.
//  Copyright © 2015年 kidmac. All rights reserved.
//

#import "GPTodayViewController.h"

@interface GPTodayViewController ()
{
    NSMutableArray *dataTitle;
    
}
@end

@implementation GPTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.barTable.delegate=self;
    self.barTable.dataSource=self;
    
    self.dataX = [[NSArray alloc]init];
    self.dataY = [[NSArray alloc]init];
    dataTitle = [[NSMutableArray alloc]init];
    
    
    
self.dataX=@[@"8點",@"9點",@"10點",@"11點",@"12點",@"13點",@"14點",@"15點",@"16點",@"17點"];
    
    
    
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
    static NSString *simpleTableIdentifier = @"GPTodayCell";
    
    GPTodayCell *cell = (GPTodayCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GPTodayCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //charts的設定
    cell.barView.delegate = self;
    //charts的資料連結顯示狀態
    cell.barView.noDataTextDescription = @"You need to provide data for the chart.";
    //charts的動畫
   [cell.barView animateWithXAxisDuration:2.5 easingOption:ChartEasingOptionEaseInOutQuart];
    
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    
    
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
        
        LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithYVals:yVals label:@"DataSet 1"];
              
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        //設定x軸與y軸的資料
        LineChartData *data = [[LineChartData alloc] initWithXVals:self.dataX dataSets:dataSets];
    
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
