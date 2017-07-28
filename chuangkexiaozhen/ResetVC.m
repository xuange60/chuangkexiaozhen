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
    
    //result:     1：密码重置成功      不等于1：则密码重置失败
    [self resetPwdWithCode:_yanZhengMa.text name:_userName.text mobile:_mobile.text pwd:_pwd.text];
}


//重置时获取验证码
//result: 1,验证码发送成功 不等于1,验证码发送失败
-(void) resetGetCode:(NSString*)mobile
{
    __block int resetYzmResult=0;
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
            //result: 1,验证码发送成功 不等于1,验证码发送失败
            if (result==1) {
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}

//重置密码
//result: 1,密码重置成功 不等于1,则密码重置失败
-(void) resetPwdWithCode:(NSString*)checkcode name:(NSString*)name mobile:(NSString*)mobile pwd:(NSString*)pwd
{
    __block int mimaResult=0;//加上——block在block里面就是地址传递
    
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
                 [self presentViewController:alertCon animated:YES completion:^{
                     
                     [NSThread sleepForTimeInterval:0.5];
                     [self dismissViewControllerAnimated:YES completion:nil];
                 }];
             }

             
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error);
         
     }];
}
@end
