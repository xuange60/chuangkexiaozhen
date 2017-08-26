//
//  FaKaGuanli.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "FaKaGuanli.h"

@implementation FaKaGuanli


-(void)FaKaQuery
{
    [super querylistWithRole:@"" andRelativeUrl:@"/hairpinaction/search"];
}

-(void)FaKaDelete:(NSString*)ids
{
    NSString* param=[NSString stringWithFormat:@"id=%@",ids];
    [super deleteWithParam:param andRelativeUrl:@"/hairpinaction/delete"];
}

-(void)FaKaParamMapQuery
{
    [super queryParamMapwithRelativeUrl:@"/hairpinaction/add"];
}

-(void)QueryUsers:(NSString*)tenaid
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?tenantId=%@",baseurl,@"/hairpinaction/tenantmember",tenaid];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        NSMutableDictionary* dics=[NSMutableDictionary dictionary];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* ary=[jsondata objectForKey:@"obj"];
            for (NSDictionary* dic in ary) {
                NSString* name=[dic objectForKey:@"name"];
                NSString* ids=[dic objectForKey:@"id"];
                if(name!=nil && ids!=nil){
                    [dics setValue:ids forKey:name];
                }
            }
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork8:)]) {
            [self.delegate afternetwork8:dics];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork8:)]) {
            [self.delegate afternetwork8:nil];
        }
    }];
}



-(void)FaKaAdd:(NSDictionary*)param
{
    [super addWithData:param andRelativeUrl:@"/hairpinaction/save"];
}


@end
