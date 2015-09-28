//
//  UserLoginViewController.m
//  CosenCloud
//
//  Created by kid chiu on 2015/9/5.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "UserLoginViewController.h"
#import "CategoryViewController.h"
#import "CRGradientNavigationBar.h"//導航顏色
#import "WKAlertView.h" //警告畫面

@interface UserLoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate>{
    NSUserDefaults *user;
    NSString *userName;
    NSString *userPwd;
    UIView *myview;
    UIActivityIndicatorView *loadActView;
    UINavigationController *navigationController;
    UIWindow *__sheetWindow ;//宣告全域變數
    NSString *alertString; //宣告全域變數
 
}

@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameText.delegate=self;
    self.userPwdText.delegate=self;
    
    
    
    //設定 navigationController的顏色
    navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[CRGradientNavigationBar class] toolbarClass:nil];
    
    UIColor *firstColor = [UIColor colorWithRed:255.0f/255.0f green:42.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
    UIColor *secondColor = [UIColor colorWithRed:255.0f/255.0f green:90.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    
    [[CRGradientNavigationBar appearance] setBarTintGradientColors:colors];
    [[navigationController navigationBar] setTranslucent:NO]; // Remember, the default value is YES.
   
   
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    //讀取url 抓取JSON 資料
    
    NSURL *url = [NSURL URLWithString:@"http://beta.json-generator.com/api/json/get/N1_o5lNa"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //判斷是否有網路可以撈得到資料
    if (data == nil) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"未能連接API,請確認連線狀態" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [av show];
        NSLog(@"data = %@",data);
       
        
    }else{//有網路且能撈資料
        
        
        //取得Json資訊
        NSArray* jsonobj = [NSJSONSerialization JSONObjectWithData:data
                                                           options:NSJSONReadingMutableContainers
                                                             error:nil];
        //初始化Listobj物件
        _ListObj = [[NSMutableArray alloc]init];
        
        //迭代出NSArray裡面的所有值，轉成物件後，存放到NSMutableArray裡面
        [jsonobj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            NSDictionary* jsonArray = [jsonobj objectAtIndex:idx];
            NSLog(@"mapArray:%@",jsonArray);
            LoginObject *product = [[LoginObject alloc] initWithDictionary:jsonArray error:nil];
            [_ListObj addObject:product];
            NSLog(@"mapArrayListObj:%@",_ListObj);
            
        }];
        //使用Defaults 儲存使用者 帳號 密碼
        user = [NSUserDefaults standardUserDefaults];
        
        //顯示使用者預設值
        self.userNameText.text = [ [NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        self.userPwdText.text = [ [NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
        self.userDefSwitch.on = [[NSUserDefaults standardUserDefaults] objectForKey:@"switchkey"];
        
        NSLog(@"一開始user=%@",[ user objectForKey:@"user"]);
        NSLog(@"一開始pwd=%@",[ user objectForKey:@"pwd"]);
        NSLog(@"switchkey=%@",[ user objectForKey:@"switchkey"]);
        
    }

}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            [self viewDidAppear:YES];//如果撈不到資料一直跑viewDidAppear
            break;
            
        default:
            break;
    }
}

- (IBAction)loginBtn:(id)sender {
    
    
    bool loginUser = false;
    //開始驗證,用迴圈判斷判斷是否與欄位符合
        for (int i=0; i < self.ListObj.count; i++) {
            LoginObject *LoginObject = [_ListObj objectAtIndex:i];
             NSLog(@"LoginObject name=%@",LoginObject.name);
            
            //如欄位輸入正確
            if([self.userNameText.text isEqualToString:LoginObject.name] && [self.userPwdText.text isEqualToString:LoginObject.pwd]){
                
                NSLog(@"正確userNameText=%@",self.userNameText.text);
                NSLog(@"正確name=%@",LoginObject.name);
                NSLog(@"驗證成功");
                
                //成功就切換畫面至CategoryViewController
                CategoryViewController *viewController=[[CategoryViewController alloc]initWithNibName:@"CategoryViewController" bundle:nil];
                
                [navigationController setViewControllers:@[viewController]];
                
                [self presentViewController:navigationController animated:YES completion:nil];
                NSLog(@"切換");
               
                [_loginBtn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
                 _loginBtn.tag = 60;
                NSLog(@"登入成功");
                loginUser = true;
              break;
                
            }else{
                //欄位不符合
                if (![self.userNameText.text isEqualToString:LoginObject.name] && ![self.userPwdText.text isEqualToString:LoginObject.pwd] && !(loginUser))  {
                    
                    NSLog(@"userNameText=%@",self.userNameText.text);
                    NSLog(@"name=%@",LoginObject.name);
                  
                    
                    [_loginBtn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
                    _loginBtn.tag = 61;
                    alertString = @"帳號或密碼有錯誤";
                    NSLog(@"帳號或密碼有錯誤");
                    
                }
            }
            
            //欄位都為空值
            if([self.userNameText.text isEqualToString:@""] && [self.userPwdText.text isEqualToString:@""]) {
                [_loginBtn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
                _loginBtn.tag = 61;
                alertString = @"請輸入帳號與密碼";
                NSLog(@"請輸入帳號與密碼");
                break;
            }
             //欄位需輸入帳號
            if ([self.userNameText.text isEqualToString:@""]){
                [_loginBtn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
                _loginBtn.tag = 62;
                 alertString = @"請輸入帳號";
                NSLog(@"請輸入帳號");
                break;
            }
            //欄位需輸入密碼
            if ([self.userPwdText.text isEqualToString:@""]){
                [_loginBtn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
                _loginBtn.tag = 62;
                 alertString = @"請輸入密碼";
                NSLog(@"請輸入密碼");
                 break;
            }
            
        }
    
    
}
- (IBAction)userDefSwitch:(id)sender {
    UISwitch *switchView = (UISwitch *)sender;
    
    //判斷switch變動時觸發並儲存欄位值給Default
    userName =self.userNameText.text;
    userPwd =self.userPwdText.text;
    //判斷switch為on 時候觸發
    if ([switchView isOn])  {
        NSLog(@"switch is open");
        [user setObject:userName forKey:@"user"];
        [user setObject:userPwd forKey:@"pwd"];
        [user setBool:YES forKey:@"switchkey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"seitch user=%@",[ user objectForKey:@"user"]);
        NSLog(@"seitch pwd=%@",[ user objectForKey:@"pwd"]);
        
    } else {
        NSLog(@"switch is close");
        //取消預設值
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pwd"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"switchkey"];
        //[[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)show:(UIButton *)sender
{
    
    NSString * title = nil;
    NSString * detail = nil;
    NSString * cancle = @"取消";
    NSString * ok = @"確定";
    switch (sender.tag - 59) {
        case WKAlertViewStyleSuccess:
        case WKAlertViewStyleDefalut:
            title = @"成功提醒";
            detail = @"登入成功";
            cancle = nil;
            break;
        case WKAlertViewStyleFail:
            title = @"錯誤提示";
            detail = alertString;
            break;
        case WKAlertViewStyleWaring:
            title = @"警告提示";
            detail = alertString;
            break;
        default:
            break;
    }
    //全域變數有值時給予Window
    __sheetWindow = [WKAlertView showAlertViewWithStyle:sender.tag - 59 title:title detail:detail canleButtonTitle:cancle okButtonTitle:ok callBlock:^(MyWindowClick buttonIndex) {
        
        //當按下確定後將Window隱藏，並設置為nil
        __sheetWindow.hidden = YES;
        __sheetWindow = nil;
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
