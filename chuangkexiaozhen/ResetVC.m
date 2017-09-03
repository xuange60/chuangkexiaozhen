//
//  ResetVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/24.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ResetVC.h"

@interface ResetVC ()

@end

@implementation ResetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _check=NO;
    _userName.delegate=self;
    _userName.tag=771;
    
    _mobile.delegate=self;
    _mobile.tag=772;
    _yanZhengMa.delegate=self;
    _pwd.delegate=self;
    _pwd2.delegate=self;

    _zhuceBtn.enabled=NO;
    [_zhuceBtn setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
    [_yzmBtn setContent:@"获取验证码" attributeStr:@""];
    _yzmBtn.lab1.hidden=NO;
    _yzmBtn.lab2.hidden=YES;
    [_yzmBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
}



-(void)click:(UIGestureRecognizer*)ges
{
    if(_mobile.text==nil || [_mobile.text length]<1){
        return;
    }
    
    if ([_yzmBtn.lab1.text isEqualToString:@"获取验证码"])
    {
        _i=60;
        [self resetGetCode:_mobile.text];
        
        [_yzmBtn setContent:@"" attributeStr:[NSString stringWithFormat:@"%d%@",_i,@"s后重新获取"]];
        _yzmBtn.lab1.hidden=YES;
        _yzmBtn.lab2.hidden=NO;
        
        
        _timer=[NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer)
                {
                    _i--;
                    [_yzmBtn setContent:@"" attributeStr:[NSString stringWithFormat:@"%d%@",_i,@"s后重新获取"]];
                    if (_i==0){
                        _i=60;
                        [_yzmBtn setContent:@"获取验证码" attributeStr:@""];
                        _yzmBtn.lab1.hidden=NO;
                        _yzmBtn.lab2.hidden=YES;
                        [_timer invalidate];
                    }
                }];
    }
}




- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField.tag==772) {
       [self checkName:_userName.text mobile:_mobile.text];
    }
    
    _zhuceBtn.enabled=NO;
    [_zhuceBtn setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
    
    if(_userName.text.length>0 && _mobile.text.length>0 && _yanZhengMa.text.length>0 && _pwd.text.length>0 && _pwd2.text.length>0){
        _zhuceBtn.enabled=YES;
        [_zhuceBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    }
    
}


//最上面左边返回按钮的事件处理
- (IBAction)cancelReset:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
}




//重置点击提交按钮的处理事件
- (IBAction)resetBtnClick:(id)sender {
    if(![_pwd.text isEqualToString:_pwd2.text] ){
        [_pwd becomeFirstResponder];
        [self tiShiKuangDisplay:@"密码不一致" viewController:self];
        return;
    }
    if(!_check){
        [_userName becomeFirstResponder];
        [self tiShiKuangDisplay:@"用户名与手机号不符" viewController:self];
        return;
    }
    [self resetPwdWithCode:_yanZhengMa.text name:_userName.text mobile:_mobile.text pwd:_pwd.text];
}




//检查手机号和用户名是否一致
//result: false,用户名或密码错误 非false,用户名或密码一致
-(void) checkName:(NSString*)name mobile:(NSString*)mobile
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"loginname",mobile,@"mobile", nil];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/retrieve/check"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSString* result=[jsondata objectForKey:@"actionid"];
            NSLog(@"%@",result);
            //result: false,用户名或密码错误 非false,用户名或密码一致
            
            if ([result isEqualToString:@"false"]) {
                [self tiShiKuangDisplay:@"用户名与手机号码不符" viewController:self];
                _check=NO;
            }else{
                _check=YES;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}



//重置时获取验证码
//result: 1,验证码发送成功 不等于1,验证码发送失败
-(void) resetGetCode:(NSString*)mobile
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile",[NSNumber numberWithInt:2],@"type", nil];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/auth/code"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            NSLog(@"%d",result);
            //result: 1,验证码发送成功 不等于1,验证码发送失败
            if (result==1) {
               [self tiShiKuangDisplay:@"验证码发送成功" viewController:self];
            }else{
                [self tiShiKuangDisplay:@"验证码发送失败" viewController:self];
            }

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}

//重置密码
//result: 1,密码重置成功 不等于1,则密码重置失败
-(void) resetPwdWithCode:(NSString*)checkcode name:(NSString*)name mobile:(NSString*)mobile pwd:(NSString*)pwd
{

    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:checkcode,@"mcode",name,@"loginName",mobile,@"mobilePhone",pwd,@"plainPassword",nil];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/retrieve/update"];
    
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
         NSString* contenttype=[headers objectForKey:@"Content-Type"];
         NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
         if([contenttype containsString:@"json"]){//返回json格式数据
             NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
             int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
             
             NSLog(@"%d",result);
    
             //result: 1,密码重置成功 不等于1,则密码重置失败
             if (result==1)//重置成功，跳出界面，记录密码
             {
                 [self dismissViewControllerAnimated:YES completion:nil];
                 [self tiShiKuangDisplay:@"重置成功" viewController:self];
             }else{       //重置失败，弹出提示，继续设置
                 [self tiShiKuangDisplay:@"重置失败" viewController:self];
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error);
         
     }];
}




-(void)tiShiKuangDisplay:(NSString*)text viewController:(UIViewController*)vc;
{
    _HUD=[[MBProgressHUD alloc]initWithView:vc.view];
    [vc.view  addSubview:_HUD];
    
    _HUD.mode=MBProgressHUDModeText;
    _HUD.labelText=text;
    _HUD.margin=10;
    _HUD.yOffset=vc.view.center.y-100;
    [_HUD show:YES];
    [_HUD hide:YES afterDelay:1];
    
}


@end
