//
//  AppDelegate.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/18.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* viewcontroller=[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* logindata=[defaults objectForKey:@"chuangkexiaozhen.login"];
    if(logindata!=nil && [(NSString*)[logindata objectForKey:@"login"] isEqualToString:@"Y"]){
        viewcontroller=[storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    }
    
    self.window.rootViewController=viewcontroller;
    [self.window makeKeyAndVisible];
    
    //接入百度地图
    _mapManager=[[BMKMapManager alloc]init];
   BOOL isSucceed= [_mapManager start:MapKey generalDelegate:self];
    if (isSucceed) {
        NSLog(@"地图接入成功");
    }else{
        NSLog(@"地图接入失败");
    }
   
   // 开启定位服务
    _locaService=[[BMKLocationService alloc]init];
    _locaService.delegate=self;
    [_locaService startUserLocationService];
    
    CommNetWork* comm=[[CommNetWork alloc] init];
    [comm getBaseUrl];
    return YES;
}


-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //获取更新位置
    CLLocation *loca=userLocation.location;
    CLLocationCoordinate2D coord=loca.coordinate;
//    NSLog(@"%.2f  %.2f",coord.latitude,coord.longitude);
    
    //设置中心点和半径
    CLLocationCoordinate2D centerCoord=CLLocationCoordinate2DMake(22.56, 113.90);
    double radius=1000;
    
    //判断点是否在  以--为中心，--为半径的圆内
   BOOL isInCiecle=BMKCircleContainsCoordinate(coord, centerCoord, radius);
    if (isInCiecle) {
//        NSLog(@"在圆内");
    }else{
//          NSLog(@"未在圆内");
    }
    
}

















- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
