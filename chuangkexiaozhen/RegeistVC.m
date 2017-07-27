//
//  RegeistVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/24.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "RegeistVC.h"
#import "ComboViewController.h"

@interface RegeistVC ()

@end

@implementation RegeistVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
   // _yzmBtn.layer.borderWidth=1;
    //_yzmBtn.layer.cornerRadius=10;
    
   // _zhuceBtn.layer.borderWidth=1;
   // _zhuceBtn.layer.cornerRadius=10;
    

    self.username.layer.borderWidth = 1.0f;
    self.username.layer.cornerRadius = 2;
    self.username.layer.borderColor = [UIColor colorWithRed:235/255.0 green:234/255.0 blue:234/255.0 alpha:1].CGColor;
    
    self.mobile.layer.borderWidth = 1.0f;
    self.mobile.layer.cornerRadius = 4;
    self.mobile.layer.borderColor = [UIColor colorWithRed:235/255.0 green:234/255.0 blue:234/255.0 alpha:1].CGColor;
    self.email.layer.borderWidth = 1.0f;
    self.email.layer.cornerRadius = 4;
    self.email.layer.borderColor = [UIColor colorWithRed:235/255.0 green:234/255.0 blue:234/255.0 alpha:1].CGColor;
    self.checkcode.layer.borderWidth = 1.0f;
    self.checkcode.layer.cornerRadius = 4;
    self.checkcode.layer.borderColor = [UIColor colorWithRed:235/255.0 green:234/255.0 blue:234/255.0 alpha:1].CGColor;
    self.pwd.layer.borderWidth = 1.0f;
    self.pwd.layer.cornerRadius = 4;
    self.pwd.layer.borderColor = [UIColor colorWithRed:235/255.0 green:234/255.0 blue:234/255.0 alpha:1].CGColor;
    self.pwd2.layer.borderWidth = 1.0f;
    self.pwd2.layer.cornerRadius = 4;
    self.pwd2.layer.borderColor = [UIColor colorWithRed:235/255.0 green:234/255.0 blue:234/255.0 alpha:1].CGColor;
    self.usertype.layer.borderWidth = 1.0f;
    self.usertype.layer.cornerRadius = 4;
    self.usertype.layer.borderColor = [UIColor colorWithRed:235/255.0 green:234/255.0 blue:234/255.0 alpha:1].CGColor;
    self.usertype.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)cancelRegister:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)yzmBtnClick:(id)sender {
}
- (IBAction)xzlxBtnClick:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"创业团队",@"创业公司",@"服务机构",@"园区运营",@"创业导师",@"个人",@"其他", nil];
    [vc setDatas:array withBtn:sender];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)zhuceBtnClick:(id)sender {
}
@end
