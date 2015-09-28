//
//  DetailAlarmTableViewCell.h
//  CosenCloud
//
//  Created by CosenMac on 2015/9/10.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailAlarmTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dangeLowLable;
@property (weak, nonatomic) IBOutlet UILabel *dangeHighLable;
@property (weak, nonatomic) IBOutlet UILabel *alarmLabel;

@end
