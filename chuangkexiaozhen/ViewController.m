//
//  ViewController.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/18.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.username.layer.borderWidth = 1.0f;
    self.username.layer.cornerRadius = 2;
    self.username.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    self.pwd.layer.borderWidth = 1.0f;
    self.pwd.layer.cornerRadius = 2;
    self.pwd.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    self.username.delegate=self;
    self.username.returnKeyType = UIReturnKeyDone;
    self.pwd.delegate=self;
    self.pwd.returnKeyType = UIReturnKeyDone;
    
}
- (IBAction)loginClick:(id)sender {
    NSString* namestr=self.username.text;
    NSString* pwdstr=self.pwd.text;
    [self loginWithName:namestr andPwd:pwdstr];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];//取消第一响应者
    return YES;
}


//用户登录
//参数 用户名，密码
//返回数组数据 [{"初始申请",["实体入驻","虚拟入驻","文档下载"]}]
-(void) loginWithName:(NSString*) name andPwd:(NSString*) pwd
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    //清除cookie缓存
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for(id obj in cookieArray)
    {
        [cookieJar deleteCookie:obj];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"chuangkexiaozhen.cookie"];
    [defaults setObject:nil forKey:@"chuangkexiaozhen.zhujiemian"];
    [defaults synchronize];
    
    
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"username",pwd,@"password",@"1",@"holdme", nil];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/login"];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        
        CommNetWork* comnetwork=[[CommNetWork alloc] init];
        [comnetwork getUserinfo:name];
        
        if([contenttype containsString:@"json"])
        {//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            if(0==result){
                NSLog(@"%@",@"用户名或密码错误"); //登陆失败
                /**
                 *登陆失败提示
                 */
                
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码错误，请重新填写" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                
                [alertCon addAction:action1];
                [alertCon addAction:action2];
                
                [self presentViewController:alertCon animated:YES completion:nil];
            
            }
        }else if([contenttype containsString:@"html"]){ //登陆成功
            //保存cookies
            NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:cookiesData forKey:@"chuangkexiaozhen.cookie"];
            [defaults synchronize];
            
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//dl"];
            
            NSMutableArray* datas=[[NSMutableArray alloc]init];
            for (TFHppleElement *ele in arrays) {
                TFHppleElement* e1 =[ele firstChildWithTagName:@"dt"];
                NSString* title=[[e1 text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                NSArray* ary1=[ele searchWithXPathQuery:@"//a"];
                
                NSMutableArray* ary=[[NSMutableArray alloc] init];
                for (TFHppleElement *e2 in ary1) {
                    NSString* content=[e2.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    [ary addObject:content];
                }
                if([ary count]>0){
                    NSDictionary* dic=[[NSDictionary alloc] initWithObjectsAndKeys:ary,title,nil];
                    [datas addObject:dic];
                }
                
            }
            
            if([datas count]>0){
                int index=-1;
                for (int i=0; i<[datas count]; i++) {
                    NSDictionary* tmp=[datas objectAtIndex:i];
                    if([tmp objectForKey:@"内部审核管理"] !=nil){
                        index=i;
                        break;
                    }
                }
                if(index>0){
                    [datas removeObjectAtIndex:index];
                }
                
                for (int i=0; i<[datas count]; i++) {
                    NSDictionary* tmp=[datas objectAtIndex:i];
                    NSMutableArray* ary=(NSMutableArray*)[tmp objectForKey:@"系统配置"];
                    if(ary!=nil){
                        [ary removeObject:@"模块"];
                        [ary removeObject:@"权限"];
                        [ary removeObject:@"角色"];
                        [ary removeObject:@"数据字典"];
                    }
                }
                
            }
            
            [defaults setObject:datas forKey:@"chuangkexiaozhen.zhujiemian"];
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);//datas包含了主界面相关数据
            

            
            UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController* mainViewController=[storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];

            [self presentViewController:mainViewController animated:YES completion:nil];
            /**
             *登陆成功界面显示
             */
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        //登陆失败 界面提示       网络发送失败信息提示？？？？
        
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"网络请求发送失败，请等待网络恢复" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertCon addAction:action2];
        [self presentViewController:alertCon animated:YES completion:nil];
        
    }];
}




@end
