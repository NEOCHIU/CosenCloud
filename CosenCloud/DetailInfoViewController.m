//
//  DetailInfoViewController.m
//  CosenCloud
//
//  Created by CosenMac on 2015/9/7.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "DetailInfoViewController.h"
#import "AppDelegate.h"
#import "DetailInfoObject.h"
#import "DetailObject.h"
#import "DetailInfoTableViewCell.h"
#import "JYRadarChart.h"
@interface DetailInfoViewController ()
{
    JYRadarChart *radarView;
}
@end

@implementation DetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.InfoTable.delegate = self;
    self.InfoTable.dataSource = self;
    
    self.listObj = [[NSMutableArray alloc]init];
    self.listTitleObject = [[NSArray alloc]init];
    
    //sigleton 方式
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"Detail畫面內容：%@",ad.detailedInfo);
    
    DetailObject *detObject = ad.detailedInfo;
    //取出 Json Detail 的值
    DetailInfoObject *catInfoObject = detObject.detail[0];
    
    //將JSON的值都放入Listobj陣列裡，因考慮排序問題，暫時一個個加上去.
    [_listObj addObject:catInfoObject.time_stamp];
    [_listObj addObject:catInfoObject.machine_name];
    [_listObj addObject:catInfoObject.machine_id];
    [_listObj addObject:catInfoObject.blade_name];
    [_listObj addObject:catInfoObject.standard_deviation];
    [_listObj addObject:catInfoObject.utillization];
    [_listObj addObject:catInfoObject.cutting_rate];
    [_listObj addObject:catInfoObject.accu_area];
    [_listObj addObject:catInfoObject.ambient_temp];
    [_listObj addObject:catInfoObject.hydraulic_oil_temp];
    [_listObj addObject:catInfoObject.coolant_water_temp];
    [_listObj addObject:catInfoObject.gearbox_temp];
    [_listObj addObject:catInfoObject.ph];
    [_listObj addObject:catInfoObject.main_mator_cur];
    [_listObj addObject:catInfoObject.coolant_mator_cur];
    [_listObj addObject:catInfoObject.hydraulic_motor_cur];

    
    NSLog(@"catInfoObject為：%@",catInfoObject);
    
    self.listTitleObject =@[@"Time Stamp",@"Machine Name",@"Machine ID",@"Blade Name",@"Standard Deviation",@"Utillization",@"Cutting Rate",@"Accu Area",@"Ambient Temp",@"Hydroulic Oil Temp",@"Coolant Water Teemp",@"Gear Box Temp",@"PH",@"Main Motor Cur",@"Coolant Motor Cur",@"Hydraulic Motor Cur"];

    NSLog(@"listTitleObject= %@",self.listTitleObject);
    
    //雷達圖顯示

    radarView = [[JYRadarChart alloc] initWithFrame:CGRectMake(70, 80, 200, 160)];
    //char 資料存放處
    NSArray *a1 = @[@(0.5), @(0.3), @(0.4), @(0.5), @(0.6), @(1)];
    radarView.dataSeries = @[a1];
    //設雷達圖圈數
    radarView.steps = 5;
    radarView.showStepText = YES;
    radarView.backgroundColor = [UIColor clearColor];
    radarView.r = 60;
    radarView.minValue = 0;
    radarView.maxValue = 1;
    //是否要填滿圖
    radarView.fillArea = YES;
    radarView.colorOpacity = 0.6;
    radarView.drawPoints = 6;
    radarView.backgroundFillColor = [UIColor clearColor ];
    radarView.attributes = @[@"Machine", @"Blade", @"Brush", @"GearBox", @"Hydraulic", @"Coolant"];
    radarView.showLegend = YES;
    [radarView setTitles:@[@"Health"]];
    [radarView setColors:@[[UIColor blueColor]]];
    [self.radarChar addSubview:radarView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _listObj.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return @"機台詳細列表";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"DetailInfoTableViewCell";
    
    DetailInfoTableViewCell *cell = (DetailInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailInfoTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //DetailInfoObject *detailObject = [_listObj objectAtIndex:[indexPath row]];

    //針對某的值產色顏色，但是都在同個Label，一旦換了就全部換，除非寫死.
//    if (self.listObj[7]) {
//        NSLog(@"進入換色");
//        
//    if ([(self.listObj[7])doubleValue]>= 0.7) {
//     cell.valueText.textColor = [UIColor greenColor];
//     cell.valueText.text =self.listObj[7];
//     
//        NSLog(@"1");
//    
//       }
//    if([(self.listObj[7])doubleValue] >= 0.2 && [(self.listObj[7])doubleValue] <= 0.5){
//        cell.valueText.textColor = [UIColor orangeColor];
//        cell.valueText.text =self.listObj[7];
//        NSLog(@"2");
//      }
//    if ([(self.listObj[7])doubleValue] <= 0.2 ){
//        cell.valueText.textColor = [UIColor redColor];
//        cell.valueText.text =self.listObj[7];
//        NSLog(@"3");
//       }
//    }
    //將陣列資料給予lable.
    cell.valueText.textColor = [UIColor blackColor];
    cell.valueText.text = self.listObj[indexPath.row];
    cell.titleText.text = self.listTitleObject[indexPath.row];
    
    
    
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
