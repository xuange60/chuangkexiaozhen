//
//  YongHuXinXi.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YongHuXinXi.h"

@implementation YongHuXinXi


/*
 2.20.1 用户列表查询
 http://116.228.176.34:9002/chuangke-serve/user/search?start=0&length=1000
 [{"id":"5995799ea92b0b6e2c92edae","stopflag"
 :false,"loginName":"ceshi1","sex":null,"phone":"18676671111","email":"","addr":null,"companyName":null
 ,"companyType":null,"concat":null,"department":"xxx","rank":"xxx","createDate":"2017-08-17 19:10:22"
 ,"manager":true,"joinDate":null,"name":"测试"},{"id":"5981e17b80ab5e6790d53b59","stopflag":false,"loginName"
 :"ceshi","sex":null,"phone":"18511111111","email":"","addr":null,"companyName":null,"companyType":null
 ,"concat":null,"department":"1","rank":"","createDate":"2017-08-02 22:28:11","manager":true,"joinDate"
 :null,"name":"ceshi"}]
 */
-(void)YongHuQuery
{
    [super querylistWithRole:@"" andRelativeUrl:@"/user/search"];
}


/*
 2.20.2 删除用户
 http://116.228.176.34:9002/chuangke-serve/user/batchdelete?ids=5995799ea92b0b6e2c92edae
 */
-(void)YongHuDelete:(NSString*)ids
{
    [super deleteWithId:ids andRelativeUrl:@"/user/batchdelete"];
}


/*
 2.20.3 用户停用
 http://116.228.176.34:9002/chuangke-serve/user/upuserstatus?id=59849a3280ab5e6790d54495&flagStr=true
 */
-(void)YongHuStop:(NSString*)ids
{
    NSString* paramstr=[NSString stringWithFormat:@"id=%@&flagStr=true",ids];
    [super succWithParam:paramstr andRelativeUrl:@"/user/upuserstatus"];
}


-(void)YongHuStart:(NSString*)ids
{
    NSString* paramstr=[NSString stringWithFormat:@"id=%@&flagStr=false",ids];
    [super succWithParam:paramstr andRelativeUrl:@"/user/upuserstatus"];
}



/*
 2.20.4 查询用户
 http://116.228.176.34:9002/chuangke-serve/user/edit?id=598495bc80ab5e6790d54493
 
 2.20.5 修改用户
 http://116.228.176.34:9002/chuangke-serve/user/update
 comanyname	xxxxx
 companytype	电子信息
 department	xxx
 email	4444@qq.com
 id	598495bc80ab5e6790d54493
 mobile	17566562783
 name	ceshigongsi
 rank	21
 remark	1112
 roleIds	5875a66fee19799d1cc83827
 roleIds	589d240277c87dfcad569547
 username	ceshi12222
 */
//查询所有岗位
-(void)YongHuDetailQuery:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?id=%@",baseurl,@"/user/edit",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        
        if([contenttype containsString:@"html"]){
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//select"];
            NSMutableDictionary* datas=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * name=[ele objectForKey:@"name"];
                NSString* selectedname=[NSString stringWithFormat:@"selected%@",name];//被选中的数据
                
                NSArray* options=[ele childrenWithTagName:@"option"];
                if(name!=nil && options!=nil && [options count]>0){
                    NSMutableDictionary* data=[NSMutableDictionary dictionary];
                    NSMutableDictionary* selecteddata=[NSMutableDictionary dictionary];
                    for (TFHppleElement *ele1 in options) {
                        NSString* value1=[ele1 objectForKey:@"value"];
                        NSString* key1=[ele1 content];
                        if(value1!=nil && key1!=nil){
                            [data setObject:value1 forKey:key1];
                        }
                        NSDictionary* attributes=[ele1 attributes];
                        NSLog(@"%@",attributes);
                        NSString* selected=[attributes objectNotNullForKey:@"selected"];
                        if([selected isEqualToString:@"selected"] && key1!=nil){
                            [selecteddata setObject:value1 forKey:key1];
                        }
                    }
                    [datas setObject:data forKey:name];
                    [datas setObject:selecteddata forKey:selectedname];
                }
            }
            
            //字典NSMutableDictionary* datas包含了查询到的数据
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork5:)]) {
                [self.delegate afternetwork5:datas];
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
-(void)yongHuModify:(NSDictionary*)param
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/user/update"];
    
    NSString* comanyname=[param objectNotNullForKey:@"comanyname"];
    NSString* companytype=[param objectNotNullForKey:@"companytype"];
    NSString* department=[param objectNotNullForKey:@"department"];
    NSString* email=[param objectNotNullForKey:@"email"];
    NSString* ids=[param objectNotNullForKey:@"id"];
    NSString* mobile=[param objectNotNullForKey:@"mobile"];
    NSString* name=[param objectNotNullForKey:@"name"];
    NSString* rank=[param objectNotNullForKey:@"rank"];
    NSString* username=[param objectNotNullForKey:@"username"];
    NSString* remark=[param objectNotNullForKey:@"remark"];
    
    NSMutableString* roleIds=[NSMutableString string];
    NSArray* ary1=(NSArray*)[param objectForKey:@"roleIds"];
    if([ary1 count]>0){
        roleIds=[NSMutableString stringWithString:@"&"];
        for (int i=0; i<[ary1 count]; i++) {
            NSString* data=[ary1 objectAtIndex:i];
            [roleIds appendFormat:@"roleIds=%@",data];
            if(i<([ary1 count]-1)){
                [roleIds appendString:@"&"];
            }
        }
    }
    

    
    
    NSString* post=[NSString stringWithFormat:@"comanyname=%@&companytype=%@%@&department=%@&email=%@&id=%@&mobile=%@&name=%@&rank=%@&username=%@&remark=%@",comanyname,companytype,roleIds,department,email,ids,mobile,name,rank,username,remark];
    
    
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
    if(result==1){
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork4:)]) {
            [self.delegate afternetwork4:[NSNumber numberWithInt:result]];
        }
    }
    

}


/*
 2.20.6 修改密码
 http://116.228.176.34:9002/chuangke-serve/user/update/password
 */
-(void)YongHuPwdModify:(NSDictionary*)param
{
    [super updateWithData:param andRelativeUrl:@"/user/update/password"];
}








@end
