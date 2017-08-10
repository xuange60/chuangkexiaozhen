//
//  KaiTongZhuXianGuanLi.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/10.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "KaiTongZhuXianGuanLi.h"

@implementation KaiTongZhuXianGuanLi


/*
 2.11.1 开通主线管理 查询
 http://116.228.176.34:9002/chuangke-serve/mainline/search?start=0&length=10000
 [{"id":"597dc20280ab5e6790d52d7f","reportedBodys"
 :20,"leaseArea":45,"floor":3,"bearing":"无特殊需求","water":"无特殊需求","electricity":"无特殊需求","communications"
 :"开通电信","parkingLot":"3","repastBodies":3,"businessNeeds":"提供注册帮助","legalNeeds":"提供法务帮助","printNeeds"
 :"需要打印","applyNetAlone":"否","applyNetShare":"是","reformDecoration":"否","companyStatus":"创业团队，工商未注册","companyName"
 :"ceshigongsi","uniNumber":"","tenantInit":"uninit"},{"id":"597d812f80ab5e6790d52d4e","reportedBodys"
 :4,"leaseArea":20,"floor":1,"bearing":"无特殊需求","water":"无特殊需求","electricity":"无特殊需求","communications"
 :"开通电信","parkingLot":"4","repastBodies":4,"businessNeeds":"提供注册帮助","legalNeeds":"提供法务帮助","printNeeds"
 :"需要","applyNetAlone":"否","applyNetShare":"是","reformDecoration":"否","companyStatus":"创业团队，工商未注册","companyName"
 :"测试公司zhangxuan3","uniNumber":"","tenantInit":"inited"}]
 */

-(void)KaiTongZhuXianQuery
{
    NSMutableArray* ary=[NSMutableArray array];
    [self KaiTongZhuXianQuery:ary];
    
}

-(void)KaiTongZhuXianQuery:(NSMutableArray*)ary
{
    int start=(int)[ary count];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%d",baseurl,@"/mainline/search?length=10&start=",start];
    
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
                [self KaiTongZhuXianQuery:ary];
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
 2.11.2 开通主线管理删除
 http://116.228.176.34:9002/chuangke-serve/mainline/delete?id=58faea0119eb8cbffbb87b4a
 */

-(void)KaiTongZhuXianDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?id=%@",baseurl,@"/mainline/delete",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,删除成功 不等于1,失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(deleteData:)]) {
                [self.delegate deleteData:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}








@end
