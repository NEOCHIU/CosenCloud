//
//  DetailViewController.h
//  CosenCloud
//
//  Created by CosenMac on 2015/9/7.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *detailTable;
//動態陣列用來存放Json物件集合
@property (nonatomic)NSMutableArray *ListObj;

@end
