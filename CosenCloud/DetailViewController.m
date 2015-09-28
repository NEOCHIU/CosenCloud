//
//  DetailViewController.m
//  CosenCloud
//
//  Created by CosenMac on 2015/9/7.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "DetailInfoViewController.h"
#import "DetailInfoObject.h"
#import "DetailObject.h"
#import "DetailTableCell.h"
#import "DetailAlarmViewController.h"
#import "JRSegmentViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailTable.delegate =self;
    self.detailTable.dataSource = self;
    

    
    //  //讀取url
    NSURL *url = [NSURL URLWithString:@"http://beta.json-generator.com/api/json/get/EkGotXB6"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //取得Json資訊
    NSArray* jsonobj = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingMutableContainers
                                                         error:nil];
    //初始化Listobj物件
    _ListObj = [[NSMutableArray alloc]init];
    
    //代出NSArray裡面的所有值，轉成物件後，存放到NSMutableArray裡面
    [jsonobj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSDictionary* jsonArray = [jsonobj objectAtIndex:idx];
        NSLog(@"array1:%@",jsonArray);
        DetailObject *product = [[DetailObject alloc] initWithDictionary:jsonArray error:nil];
        [_ListObj addObject:product];
       
    }];
    
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _ListObj.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return @"機台狀態";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *simpleTableIdentifier = @"DetailTableCell";
    DetailTableCell *cell = (DetailTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //取得NSMutableArray裡面的物件
    //接著就可以用物件屬性的方式來操作物件
    
    DetailObject *detailObject = [_ListObj objectAtIndex:[indexPath row]];
    
    //接著就可以用物件屬性的方式來操作物件
    cell.nameLabel.text = detailObject.machine;
    cell.bladeIdLabel.text = detailObject.blad_id;
    cell.statusLabel.text = detailObject.machine_status;
    cell.bladeCvLabel.text = detailObject.blade_cv;

       if ([detailObject.machine_status isEqual:@"1"]) {
     cell.statusLabel.text = @"Alarm";
     cell.statusLabel.textColor = [UIColor redColor];     
     cell.imageView.image = [UIImage imageNamed:@"red.png"];
    
    }else if ([detailObject.machine_status isEqual:@"2"]) {
        cell.statusLabel.text = @"working";
        cell.statusLabel.textColor = [UIColor greenColor];
        cell.imageView.image = [UIImage imageNamed:@"green.png"];
    }else if ([detailObject.machine_status isEqual:@"3"]) {
        cell.statusLabel.text = @"閒置";
         cell.statusLabel.textColor = [UIColor orangeColor];
        cell.imageView.image = [UIImage imageNamed:@"yellow.png"];
    }else  {
        cell.statusLabel.text = @"OFF";
        cell.statusLabel.textColor = [UIColor grayColor];
        cell.imageView.image = [UIImage imageNamed:@"gray.png"];
    
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    CatObject *catObject = [_ListObj objectAtIndex:[indexPath row]];
    
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"_ListObj[indexPath.row] = %@",_ListObj[indexPath.row]);
    ad.detailedInfo = _ListObj[indexPath.row];
    
//   傳送到詳細資料
//   DetailInfoViewController *detailInfo = [[DetailInfoViewController alloc] initWithNibName:@"DetailInfoViewController" bundle:nil];
    
   //傳送到警告資料
   //  DetailAlarmViewController *detailAlarmVC  = [[DetailAlarmViewController alloc]
   // initWithNibName:@"DetailAlarmViewController" bundle:[NSBundle mainBundle]];
    
//    [self.navigationController pushViewController:detailInfo animated:YES];
  //  [self.navigationController pushViewController:detailAlarmVC animated:YES];
    
    //進入詳細分類
    DetailInfoViewController *detaiInfoVC = [[DetailInfoViewController alloc] init];
    DetailAlarmViewController *detailAlarmVC = [[DetailAlarmViewController alloc] init];
 
    JRSegmentViewController *vc = [[ JRSegmentViewController alloc] init];
    
    //DetailMultipleViewsController *vc = [[ DetailMultipleViewsController alloc] init];
    
    
    vc.segmentBgColor = [UIColor colorWithRed:18.0f/255 green:50.0f/255 blue:110.0f/255 alpha:1.0f];
    vc.indicatorViewColor = [UIColor whiteColor];
    
    [vc setViewControllers:@[detaiInfoVC, detailAlarmVC]];
    [vc setTitles:@[@"詳細資料", @"機台警報"]];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
