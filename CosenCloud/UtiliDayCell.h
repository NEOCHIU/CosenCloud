//
//  UtiliDayCell.h
//  CosenCloud
//
//  Created by CosenMac on 2015/9/16.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Charts/Charts.h>

@import Charts;

@interface UtiliDayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet BarChartView *barView;

@end
