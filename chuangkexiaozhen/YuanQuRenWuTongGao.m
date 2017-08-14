//
//  YuanQuRenWuTongGao.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/13.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YuanQuRenWuTongGao.h"

@implementation YuanQuRenWuTongGao


-(void)YuanQuRenWuQuery
{
    [super querylistWithRole:@"" andRelativeUrl:@"/task/search"];
}

-(void)YuanQuRenWuDelete:(NSString*)ids
{
    [super deleteWithId:ids andRelativeUrl:@"/task/batchdelete"];
}

-(void)YuanQuRenWuSucc:(NSString*)ids
{
    [super succWithId:ids andRelativeUrl:@"/task/batchfinish"];
}


-(void)YuanQuRenWuDetail:(NSString*)ids
{
    [super queryDetailWithId:ids andRelativeUrl:@"/task/detail"];
}


-(void)YuanQuRenWuParamQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/task/add"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        
        if([contenttype containsString:@"html"]){
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//select"];
            NSMutableDictionary* datas=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * name=[ele objectForKey:@"name"];
                NSArray* options=[ele childrenWithTagName:@"option"];
                if(name!=nil && options!=nil && [options count]>0){
                    NSMutableDictionary* data=[NSMutableDictionary dictionary];
                    for (TFHppleElement *ele1 in options) {
                        NSString* value1=[ele1 objectForKey:@"value"];
                        NSString* key1=[ele1 content];
                        if(value1!=nil && key1!=nil){
                            [data setObject:value1 forKey:key1];
                        }
                    }
                    [datas setObject:data forKey:name];
                }
            }
            
            //字典NSMutableDictionary* datas包含了查询到的数据
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork6:)]) {
                [self.delegate afternetwork6:datas];
            }
            
            //打印查询到的数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}



/*
 通告类型 category 整理内务
 通告内容 content xxxx
 截止时间 enddate 2017-08-14 14:38:31
 file
 紧急程度 levels 紧急
 通告主题 name ceshi
 文件id resourceIds 598ff39922637b17beb31415
 涉及人员 users 597d807680ab5e6790d52d45 users 597db39c80ab5e6790d52d6a
 workId
 */
-(void)YuanQuRenWuAdd:(NSDictionary*)param
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/task/save"];
    NSString* category=[param objectNotNullForKey:@"category"];
    NSString* content=[param objectNotNullForKey:@"content"];
    NSString* enddate=[param objectNotNullForKey:@"enddate"];
    NSString* levels=[param objectNotNullForKey:@"levels"];
    NSString* name=[param objectNotNullForKey:@"name"];
    NSString* resourceIds=[param objectNotNullForKey:@"resourceIds"];

    
    
    
    NSMutableString* users=[NSMutableString string];
    NSArray* ary1=(NSArray*)[param objectForKey:@"users"];
    if([ary1 count]>0){
        users=[NSMutableString stringWithString:@"&"];
        for (int i=0; i<[ary1 count]; i++) {
            NSString* data=[ary1 objectAtIndex:i];
            [users appendFormat:@"users=%@",data];
            if(i<([ary1 count]-1)){
                [users appendString:@"&"];
            }
        }
    }
    


    
    
    NSString* post=[NSString stringWithFormat:@"resourceIds=%@&workId=&name=%@&category=%@&levels=%@%@&content=%@&file=&enddate=%@",resourceIds,name,category,levels,users,content,enddate];
    
    
    NSData* postdate=[post dataUsingEncoding:NSUTF8StringEncoding];
    NSString* length=[NSString stringWithFormat:@"%lu",(unsigned long)[postdate length]];
    NSMutableURLRequest* req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    [req setHTTPMethod:@"POST"];
    [req setValue:length forHTTPHeaderField:@"Content-Length"];
    [req setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray<NSHTTPCookie *> *cookies=[cookieJar cookies];
    NSHTTPCookie* cookie1=[cookies objectAtIndex:0];
    NSString* cookiename=[cookie1 valueForKey:NSHTTPCookieName];
    NSString* cookievalue=[cookie1 valueForKey:NSHTTPCookieValue];
    NSString* cookiestr=[NSString stringWithFormat:@"%@=%@",cookiename,cookievalue];
    [req setValue:cookiestr forHTTPHeaderField:@"Cookie"];
    [req setHTTPBody:postdate];
    
    
    
    NSURLResponse* resp=nil;
    NSError* err=nil;
    NSData* respdata=[NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err];
    int result=-1;
    
    @try {
        NSString* datastr= [[NSString alloc] initWithData:respdata  encoding:NSUTF8StringEncoding];
        NSDictionary* jsondata=(NSDictionary*) [datastr objectFromJSONString];
        result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
        NSLog(@"%d",result);
    } @catch (NSException *exception) {
        result=-1;
    }
    
    //result: 1,删除成功 不等于1,失败
   
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork5:)]) {
            [self.delegate afternetwork5:[NSNumber numberWithInt:result]];
        
    }
    
    
}




@end
