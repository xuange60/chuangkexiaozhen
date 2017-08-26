//
//  DianZiHeTongGuanLi.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/10.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "DianZiHeTongGuanLi.h"

@implementation DianZiHeTongGuanLi



/*
 2.9.1 电子合同管理查询
 http://116.228.176.34:9002/chuangke-serve/electroniccontract/search?start=0&length=10
 [{"id":"5988838922637b17beb2f879","creator"
 :"cash","tenantTitle":"云创智能科技有限公司","createDate":"2017-08-07"},{"id":"5980815d80ab5e6790d536cb","creator"
 :"cash","tenantTitle":"云创智能科技有限公司","createDate":"2017-08-01"},{"id":"597fd8c780ab5e6790d53694","creator"
 :"cash","tenantTitle":"云创智能科技有限公司","createDate":"2017-08-01"}]
 */
-(void)DianZiHeTongQuery
{
    NSMutableArray* ary=[NSMutableArray array];
    [self DianZiHeTongQuery:ary];
    
}

-(void)DianZiHeTongQuery:(NSMutableArray*)ary
{
    int start=(int)[ary count];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%d",baseurl,@"/electroniccontract/search?length=10&start=",start];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"])
        {//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            if(result==nil || [result count]<10)
            {
                //result: 保存查询到的结果
                if([result count]>0)
                {
                    [ary addObjectsFromArray:result];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)])
                {
                    [self.delegate  loadNetworkFinished :ary];
                }
            }else{
                [ary addObjectsFromArray:result];
                [self DianZiHeTongQuery:ary];
            }
        }else
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)])
            {
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




@end
