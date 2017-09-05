//
//  HuoDong.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "HuoDong.h"

@implementation HuoDong

/*
 11.1 路演查询
 请求 get http://116.228.176.34:9002/chuangke-serve/roadshow/search?start=0&length=1000
 响应 [{"id":"596b820b80ab5e6790d4f05a","name"
 :"项目研讨会","time":"2017-07-17","theme":null,"address":"上海是","url":""},{"id":"595217ad07591472f0d1d054"
 ,"name":"三三枫会","time":"2017-06-28","theme":null,"address":"科创小镇","url":""},{"id":"594b974611c7350a7bdac16e"
 ,"name":"44","time":"2017-01-01","theme":null,"address":"44","url":""}]
 */

-(void)HuoDongLuYanQuery
{
    [self querylistWithRole:@"admin" andRelativeUrl:@"/roadshow/search"];
    /*
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/roadshow/search?start=0&length=10000"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
     */
}



-(void) querylistWithRole:(NSString*)role andRelativeUrl:(NSString*) relativeurl
{
    NSMutableArray* ary=[NSMutableArray array];
    [self querylistWithRole:role andRelativeUrl:relativeurl amdTmp:ary];
}


-(void) querylistWithRole:(NSString*)role andRelativeUrl:(NSString*) relativeurl amdTmp:(NSMutableArray*)ary
{
    int start=(int)[ary count];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?length=50&role=%@&start=%d",baseurl,relativeurl,role,start];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            if(result==nil || [result count]<10){
                //result: 保存查询到的结果
                if([result count]>0){
                    [ary addObjectsFromArray:result];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                    [self.delegate  loadNetworkFinished :ary];
                }
            }else{
                [ary addObjectsFromArray:result];
                [self querylistWithRole:role andRelativeUrl:relativeurl amdTmp:ary];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :ary];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
            [self.delegate  loadNetworkFinished :ary];
        }
    }];
}


/*
 11.2 路演详情查询
 请求 get  http://116.228.176.34:9002/chuangke-serve/roadshow/detail?id=596b820b80ab5e6790d4f05a
 响应需要根据html来解析
 {"name":"项目研讨会","address":"上海是","time":"2017-07-17","organizationList":"[上海市政府，上海]","content":"xxxxx","url":"","noticeList":["张玄2"]}
 */
-(void)HuoDongLuYanDetailQuery:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/roadshow/detail?id=",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
        }else if([contenttype containsString:@"html"]){
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//input"];
            NSMutableDictionary* dic=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * idstr=[ele objectForKey:@"name"];
                NSString* value=[ele objectForKey:@"value"];
                if(idstr!=nil && value!=nil){
                    [dic setNotNullObject:value forKey:idstr];
                }
            }
            
            NSArray* array1=[doc searchWithXPathQuery:@"//textarea"];
            for (TFHppleElement *ele in array1) {
                NSString * idstr=[ele objectForKey:@"name"];
                NSString* value=ele.content;
                if(idstr!=nil && value!=nil && [idstr isEqualToString:@"content"]){
                    [dic setNotNullObject:value forKey:idstr];
                }
            }
            
            NSArray* array2=[doc searchWithXPathQuery:@"//select"];
            for (TFHppleElement *ele in array2) {
                NSString * idstr=[ele objectForKey:@"name"];
                NSArray* array3=[ele childrenWithTagName:@"option"];
                if(idstr!=nil && array3!=nil && [idstr isEqualToString:@"noticeList"]){
                    NSMutableArray* value=[NSMutableArray array];
                    for (TFHppleElement *ele1 in array3) {
                        NSString* option=ele1.content;
                        [value addObject:option];
                    }
                    [dic setNotNullObject:value forKey:idstr];
                }
            }
            
            //字典NSMutableDictionary* dic包含了查询到的数据
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :dic];
            }
            
            //打印查询到的数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}







@end
