//
//  KaiTongZhuXianViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "KaiTongZhuXianViewController.h"

@interface KaiTongZhuXianViewController ()

@end

@implementation KaiTongZhuXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.readonly=NO;
    self.btn.hidden=YES;
    self.navigationItem.title=@"开通主线";
    [self kaiTongZhuXianQuery];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];//取消第一响应者
    return YES;
}


-(void)kaiTongZhuXianQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/mainline/add"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        
        if([contenttype containsString:@"html"]){
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//input"];
            NSMutableDictionary* tmpdic=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * idstr=[ele objectForKey:@"id"];
                NSString* value=[ele objectForKey:@"value"];
                if(idstr!=nil && value!=nil){
                    [tmpdic setObject:value forKey:idstr];
                }
            }
            
            NSMutableDictionary* dic=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * idstr=[ele objectForKey:@"name"];
                NSString* value=[ele objectForKey:@"value"];
                if(idstr!=nil && value!=nil){
                    [dic setObject:value forKey:idstr];
                }
            }
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str); //打印查询到的数据
            if([tmpdic objectForKey:@"submit"]!=nil){//如果有提交按钮，则需要用户录入注册数据；
                dic=nil;
                [self setNoReadOnly];
            }else{
                _companyname.text=[dic objectForKey:@"companyname"];
                _reportedbodies.text=[dic objectForKey:@"reportedbodies"];
                _leasearea.text=[dic objectForKey:@"leasearea"];
                _floor.text=[dic objectForKey:@"floor"];
                _communications.text=[dic objectForKey:@"communications"];
                _parkingLot.text=[dic objectForKey:@"parkingLot"];
                _repastbodies.text=[dic objectForKey:@"repastbodies"];
                _businessneeds.text=[dic objectForKey:@"businessneeds"];
                _legalneeds.text=[dic objectForKey:@"legalneeds"];
                _printneeds.text=[dic objectForKey:@"printneeds"];
                _companystatus.text=[dic objectForKey:@"companystatus"];
                [self setReadOnly];
            }
            
            //字典NSMutableDictionary* dic包含了查询到的数据
            //查询成功数据保存在字典中；字典中没有数据，代表未申请过，可以提交申请；字典中有数据，显示数据即可，不可以提交数据
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}




- (IBAction)kaiTongZhuXian:(id)sender {
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param setObject:self.companyname.text forKey:@"companyname"];
    [param setObject:@"" forKey:@"uninumber"];
    [param setObject:_reportedbodies.text forKey:@"reportedbodies"];
    [param setObject:_leasearea.text forKey:@"leasearea"];
    [param setObject:_floor.text forKey:@"floor"];
    [param setObject:_communications.text forKey:@"communications"];
    [param setObject:_parkingLot.text forKey:@"parkingLot"];
    [param setObject:_repastbodies.text forKey:@"repastbodies"];
    [param setObject:_businessneeds.text forKey:@"businessneeds"];
    [param setObject:_legalneeds.text forKey:@"legalneeds"];
    [param setObject:_printneeds.text forKey:@"printneeds"];
    [param setObject:_companystatus.text forKey:@"companystatus"];
    
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"true",@"applynetshare",
                                     @"无特殊需求",@"bearing",@"",@"commie",@"",@"democrat",@"",@"junior",
                                     @"",@"master",@"",@"returnees",@"",@"spts",@"",@"undergraduate",@"",@"other",@"无特殊需求",@"electricity",@"无特殊需求",@"water",@"false",@"reformdecoration", nil];
    [parameters addEntriesFromDictionary:param];
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/mainline/save"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,提交成功 不等于1,提交
            if(1==result){
                [self setReadOnly];
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"开通主线申请已提交" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [alertCon addAction:action2];
                [self presentViewController:alertCon animated:YES completion:nil];
            }else{
                [self setNoReadOnly];
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"开通主线申请提交失败" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [alertCon addAction:action2];
                [self presentViewController:alertCon animated:YES completion:nil];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

-(void) setReadOnly
{
    self.readonly=YES;
    self.btn.hidden=YES;
}

-(void) setNoReadOnly
{
    self.readonly=NO;
    self.btn.hidden=NO;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.readonly) {
        return NO;
    }
    return YES;
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
