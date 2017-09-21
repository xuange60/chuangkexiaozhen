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
    self.username.tag=666;
    self.mobile.tag=667;
    _checkname=NO;
    _checkphone=NO;
    
    _zhuceBtn.enabled=NO;
    [_zhuceBtn setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
    
    _comnetwork=[[CommNetWork alloc] init];
    _comnetwork.delegate=self;
    [_comnetwork queryParamMapwithRelativeUrl:@"/register"];
    
    self.usertype.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_yzmBtn setContent:@"获取验证码" attributeStr:@""];
    _yzmBtn.lab1.hidden=NO;
    _yzmBtn.lab2.hidden=YES;
    
    [_yzmBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];

}




-(void)afternetwork6:(id)data
{
    NSDictionary* dic=(NSDictionary*)data;
    _typeindexs=[dic objectForKey:@"typeidx"];
}





-(void)click:(UIGestureRecognizer*)ges
{
    if(_mobile.text==nil || [_mobile.text length]<1){
        return;
    }
    
    if ([_yzmBtn.lab1.text isEqualToString:@"获取验证码"]|| [_yzmBtn.lab1.text isEqualToString:@"重新获取验证码"])
    {
        _i=60;
        [self registerGetCode:_mobile.text];
        
        [_yzmBtn setContent:@"" attributeStr:[NSString stringWithFormat:@"%d%@",_i,@"s后重新获取"]];
        _yzmBtn.lab1.hidden=YES;
        _yzmBtn.lab2.hidden=NO;
        
        
        _timer=[NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer)
                {
                    _i--;
                    [_yzmBtn setContent:@"" attributeStr:[NSString stringWithFormat:@"%d%@",_i,@"s后重新获取"]];
                    if (_i==0){
                        _i=60;
                        [_yzmBtn setContent:@"重新获取验证码" attributeStr:@""];
                        _yzmBtn.lab1.hidden=NO;
                        _yzmBtn.lab2.hidden=YES;
                        [_timer invalidate];
                    }
                }];
    }
}






- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    if (textField.tag==666 && textField.text!=nil && textField.text.length>0) {
        [self checkName:textField.text];
    }
    
    if (textField.tag==667 && textField.text!=nil && textField.text.length>0) {
        [self checkMobile:textField.text];
    }
    _zhuceBtn.enabled=NO;
    [_zhuceBtn setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
    
    if(_username.text.length>0 && _mobile.text.length>0 && _checkcode.text.length>0 && _pwd.text.length>0 && _pwd2.text.length>0 && [[_usertype currentTitle] length]>0){
        _zhuceBtn.enabled=YES;
        [_zhuceBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    }
    
}

//最上面返回按钮的事件处理
- (IBAction)cancelRegister:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//选择用户类型按钮的事件处理
- (IBAction)xzlxBtnClick:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"创业团队",@"创业公司",@"服务机构",@"园区运营",@"创业导师",@"个人",@"其他", nil];
    [vc setDatas:array withBtn:sender];
    [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

//点击注册按钮的事件处理
- (IBAction)zhuceBtnClick:(id)sender{
    if(![_pwd.text isEqualToString:_pwd2.text] ){
        [_pwd becomeFirstResponder];
        [self tiShiKuangDisplay:@"密码不一致" viewController:self];
        return;
    }
    if(!_checkname){
        [_username becomeFirstResponder];
        [self tiShiKuangDisplay:@"用户名不可用" viewController:self];
        return;
    }
    if(!_checkphone){
        [_mobile becomeFirstResponder];
        [self tiShiKuangDisplay:@"手机号码不可用" viewController:self];
        return;
    }
    
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
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSString* result=[jsondata objectForKey:@"actionid"];
            NSLog(@"%@",result);
            //result:  false,用户名已被占用 非false，用户名可用
            if ([result isEqualToString: @"false"]) {
                _checkname=NO;
                [self tiShiKuangDisplay:@"用户名不可用" viewController:self];
            }else{
                _checkname=YES;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error：%@",error);
        
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
                [self tiShiKuangDisplay:@"手机号码不可用" viewController:self];
                _checkphone=NO;
            }else{
                _checkphone=YES;
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
                [self tiShiKuangDisplay:@"验证码发送成功" viewController:self];
            }else{
                [self tiShiKuangDisplay:@"验证码发送失败" viewController:self];
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
    NSString* typestr=[_typeindexs objectNotNullForKey:type];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:checkcode,@"mcode",name,@"loginName",mobile,@"mobilePhone",email,@"email",pwd,@"plainPassword",typestr,@"typeidx", nil];
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
                [self tiShiKuangDisplay:@"注册成功,请登陆" viewController:self];
                UIStoryboard*storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                ViewController*vc=[storyBoard instantiateInitialViewController];
                [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:NO block:^(NSTimer * _Nonnull timer) {
                    [self presentViewController:vc animated:YES completion:nil];
                }];
                
                
            }else{
                [self tiShiKuangDisplay:@"注册失败" viewController:self];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self tiShiKuangDisplay:@"注册失败" viewController:self];
        
    }];
}







@end
