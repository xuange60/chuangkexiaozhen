//
//  KaoQinGuanLi.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "KaoQinGuanLi.h"

@implementation KaoQinGuanLi



/*
 10.1 考勤统计查询
 请求 get  http://116.228.176.34:9002/chuangke-serve/userattendance/search?start=0&length=10000&startTime=?&endTime=?
 startTime=2017-08-04 00:00:00
 endTime=2017-08-04 23:59:59
 响应： [{"id":"58f9d2ea19eb8cbffbb87b23","actualCount"
 :0,"absentCount":1,"shouldCount":1,"rateOfAttend":"0.00%","companyName":"都步（上海）智能科技有限公司"},{"id":"58f5887219eb8cbffbb87aa0"
 ,"actualCount":0,"absentCount":1,"shouldCount":1,"rateOfAttend":"0.00%","companyName":"清基(上海）农业发展有限公
 司"},{"id":"597d7aba80ab5e6790d52d37","actualCount":0,"absentCount":1,"shouldCount":1,"rateOfAttend":"0
 .00%","companyName":"测试机构zhangxuan"}]
 */

-(void)KaoQinQueryStart:(NSString*)starttime End:(NSString*)endtime
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/userattendance/search"];
    NSMutableDictionary* param=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"start",@"10000",@"length", nil];
    [param setObject:starttime forKey:@"startTime"];
    [param setObject:endtime forKey:@"endTime"];
    
    [manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            //result: 保存查询到的结果
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 10.2 查询考勤详情
 请求 get
 http://116.228.176.34:9002/chuangke-serve/userattendance/user/search?start=0&length=1000&tenantId=58f9d2ea19eb8cbffbb87b23&selectDate=2017-08-04
 响应 [{"id":"58f9d27d19eb8cbffbb87b1f","date"
 :"2017-08-04","username":"都步（上海）智能科技有限公司","status":null,"absence":"未出勤","startTime":null,"endTime":null
 }]
 */

-(void)KaoQinDetailQuery:(NSString*)ids date:(NSString*)date
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/userattendance/user/search"];
    NSMutableDictionary* param=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"start",@"10000",@"length", nil];
    [param setObject:ids forKey:@"tenantId"];
    [param setObject:date forKey:@"selectDate"];
    
    [manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            //result: 保存查询到的结果
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



@end
