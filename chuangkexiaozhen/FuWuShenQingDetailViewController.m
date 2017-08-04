//
//  FuWuShenQingDetailViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "FuWuShenQingDetailViewController.h"

@interface FuWuShenQingDetailViewController ()

@end

@implementation FuWuShenQingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fuwutype setTitle:(NSString*)[self.data objectNotNullForKey:@"serveCategory"] forState:UIControlStateNormal];
    self.navigationItem.title=@"申请详情";
    [self.fuwucontent setText:(NSString*)[self.data objectNotNullForKey:@"content"]];
    // Do any additional setup after loading the view.
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
