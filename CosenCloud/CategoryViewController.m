//
//  CategoryViewController.m
//  CosenCloud
//
//  Created by CosenMac on 2015/9/7.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "CategoryViewController.h"
#import "DetailViewController.h"
#import "UtilizationViewController.h"
#import "GreenPowerViewController.h"
#import "UserLoginViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
//    UserLoginViewController *UserLogin=[[UserLoginViewController alloc]initWithNibName:@"UserLoginViewController" bundle:nil];
//    
//    UINavigationController *navUserLogin = [[UINavigationController alloc] initWithRootViewController:UserLogin];
//    
//    [self presentViewController:navUserLogin animated:YES completion:nil];
    
    }




- (IBAction)machineDisplay:(id)sender{
    NSLog(@"監控機台選中");
    DetailViewController *DetailView  = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
  
    
    
    //切換畫面
    [self.navigationController pushViewController:DetailView animated:YES];
   ;
    
}

- (IBAction)utilizationBtn:(id)sender {
    NSLog(@"稼動率選中");
    
    UtilizationViewController* utiliVC=[[UtilizationViewController alloc] initWithNibName:@"UtilizationViewController" bundle:[NSBundle mainBundle]];
    
    //切換畫面
    [self.navigationController pushViewController:utiliVC animated:YES];
    ;
    
}
- (IBAction)greenPower:(id)sender {
    NSLog(@"綠能選中");
    
    GreenPowerViewController* gPVC=[[GreenPowerViewController alloc] initWithNibName:@"GreenPowerViewController" bundle:[NSBundle mainBundle]];
    
    //切換畫面
    [self.navigationController pushViewController:gPVC animated:YES];
    ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
