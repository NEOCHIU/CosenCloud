//
//  DetailAlarmViewController.h
//  CosenCloud
//
//  Created by CosenMac on 2015/9/10.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailAlarmViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *alrmTable;
@property (nonatomic)NSMutableArray *dangeLowObj;
@property (nonatomic)NSMutableArray *dangeHighObj;

@property (nonatomic)NSMutableArray *alarmObj;

@property (nonatomic)NSArray *alarmTitleObject;
@property (weak, nonatomic) IBOutlet UIImageView *radarChar;

@end



