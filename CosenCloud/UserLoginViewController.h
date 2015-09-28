//
//  UserLoginViewController.h
//  CosenCloud
//
//  Created by kid chiu on 2015/9/5.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginObject.h"

@interface UserLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *userPwdText;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UISwitch *userDefSwitch;


- (IBAction)userDefSwitch:(id)sender;




//動態陣列用來存放Json物件集合
@property (nonatomic)NSMutableArray *ListObj;
@end
