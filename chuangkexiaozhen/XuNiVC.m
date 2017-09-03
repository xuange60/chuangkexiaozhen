//
//  XuNiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/25.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "XuNiVC.h"
#import "BussinessApi.h"
#import "xuNiView.h"
#import "ComBoRowsViewController.h"
@interface XuNiVC ()

@end

@implementation XuNiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"虚拟入驻";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary*dic=[defaults dictionaryForKey:@"chuangkexiaozhen.userinfo"];
    _F3.text=[dic objectNotNullForKey:@"companytitle"];

    
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(BtnClicked:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    // Do any additional setup after loading the view.
    
    
    [self receiveCurrentViewController:self];
}

- (IBAction)duoxianBtnClick2:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComBoRowsViewController* vc=[storyboard instantiateViewControllerWithIdentifier:@"ComBoRowsViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"展示推介机会",@"投融资需求",@"信息技术需求",@"制造加工及场地需求",@"农艺新品种需求",@"交流合作机会",@"咨询管理",@"其他", nil];
    [vc setDatas:array withBtn:self.duoxuan];
    [vc setNavigationItemTitle:@"寻求类别"];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)duoxuanBtnClick:(id)sender {
   
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComBoRowsViewController* vc=[storyboard instantiateViewControllerWithIdentifier:@"ComBoRowsViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"展示推介机会",@"投融资需求",@"信息技术需求",@"制造加工及场地需求",@"农艺新品种需求",@"交流合作机会",@"咨询管理",@"其他", nil];
    [vc setDatas:array withBtn:sender];
    [vc setNavigationItemTitle:@"寻求类别"];
    //[self presentViewController:vc animated:YES completion:nil];
    
    [self.navigationController pushViewController:vc animated:YES];

}



- (IBAction)BtnClicked:(id)sender {
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setNotNullStrObject:_F1.text forKey:@"contact"];
    [dic setNotNullStrObject:_F2.text forKey:@"contacttype"];
    [dic setNotNullStrObject:_F3.text forKey:@"branchname"];
    [dic setNotNullStrObject :_duoxuan.currentTitle    forKey:@"coopcategories"];
    [dic setNotNullStrObject:_textView.text forKey:@"desc"];
    
    [self xuniRuZhuSubmitWithParam:dic];
}


//5.4 虚拟入驻申请
// 参数为字典：branchname=测试虚拟入驻  contact=小明  contacttype=18576672852  coopcategories=展示推介机会,投融资需求,信息技术需求
//desc=测试备注

-(void) xuniRuZhuSubmitWithParam:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:param];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/apply/saveresapply"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            NSLog(@"%d",result);
            //result: 1,虚拟入驻提交成功 不等于1,则提交失败
            
            if (result==1) {
                [self tiShiKuangDisplay:@"提交成功" viewController:self];
                [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:NO block:^(NSTimer * _Nonnull timer) {
                     [self.navigationController popViewControllerAnimated:YES];
                }];
               
            }else{
                [self tiShiKuangDisplay:@"提交失败" viewController:self];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}














@end
