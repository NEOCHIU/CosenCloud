//
//  DetailTableCell.h
//  CosenCloud
//
//  Created by CosenMac on 2015/9/7.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *colorView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bladeIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *bladeCvLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
