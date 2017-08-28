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
#import "TestViewController.h"
@interface RegeistVC ()

@end

@implementation RegeistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // _yzmBtn.layer.borderWidth=1;
    //_yzmBtn.layer.cornerRadius=10;
    
   // _zhuceBtn.layer.borderWidth=1;
   // _zhuceBtn.layer.cornerRadius=10;
    
/*
    self.username.layer.borderWidth = 1.0f;
    self.username.layer.cornerRadius = 2;
    self.username.layer.borderColor = [UIColor colorWithRed:235/255.0 green:234/255.0 blue:234/255.0 alpha:1].CGColor;
 */
 self.username.tag=666;
    /*
    self.mobile.layer.borderWidth = 1.0f;
    self.mobile.layer.cornerRadius = 4;
    self.mobile.layer.borderColor = [UIColor colorWithRed:235/255.0 green:234/255.0 blue:234/255.0 alpha:1].CGColor;
     */
    self.mobile.tag=667;
    /*
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
     */
    self.usertype.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    _yzmBtn.backgroundColor=[UIColor brownColor];
    NSLog(@"%s",__func__);
    
    [_yzmBtn setContent:@"获取验证码" attributeStr:@"s后重新获取"];
    _yzmBtn.lab2.hidden=YES;
    
    NSLog(@"%f %f %f %f %f %f %f %f %f %f %f %f",_yzmBtn.lab1.frame.origin.x,
         _yzmBtn.lab1.frame.origin.y,
          _yzmBtn.lab1.frame.size.width,
          _yzmBtn.lab1.frame.size.height ,
          
          _yzmBtn.lab2.frame.origin.x,
          _yzmBtn.lab2.frame.origin.y,
          _yzmBtn.lab2.frame.size.width,
         _yzmBtn.lab2.frame.size.height ,
          
          _yzmBtn.frame.origin.x,
          _yzmBtn.frame.origin.y,
          _yzmBtn.frame.size.width,
          _yzmBtn.frame.size.height );

   _ges=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [_yzmBtn addGestureRecognizer:_ges];

}
-(void)click:(UIGestureRecognizer*)ges
{
    _i=60;
    if ([_yzmBtn.lab1.text isEqualToString:@"获取验证码"])
    {
        [self registerGetCode:_mobile.text];
        
        [_yzmBtn setContent:@"10" attributeStr:@"s后重新获取"];
        _yzmBtn.lab2.hidden=NO;
        
        
        _timer=[NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer)
                {
                    _i--;
                    NSString*str=[NSString stringWithFormat:@"%d",_i];
                    [_yzmBtn setContent:str attributeStr:@"s后重新获取"];
                    if (_i==0){
                        _i=60;
                        [_yzmBtn setContent:@"获取验证码" attributeStr:@"s后重新获取"];
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
    
    if (textField.tag==666) {
        [self checkName:textField.text];
    }
    if (textField.tag==667) {
        [self checkMobile:textField.text];
    }
    
}

//最上面返回按钮的事件处理
- (IBAction)cancelRegister:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//点击获取验证码按钮的事件处理
- (IBAction)yzmBtnClick:(id)sender
{
    
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
    
   [self registerWithCode:_checkcode.text name:_username.text mobile:_mobile.text email:_email.text pwd:_pwd.text type:_usertype.currentTitle];

}

//检查用户名
//参数 用户名
//result:  false,用户名已被占用 非false，用户名可用
-(void) checkName:(NSString*)name
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"loginname", nil];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/register/check"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSString* result=[jsondata objectForKey:@"actionid"];
            NSLog(@"%@",result);
            //result:  false,用户名已被占用 非false，用户名可用
            if ([result isEqualToString: @"false"]) {
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"用户名已被注册，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [alertCon addAction:action2];
                [self presentViewController:alertCon animated:YES completion:nil];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}


//检查手机号码
//参数 手机号码
//result: false,手机号码不可用 非false,手机号码可用
-(void) checkMobile:(NSString*)mobile
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile", nil];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/register/check"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSString* result=[jsondata objectForKey:@"actionid"];
            NSLog(@"%@",result);
            //result: false,手机号码不可用 非false,手机号码可用
            if ([result isEqualToString: @"false"]) {
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"手机号码不可用，请重新填写" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [alertCon addAction:action2];
                [self presentViewController:alertCon animated:YES completion:nil];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}

//注册时，获取验证码
//参数，手机号码
//result: 1,验证码发送成功 不等于1,验证码发送失败
-(void) registerGetCode:(NSString*)mobile
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile",[NSNumber numberWithInt:1],@"type", nil];
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
              
            }else{
                
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"验证码发送失败，请重新获取" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [alertCon addAction:action2];
                [self presentViewController:alertCon animated:YES completion:nil];
                
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}

//用户注册
//result: 1,注册成功 不等于1,则注册失败
-(void) registerWithCode:(NSString*)checkcode name:(NSString*)name mobile:(NSString*)mobile email:(NSString*)email pwd:(NSString*)pwd type:(NSString*)type
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:checkcode,@"mcode",name,@"loginName",mobile,@"mobilePhone",email,@"email",pwd,@"plainPassword",type,@"typeidx", nil];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/register"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            NSLog(@"%d",result);
           
            //result: 1,注册成功 不等于1,则注册失败
            if (result==1) {
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}



- (IBAction)test:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"test" bundle:nil];
    TestViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"TestViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}




@end
