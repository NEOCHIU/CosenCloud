//
//  GPDayMonthCell.h
//  CosenCloud
//
//  Created by CosenMac on 2015/9/21.
//  Copyright © 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;

@interface GPDayMonthCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet BarChartView *barView;

@end
