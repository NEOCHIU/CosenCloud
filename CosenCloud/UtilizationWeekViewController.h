//
//  UtilizationWeekViewController.h
//  CosenCloud
//
//  Created by CosenMac on 2015/9/11.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtiliDayCell.h"
@interface UtilizationWeekViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic,strong) NSArray *dataX ;
@property(nonatomic,strong) NSArray *dataY ;
@property (weak, nonatomic) IBOutlet UITableView *barTable;


@end
