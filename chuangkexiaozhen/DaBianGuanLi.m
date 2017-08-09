//
//  DaBianGuanLi.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "DaBianGuanLi.h"

@implementation DaBianGuanLi


/*
 1.1 答辩管理查询
 请求 get  http://116.228.176.34:9002/chuangke-serve/applytreat/search?start=0&length=10000
 响应： [{"id":"58e5c76a19eb26b288dc975b","companyName"
 :"上海匠睿智能科技有限公司","defenceDate":"2017-04-06","addr":"科创小镇1楼会议室","usernames":"王俊","isspcial":1,"iftreated"
 :"true"},{"id":"58f5884519eb8cbffbb87a9e","companyName":"清基(上海）农业发展有限公司","defenceDate":"2017-04-18","addr"
 :"一楼小会议室","usernames":"王俊","isspcial":1,"iftreated":"true"}]
 "iftreated":"true" 表示已经打分
  "iftreated":"false" 表示未打分
 */
-(void)DaBianGuanLiQuery
{
    {
        NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
        AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
        NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/applytreat/search?start=0&length=10000"];
        
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
        
    }
}

/*
 1.2 答辩管理删除
 请求 http://116.228.176.34:9002/chuangke-serve/applytreat/batchdelete?ids=58feffdc19eb8cbffbb87bcc
 参数 ids为答辩管理记录id
 */
-(void)DaBianDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?ids=%@",baseurl,@"/applytreat/batchdelete",ids];
    
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



/*
 1.3 打分及文件上传
 请求 post http://116.228.176.34:9002/chuangke-serve/reviewinfo/save
 请求参数
 是否允许接入 agreeApplyin	true
 答辩记录id  applyTreatId	597dbefb80ab5e6790d52d79
 附件 resourceIds	 598887e222637b17beb2f87a,598887e622637b17beb2f87b
 reasons	与园区方向切合度
 reasons	项目创新性和独特性
 reasons	项目团队运营能力
 reasons	项目市场业务能力
 reasons	项目产品技术研发能力
 scores	80
 scores	80
 scores	80
 scores	80
 scores	80
 */
-(void)DaBianPingFenSubmit:(NSDictionary*)param
{

    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/reviewinfo/save"];
    NSString* agreeApplyin=[param objectNotNullForKey:@"agreeApplyin"];
    NSString* applyTreatId=[param objectNotNullForKey:@"applyTreatId"];
    NSString* resourceIds=[param objectNotNullForKey:@"resourceIds"];
    NSString* reasons1=[((NSArray*)[param objectForKey:@"reasons"]) objectAtIndexNotErr:0];
    NSString* reasons2=[((NSArray*)[param objectForKey:@"reasons"]) objectAtIndexNotErr:1];
    NSString* reasons3=[((NSArray*)[param objectForKey:@"reasons"]) objectAtIndexNotErr:2];
    NSString* reasons4=[((NSArray*)[param objectForKey:@"reasons"]) objectAtIndexNotErr:3];
    NSString* reasons5=[((NSArray*)[param objectForKey:@"reasons"]) objectAtIndexNotErr:4];
    
    NSString* scores1=[((NSArray*)[param objectForKey:@"scores"]) objectAtIndexNotErr:0];
    NSString* scores2=[((NSArray*)[param objectForKey:@"scores"]) objectAtIndexNotErr:1];
    NSString* scores3=[((NSArray*)[param objectForKey:@"scores"]) objectAtIndexNotErr:2];
    NSString* scores4=[((NSArray*)[param objectForKey:@"scores"]) objectAtIndexNotErr:3];
    NSString* scores5=[((NSArray*)[param objectForKey:@"scores"]) objectAtIndexNotErr:4];
    NSString* post=[NSString stringWithFormat:@"agreeApplyin=%@&applyTreatId=%@&resourceIds=%@&reasons=%@&scores=%@&reasons=%@&scores=%@&reasons=%@&scores=%@&reasons=%@&scores=%@&reasons=%@&scores=%@",agreeApplyin,applyTreatId,resourceIds,reasons1,scores1,reasons2,scores2,reasons3,scores3,reasons4,scores4,reasons5,scores5];
    NSData* postdate=[post dataUsingEncoding:NSUTF8StringEncoding];
    NSString* length=[NSString stringWithFormat:@"%lu",(unsigned long)[postdate length]];
    NSMutableURLRequest* req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    [req setHTTPMethod:@"POST"];
    [req setValue:length forHTTPHeaderField:@"Content-Length"];
    [req setValue:@"application-x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteData:)]) {
        [self.delegate deleteData:[NSNumber numberWithInt:result]];
    }
    
}


