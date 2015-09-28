//
//  AppDelegate.m
//  CosenCloud
//
//  Created by kid chiu on 2015/9/5.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "AppDelegate.h"
#import "UserLoginViewController.h" //登陸
//機台詳細
#import "DetailInfoViewController.h"
#import "DetailViewController.h"
#import "CategoryViewController.h"
#import "DetailAlarmViewController.h"
//稼動率
#import "UtilizationViewController.h"
#import "UtilizationTodayViewController.h"
#import "UtilizationDayViewController.h"
#import "UtilizationMonthViewController.h"
#import "UtilizationWeekViewController.h"
#import "YSLContainerViewController.h"
//Green Power
#import "GreenPowerViewController.h"
#import "GPTodayViewController.h"

#import "CRGradientNavigationBar.h"//導航顏色

@interface AppDelegate ()

@end

//#define UIColorFromRGB(rgbValue)[UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //  Register notification for Network status change
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    //  Initialize the listener for network status
    reachabilty = [Reachability reachabilityForInternetConnection];
    [reachabilty startNotifier];
    
    
    
    
    
   //改變導航顏色
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[CRGradientNavigationBar class] toolbarClass:nil];
    
    UIColor *firstColor = [UIColor colorWithRed:255.0f/255.0f green:42.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
    UIColor *secondColor = [UIColor colorWithRed:255.0f/255.0f green:90.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    //NSArray *colors = [NSArray arrayWithObjects:(id)UIColorFromRGB(0xf16149).CGColor, (id)UIColorFromRGB(0xf14959).CGColor, nil];
    
    [[CRGradientNavigationBar appearance] setBarTintGradientColors:colors];
    [[navigationController navigationBar] setTranslucent:NO]; // Remember, the default value is YES.
   
    
    //2.生成ViewController
    DetailViewController *detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    DetailInfoViewController *detailInfoVC = [[DetailInfoViewController alloc] initWithNibName:@"DetailInfoViewController" bundle:nil];
    CategoryViewController *cateVC = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    
    UtilizationViewController *utiliVC = [[UtilizationViewController alloc] initWithNibName:@"UtilizationViewController" bundle:nil];
    UtilizationDayViewController *utilidayVC = [[UtilizationDayViewController alloc] initWithNibName:@"UtilizationTodayViewController" bundle:nil];
    
        UserLoginViewController *UserLogin=[[UserLoginViewController alloc]initWithNibName:@"UserLoginViewController" bundle:nil];
    
    //3.生成NavigationController
    
    UINavigationController *navCat = [[UINavigationController alloc] initWithRootViewController:cateVC];
   // UINavigationController *navDetail = [[UINavigationController alloc] initWithRootViewController:detailVC];
    UINavigationController *navDetailInfo = [[UINavigationController alloc] initWithRootViewController:detailInfoVC];
    
    UINavigationController *navUtili = [[UINavigationController alloc] initWithRootViewController:utiliVC];
    
    UINavigationController *navUserLogin = [[UINavigationController alloc] initWithRootViewController:UserLogin];
    
    //選中哪一個VC為初始畫面
    [navigationController setViewControllers:@[UserLogin]];
  self.window.rootViewController = navigationController;
  self.window.backgroundColor = [UIColor whiteColor];
 [self.window makeKeyAndVisible];
    return YES;
}

// Called by Reachability whenever status changes.
- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

//  Implementation for Network status notification
- (void)updateInterfaceWithReachability:(Reachability *)curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus) {
        case NotReachable:
        {
            UIAlertView *networkAlert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"未能連接API,請確認連線狀態" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [networkAlert show];
            break ;
        }
        case ReachableViaWiFi:
        {
            UIAlertView *networkAlert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"Wifi已連線" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [networkAlert show];
            NSLog(@"====目前網路為Wifi=======");
            break;
        }
        case ReachableViaWWAN:
        {
            UIAlertView *networkAlert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"3G/4G已連線" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [networkAlert show];
              NSLog(@"====目前網路為3G/4Ｇ=======");
            break;
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.kid.CosenCloud" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CosenCloud" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CosenCloud.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
