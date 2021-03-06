//
//  ShiTiRuZhuGuanLi.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ShiTiRuZhuGuanLi.h"

@implementation ShiTiRuZhuGuanLi



/*
 2.1 实体入驻管理查询
 请求 get  http://116.228.176.34:9002/chuangke-serve/apply/search?typeNumber=1&start=0&length=10000
 响应 [{"id":"597db10980ab5e6790d52d67","contact"
 :"小灰灰","contactType":"18554353465","companyName":"新时代","applyDate":"2017-07-30","applyStatus":"未处理","businessLine"
 :"互联网和移动互联网","coopCategories":null,"branchName":null,"desc":null,"applyintype":null,"totalScore":0.0
 ,"inplace":"已报道","description":"加速企业"},{"id":"597dbedb80ab5e6790d52d78","contact":"xiaogao1","contactType"
 :"18576672852","companyName":"craggily","applyDate":"2017-07-30","applyStatus":"通过","businessLine":"
 新材料","coopCategories":null,"branchName":null,"desc":null,"applyintype":null,"totalScore":400.0,"inplace"
 :"未报道","description":"加速企业"}
 
 
 申请状态有：未处理，处理中，通过，失败
 当申请状态为未处理或处理中时，可以 编辑,添加答辩,审批通过,审批不通过,删除,下载文档
 当申请状态为通过时，可以 编辑,下载文档
 当申请状态为不通过时，可以 编辑,重新答辩，下载文档
 */



-(void)ShiTiRuZhuGuanLiQuery
{
    NSMutableArray* ary=[NSMutableArray array];
    [self ShiTiRuZhuGuanLiQuery:ary];
    
}

-(void)ShiTiRuZhuGuanLiQuery:(NSMutableArray*)ary
{
    int start=(int)[ary count];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%d",baseurl,@"/apply/search?typeNumber=1&length=10&start=",start];
    
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
                [self ShiTiRuZhuGuanLiQuery:ary];
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
 2.2 审批不通过
 请求 get http://116.228.176.34:9002/chuangke-serve/apply/ifagree?ifagree=2&applyId=597db10980ab5e6790d52d67
 */
-(void)ShiTiRuZhuGuanLiJuJue:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/apply/ifagree?ifagree=2&applyId=",ids];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork1:)]) {
                [self.delegate afternetwork1:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 2.3 撤销审批不通过
 get http://116.228.176.34:9002/chuangke-serve/apply/retreat?id=597db10980ab5e6790d52d67
 */
-(void)ShiTiRuZhuGuanLiJuJueCancle:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?id=%@",baseurl,@"/apply/retreat",ids];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork2:)]) {
                [self.delegate afternetwork2:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*
 2.4.1 提交答辩
 post http://116.228.176.34:9002/chuangke-serve/applytreat/save
 参数
 记录id applyid
 评审专家id userIds
 答辩时间 defenceDateStr
 答辩地点 addr
 */
-(void)TiJiaoDaBianShenQing:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/applytreat/save"];
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork3:)]) {
                [self.delegate afternetwork3:[NSNumber numberWithInt:result]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


/*
 2.4.2 答辩前，获取评审专家列表
 get http://116.228.176.34:9002/chuangke-serve/user/getselect?code=evaluationexpert
 [{"id":"5875a60bee19799d1cc83824","name"
 :"王俊","loginName":"admin"},{"id":"58e5c52c19eb26b288dc9753","name":"顾一琳","loginName":"guyilin"},{"id"
 :"58e7316c19eb5e6b9401247e","name":"王博雅","loginName":"wangboya"}]
 */
-(void)DaBianZhuanJiaQuery
{
    {
        NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
        AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
        NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/user/getselect?code=evaluationexpert"];
        
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
                if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork4:)]) {
                    [self.delegate  afternetwork4 :result];
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
    }
}


/*
 2.5 审批通过
 http://116.228.176.34:9002/chuangke-serve/apply/ifagree?ifagree=1&applyId=597db10980ab5e6790d52d67
 */
-(void)ShiTiRuZhuGuanLiTongGuo:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/apply/ifagree?ifagree=1&applyId=",ids];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork5:)]) {
                [self.delegate afternetwork5:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*
 2.6 删除请求
 http://116.228.176.34:9002/chuangke-serve/apply/delete?id=597c00cd80ab5e6790d52891
 */
-(void)ShiTiRuZhuDelete:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?id=%@",baseurl,@"/apply/delete",ids];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork6:)]) {
                [self.delegate afternetwork6:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 2.7 修改请求
 提交修改后的请求 http://116.228.176.34:9002/chuangke-serve/apply/update/apply
 参数：businessLine	电子信息
 companyName	克里斯蒂
 contact	浮动浮动
 contactType	354657648611
 description	初创团队
 id	597af69d80ab5e6790d5243d
 */


-(void) ShiTiRuZhuModify:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/apply/update/apply"];
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork7:)]) {
                [self.delegate afternetwork7:[NSNumber numberWithInt:result]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


/*
 2.8 请求相关文档查询及下载
 http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597d796680ab5e6790d52d33&typeIndex=26&start=0&length=10000
 */
//typeIndex=26 请求与以前一样



@end
