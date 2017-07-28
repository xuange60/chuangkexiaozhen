//
//  RegeistVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/24.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "RegeistVC.h"
#import "ComboViewController.h"
#import "BussinessApi.h"
#import "ViewController.h"

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


//最上面返回按钮的事件处理
- (IBAction)cancelRegister:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//点击获取验证码按钮的事件处理
- (IBAction)yzmBtnClick:(id)sender {
    
  int yzmResult=[BussinessApi registerGetCode:_mobile.text];
    //result: 1,验证码发送成功 不等于1,验证码发送失败
    if (yzmResult==1) {
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"验证码发送成功，请进行下一步操作" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertCon addAction:action2];
        [self presentViewController:alertCon animated:YES completion:nil];
    }else{
        
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"验证码发送失败，请重新获取" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertCon addAction:action1];
        [alertCon addAction:action2];
        [self presentViewController:alertCon animated:YES completion:nil];
        
    }
}
//选择用户类型按钮的事件处理
- (IBAction)xzlxBtnClick:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"创业团队",@"创业公司",@"服务机构",@"园区运营",@"创业导师",@"个人",@"其他", nil];
    [vc setDatas:array withBtn:sender];
    [self presentViewController:vc animated:YES completion:nil];
}

//点击注册按钮的事件处理
- (IBAction)zhuceBtnClick:(id)sender {
    
   int zhuCeResult=[BussinessApi registerWithCode:_checkcode.text name:_username.text mobile:_mobile.text email:_email.text pwd:_pwd.text type:_usertype.currentTitle];

    //result: 1,注册成功 不等于1,则注册失败
    if (zhuCeResult==1) {
        UIStoryboard*storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        ViewController*vc=[storyBoard instantiateInitialViewController];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }else{
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"注册失败，请重新填写" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCon addAction:action2];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
}








@end
