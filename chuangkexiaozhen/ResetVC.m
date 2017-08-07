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
    
    _userName.delegate=self;
    _userName.tag=771;
    
    _mobile.delegate=self;
    _mobile.tag=772;
    
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
    
}


//最上面左边返回按钮的事件处理
- (IBAction)cancelReset:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
   }

//重置里面，获取验证码按钮的事件处理
- (IBAction)yzmBtnClick:(id)sender {
    
  [self resetGetCode:_mobile.text];
}


//重置点击提交按钮的处理事件
- (IBAction)resetBtnClick:(id)sender {
    
    [self resetPwdWithCode:_yanZhengMa.text name:_userName.text mobile:_mobile.text pwd:_pwd.text];
}




//检查手机号和用户名是否一致
//result: false,用户名或密码错误 非false,用户名或密码一致
-(void) checkName:(NSString*)name mobile:(NSString*)mobile
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"loginname",mobile,@"mobile", nil];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
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
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码错误，请重新填写" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [alertCon addAction:action2];
                [self presentViewController:alertCon animated:YES completion:nil];
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
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
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
               
            }else{
                
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"验证码发送失败，请重新获取" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [alertCon addAction:action1];
                [alertCon addAction:action2];
                [self presentViewController:alertCon animated:YES completion:nil];
                
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
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
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
                 
             }else{       //重置失败，弹出提示，继续设置
                 UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"密码重置失败，请重新设置" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction*action1=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                 [alertCon addAction:action1];
                 [self presentViewController:alertCon animated:YES completion:nil];
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error);
         
     }];
}
@end
