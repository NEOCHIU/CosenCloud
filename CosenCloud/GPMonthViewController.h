//
//  GPMonthViewController.h
//  CosenCloud
//
//  Created by CosenMac on 2015/9/21.
//  Copyright © 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPDayMonthCell.h"
@interface GPMonthViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic,strong) NSArray *dataX ;
@property(nonatomic,strong) NSArray *dataY ;

@property (weak, nonatomic) IBOutlet UITableView *barTable;

@end