/*
 1.3 打分及文件上传
 请求 post http://116.228.176.34:9002/chuangke-serve/reviewinfo/save
 请求参数
 是否允许接入 agreeApplyin	true
 答辩记录id  applyTreatId	597dbefb80ab5e6790d52d79
 附件 resourceIds	 598887e222637b17beb2f87a,598887e622637b17beb2f87b
 reasons	与园区方向切合度
 reasons	项目创新性和独特性
 reasons	项目团队运营能力
 reasons	项目市场业务能力
 reasons	项目产品技术研发能力
 scores	80
 scores	80
 scores	80
 scores	80
 scores	80
 */
-(void)DaBianPingFenAdd:(NSDictionary*)param
{
    
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/reviewinfo/save"];
    NSString* agreeApplyin=[param objectNotNullForKey:@"agreeApplyin"];
    NSString* applyTreatId=[param objectNotNullForKey:@"applyTreatId"];
    NSString* resourceIds=[param objectNotNullForKey:@"resourceIds"];
    NSString* reasons1=[((NSArray*)[param objectForKey:@"reasons"]) objectAtIndexNotErr:0];
    NSString* reasons2=[((NSArray*)[param objectForKey:@"reasons"]) objectAtIndexNotErr:1];
    NSString* reasons3=[((NSArray*)[param objectForKey:@"reasons"]) objectAtIndexNotErr:2];
    NSString* reasons4=[((NSArray*)[param objectForKey:@"reasons"]) objectAtIndexNotErr:3];
    NSString* reasons5=[((NSArray*)[param objectForKey:@"reasons"]) objectAtIndexNotErr:4];
    
    NSString* scores1=[((NSArray*)[param objectForKey:@"scores"]) objectAtIndexNotErr:0];
    NSString* scores2=[((NSArray*)[param objectForKey:@"scores"]) objectAtIndexNotErr:1];
    NSString* scores3=[((NSArray*)[param objectForKey:@"scores"]) objectAtIndexNotErr:2];
    NSString* scores4=[((NSArray*)[param objectForKey:@"scores"]) objectAtIndexNotErr:3];
    NSString* scores5=[((NSArray*)[param objectForKey:@"scores"]) objectAtIndexNotErr:4];
    NSString* post=[NSString stringWithFormat:@"agreeApplyin=%@&applyTreatId=%@&resourceIds=%@&reasons=%@&scores=%@&reasons=%@&scores=%@&reasons=%@&scores=%@&reasons=%@&scores=%@&reasons=%@&scores=%@",agreeApplyin,applyTreatId,resourceIds,reasons1,scores1,reasons2,scores2,reasons3,scores3,reasons4,scores4,reasons5,scores5];
    NSData* postdate=[post dataUsingEncoding:NSUTF8StringEncoding];
    NSString* length=[NSString stringWithFormat:@"%lu",(unsigned long)[postdate length]];
    NSMutableURLRequest* req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    [req setHTTPMethod:@"POST"];
    [req setValue:length forHTTPHeaderField:@"Content-Length"];
    [req setValue:@"application-x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteData:)]) {
        [self.delegate deleteData:[NSNumber numberWithInt:result]];
    }
    
}

@end
