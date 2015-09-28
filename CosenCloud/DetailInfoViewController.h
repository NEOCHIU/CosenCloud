//
//  DetailInfoViewController.h
//  CosenCloud
//
//  Created by CosenMac on 2015/9/7.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *InfoTable;
@property (nonatomic)NSMutableArray *listObj;

@property (nonatomic)NSArray *listTitleObject;
@property (weak, nonatomic) IBOutlet UIView *radarChar;




@end
