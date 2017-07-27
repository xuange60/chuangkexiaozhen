//
//  BaseViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 17/7/26.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  self.navigationItem.title=@"申请入驻";
    NSString* title1=self.navigationItem.title;
    if(title1==nil || title1.length==0){
        self.navigationItem.title=self.title;
    }
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:NO];
    
    UIImage *leftButtonIcon = [[UIImage imageNamed:@"left-arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithImage:leftButtonIcon
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(backvc)];
    
    self.navigationItem.leftBarButtonItem=leftBtnItem;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) backvc
{
    NSArray* viewControllersr = self.navigationController.viewControllers;
    if([viewControllersr count]<=2){
        [self.navigationController setNavigationBarHidden:YES];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void) setNavigationItemTitle:(NSString*) title
{
    self.title=title;
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
