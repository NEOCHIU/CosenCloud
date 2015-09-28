//
//  DetailAlarmViewController.m
//  CosenCloud
//
//  Created by CosenMac on 2015/9/10.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "DetailAlarmViewController.h"
#import "DetailAlarmTableViewCell.h"
#import "AppDelegate.h"
#import "DetailInfoObject.h"
#import "DetailObject.h"
#import "JYRadarChart.h"
@interface DetailAlarmViewController ()
{
 JYRadarChart *radarView;
}
@end

@implementation DetailAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alrmTable.delegate = self;
    self.alrmTable.dataSource = self;
    
    self.dangeLowObj = [[NSMutableArray alloc]init];
    self.dangeHighObj = [[NSMutableArray alloc]init];
    self.alarmObj = [[NSMutableArray alloc]init];
    self.alarmTitleObject = [[NSArray alloc]init];
    
    //sigleton 方式
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"Detail畫面內容：%@",ad.detailedInfo);
    
    DetailObject *detObject = ad.detailedInfo;
    //取出 Json Detail 的值
    DetailInfoObject *catInfoObject = detObject.detail[0];
    
    self.alarmTitleObject =@[@"鋸帶健康值",@"鋸帶歪斜",@"主馬達電流",@"切削水馬電流",@"液壓油馬達電流",@"切削水流量",@"環境溫度",@"切削水流浪",@"液壓油溫度",@"減速箱溫度",@"冷卻液酸鹼值"];
    
    NSLog(@"listTitleObject= %@",self.alarmTitleObject);
    
    //將值拆出來分別放進陣列裡
    //危險低的值放入一個陣列
     [self.dangeLowObj addObject:catInfoObject.blade_health_l];
     [self.dangeLowObj addObject:catInfoObject.blade_dev_l];
     [self.dangeLowObj addObject:catInfoObject.main_mator_l];
     [self.dangeLowObj addObject:catInfoObject.water_mator_l];
     [self.dangeLowObj addObject:catInfoObject.oil_mator_l];
     [self.dangeLowObj addObject:catInfoObject.water_l];
     [self.dangeLowObj addObject:catInfoObject.temp_l];
     [self.dangeLowObj addObject:catInfoObject.water_temp_l];
     [self.dangeLowObj addObject:catInfoObject.oil_temp_l];
     [self.dangeLowObj addObject:catInfoObject.gearbox_temp_l];
     [self.dangeLowObj addObject:catInfoObject.ph_l];

    
    //危險高的值放入一個陣列
    [self.dangeHighObj addObject:catInfoObject.blade_health_h];
    [self.dangeHighObj addObject:catInfoObject.blade_dev_h];
    [self.dangeHighObj addObject:catInfoObject.main_mator_h];
    [self.dangeHighObj addObject:catInfoObject.water_mator_h];
    [self.dangeHighObj addObject:catInfoObject.oil_mator_h];
    [self.dangeHighObj addObject:catInfoObject.water_h];
    [self.dangeHighObj addObject:catInfoObject.temp_h];
    [self.dangeHighObj addObject:catInfoObject.water_temp_h];
    [self.dangeHighObj addObject:catInfoObject.oil_temp_h];
    [self.dangeHighObj addObject:catInfoObject.gearbox_temp_h];
    [self.dangeHighObj addObject:catInfoObject.ph_h];

    
    //警告的值放入一個陣列
    [self.alarmObj addObject:catInfoObject.blade_health_alarm];
    [self.alarmObj addObject:catInfoObject.blade_dev_alarm];
    [self.alarmObj addObject:catInfoObject.main_mator_alarm];
    [self.alarmObj addObject:catInfoObject.water_mator_alarm];
    [self.alarmObj addObject:catInfoObject.oil_mator_alarm];
    [self.alarmObj addObject:catInfoObject.water_alarm];
    [self.alarmObj addObject:catInfoObject.temp_alarm];
    [self.alarmObj addObject:catInfoObject.water__temp_alarm];
    [self.alarmObj addObject:catInfoObject.oil_temp_alarm];
    [self.alarmObj addObject:catInfoObject.gearbox_temp_alarm];
    [self.alarmObj addObject:catInfoObject.ph_alarm];
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
    
    return self.alarmTitleObject.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return @"機台警報設定值";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"DetailInfoTableViewCell";
    
    DetailAlarmTableViewCell *cell = (DetailAlarmTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailAlarmTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
      //將陣列資料給予lable.
    cell.titleLabel.text = self.alarmTitleObject[indexPath.row];
     cell.dangeLowLable.text = self.dangeLowObj[indexPath.row];
     cell.dangeHighLable.text = self.dangeHighObj[indexPath.row];
     cell.alarmLabel.text = self.alarmObj[indexPath.row];
    
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
