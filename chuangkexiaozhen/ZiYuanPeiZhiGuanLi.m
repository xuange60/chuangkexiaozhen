//
//  ZiYuanPeiZhiGuanLi.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/11.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ZiYuanPeiZhiGuanLi.h"

@implementation ZiYuanPeiZhiGuanLi


/*
 2.13.0 在修改资源时，可以下拉选择资产编号；查询到所有的资产编号
 */
-(void) ZiYuanGuanLiDetailQuery:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/resourceallocation/edit?id=",ids];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork3:)]) {
                [self.delegate afternetwork3:datas];
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



-(void) ZiYuanGuanLiInitQuery:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/resourceallocation/add?id=",ids];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork3:)]) {
                [self.delegate afternetwork3:datas];
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
 2.13.1 资源管理配置修改
 post http://116.228.176.34:9002/chuangke-serve/resourceallocation/update
 参数
 EgcCodes	58e6005f19eb64c4e63875fd
 EgcCodes	58e6005f19eb64c4e63875fd
 OeCodes	58e600f419eb64c4e6387604
 OeCodes	59361919075910c2d60d0789
 OeCodes	58e600f419eb64c4e6387604
 OeCodes	59361919075910c2d60d0789
 PlCodes	58f58e5119eb8cbffbb87ad5
 PlCodes	58f58e6519eb8cbffbb87ad7
 PlCodes	58f58e5119eb8cbffbb87ad5
 PlCodes	58f58e6519eb8cbffbb87ad7
 TcCodes	597d815f80ab5e6790d52d52
 TcCodes	597d814c80ab5e6790d52d4f
 TcCodes	597d815480ab5e6790d52d50
 concatType
 desc	2222
 id	597d825c80ab5e6790d52d62
 name
 numberOfOffice	1
 numberOfegc	1
 numberOfoe	3
 numberOfpl	2
 numberOftc	2
 printAccount	1
 printPassword	1
 
 
 {"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void) ZiYuanGuanLiModify:(NSDictionary*)param
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resourceallocation/update"];
    NSString* concatType=[param objectNotNullForKey:@"concatType"];
    NSString* desc=[param objectNotNullForKey:@"desc"];
    NSString* ids=[param objectNotNullForKey:@"id"];
    NSString* name=[param objectNotNullForKey:@"name"];
    NSString* numberOfOffice=[param objectNotNullForKey:@"numberOfOffice"];
    NSString* numberOfegc=[param objectNotNullForKey:@"numberOfegc"];
    NSString* numberOfoe=[param objectNotNullForKey:@"numberOfoe"];
    NSString* numberOfpl=[param objectNotNullForKey:@"numberOfpl"];
    NSString* numberOftc=[param objectNotNullForKey:@"numberOftc"];
    NSString* printAccount=[param objectNotNullForKey:@"printAccount"];
    NSString* printPassword=[param objectNotNullForKey:@"printPassword"];
    


    NSMutableString* EgcCodes=[NSMutableString string];
    NSArray* ary1=(NSArray*)[param objectForKey:@"egcCodes"];
    if([ary1 count]>0){
        EgcCodes=[NSMutableString stringWithString:@"&"];
        for (int i=0; i<[ary1 count]; i++) {
            NSString* data=[ary1 objectAtIndex:i];
            [EgcCodes appendFormat:@"EgcCodes=%@",data];
            if(i<([ary1 count]-1)){
                [EgcCodes appendString:@"&"];
            }
        }
    }
    
    NSMutableString* OeCodes=[NSMutableString string];
    NSArray* ary2=(NSArray*)[param objectForKey:@"oeCodes"];
    if([ary2 count]>0){
        OeCodes=[NSMutableString stringWithString:@"&"];
        for (int i=0; i<[ary2 count]; i++) {
            NSString* data=[ary2 objectAtIndex:i];
            [OeCodes appendFormat:@"OeCodes=%@",data];
            if(i<([ary2 count]-1)){
                [OeCodes appendString:@"&"];
            }
        }
    }
    
    NSMutableString* PlCodes=[NSMutableString string];

    NSArray* ary3=(NSArray*)[param objectForKey:@"plCodes"];
    if([ary3 count]>0){
        PlCodes=[NSMutableString stringWithString:@"&"];
        for (int i=0; i<[ary3 count]; i++) {
            NSString* data=[ary3 objectAtIndex:i];
            [PlCodes appendFormat:@"PlCodes=%@",data];
            if(i<([ary3 count]-1)){
                [PlCodes appendString:@"&"];
            }
        }
    }
    
    NSMutableString* TcCodes=[NSMutableString string];
    NSArray* ary4=(NSArray*)[param objectForKey:@"tcCodes"];
    if([ary4 count]>0){
        TcCodes=[NSMutableString stringWithString:@"&"];
        for (int i=0; i<[ary4 count]; i++) {
            NSString* data=[ary4 objectAtIndex:i];
            [TcCodes appendFormat:@"TcCodes=%@",data];
            if(i<([ary4 count]-1)){
                [TcCodes appendString:@"&"];
            }
        }
    }
    

    NSString* post=[NSString stringWithFormat:@"id=%@&numberOfOffice=%@&numberOftc=%@%@&numberOfoe=%@%@&printAccount=%@&printPassword=%@&numberOfegc=%@%@&numberOfpl=%@%@&name=%@&concatType=%@&desc=%@",ids,numberOfOffice,numberOftc,TcCodes,numberOfoe,OeCodes,printAccount,printPassword,numberOfegc,EgcCodes,numberOfpl,PlCodes,name,concatType,desc];
    

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
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork1:)]) {
            [self.delegate afternetwork1:[NSNumber numberWithInt:result]];
        }
    }
    

}



-(void) ZiYuanGuanLiInit:(NSDictionary*)param
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resourceallocation/save"];
    NSString* concatType=[param objectNotNullForKey:@"concatType"];
    NSString* desc=[param objectNotNullForKey:@"desc"];
    NSString* ids=[param objectNotNullForKey:@"id"];
    NSString* name=[param objectNotNullForKey:@"name"];
    NSString* numberOfOffice=[param objectNotNullForKey:@"numberOfOffice"];
    NSString* numberOfegc=[param objectNotNullForKey:@"numberOfegc"];
    NSString* numberOfoe=[param objectNotNullForKey:@"numberOfoe"];
    NSString* numberOfpl=[param objectNotNullForKey:@"numberOfpl"];
    NSString* numberOftc=[param objectNotNullForKey:@"numberOftc"];
    NSString* printAccount=[param objectNotNullForKey:@"printAccount"];
    NSString* printPassword=[param objectNotNullForKey:@"printPassword"];
    
    
    
    NSMutableString* EgcCodes=[NSMutableString string];
    NSArray* ary1=(NSArray*)[param objectForKey:@"egcCodes"];
    if([ary1 count]>0){
        EgcCodes=[NSMutableString stringWithString:@"&"];
        for (int i=0; i<[ary1 count]; i++) {
            NSString* data=[ary1 objectAtIndex:i];
            [EgcCodes appendFormat:@"EgcCodes=%@",data];
            if(i<([ary1 count]-1)){
                [EgcCodes appendString:@"&"];
            }
        }
    }
    
    NSMutableString* OeCodes=[NSMutableString string];
    NSArray* ary2=(NSArray*)[param objectForKey:@"oeCodes"];
    if([ary2 count]>0){
        OeCodes=[NSMutableString stringWithString:@"&"];
        for (int i=0; i<[ary2 count]; i++) {
            NSString* data=[ary2 objectAtIndex:i];
            [OeCodes appendFormat:@"OeCodes=%@",data];
            if(i<([ary2 count]-1)){
                [OeCodes appendString:@"&"];
            }
        }
    }
    
    NSMutableString* PlCodes=[NSMutableString string];
    NSArray* ary3=(NSArray*)[param objectForKey:@"plCodes"];
    if([ary3 count]>0){
        PlCodes=[NSMutableString stringWithString:@"&"];
        for (int i=0; i<[ary3 count]; i++) {
            NSString* data=[ary3 objectAtIndex:i];
            [PlCodes appendFormat:@"PlCodes=%@",data];
            if(i<([ary3 count]-1)){
                [PlCodes appendString:@"&"];
            }
        }
    }
    
    NSMutableString* TcCodes=[NSMutableString string];
    NSArray* ary4=(NSArray*)[param objectForKey:@"tcCodes"];
    if([ary4 count]>0){
        TcCodes=[NSMutableString stringWithString:@"&"];
        for (int i=0; i<[ary4 count]; i++) {
            NSString* data=[ary4 objectAtIndex:i];
            [TcCodes appendFormat:@"TcCodes=%@",data];
            if(i<([ary4 count]-1)){
                [TcCodes appendString:@"&"];
            }
        }
    }
    
    
    NSString* post=[NSString stringWithFormat:@"tenantId=%@&numberOfOffice=%@&numberOftc=%@%@&numberOfoe=%@%@&printAccount=%@&printPassword=%@&numberOfegc=%@%@&numberOfpl=%@%@&name=%@&concatType=%@&desc=%@",ids,numberOfOffice,numberOftc,TcCodes,numberOfoe,OeCodes,printAccount,printPassword,numberOfegc,EgcCodes,numberOfpl,PlCodes,name,concatType,desc];
    
    
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
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork1:)]) {
            [self.delegate afternetwork1:[NSNumber numberWithInt:result]];
        }
    }
    
    
}




/*
 2.13.2 资源管理查询
 http://116.228.176.34:9002/chuangke-serve/resourceallocation/search?length=1000&start=0
 [{"id":"58e5fd9f19eb64c4e63875f6","officeArea"
 :null,"numberOfOffice":2,"numberOftc":2,"tcCodes":"KCXZ-BGZY0001,KCXZ=BGZY0002","numberOfoe":2,"oeCodes"
 :"KCXZ-BGSB0001,KCXZ-BGSB0002","printAccount":"wy01","printPassword":"wy01","numberOfegc":2,"egcCodes"
 :"KCXZ-CYK0039,KCXZ-CYK0040","numberOfpl":2,"plCodes":"KCXZ-CW0001,KCXZ-CW0002","companyName":"上海匠睿智
 能科技有限公司","name":"王俊","concatType":"15901647707","desc":""},{"id":"58f5892e19eb8cbffbb87aa5","officeArea"
 :null,"numberOfOffice":6,"numberOftc":6,"tcCodes":"","numberOfoe":0,"oeCodes":"","printAccount":"qjny01"
 ,"printPassword":"111111","numberOfegc":4,"egcCodes":"KCXZ-CYK0021,KCXZ-CYK0022,KCXZ-CYK0023,KCXZ-CYK0024"
 ,"numberOfpl":2,"plCodes":"KCXZ-CW0003,KCXZ-CW0004","companyName":"清基(上海）农业发展有限公司","name":"陈强","concatType"
 :"","desc":""}]
 */
-(void)ZiYuanGuanLiQuery
{
    NSMutableArray* ary=[NSMutableArray array];
    [self ZiYuanGuanLiQuery:ary];
    
}

-(void)ZiYuanGuanLiQuery:(NSMutableArray*)ary
{
    int start=(int)[ary count];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];;
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%d",baseurl,@"/resourceallocation/search?length=50&start=",start];
    
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
                [self ZiYuanGuanLiQuery:ary];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :ary];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self.delegate  loadNetworkFinished :ary];
    }];
}



/*
 2.13.3 资源管理删除
 http://116.228.176.34:9002/chuangke-serve/resourceallocation/delete?id=58e5fd9f19eb64c4e63875f6
 */
-(void) ZiYuanGuanLiDelete:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/resourceallocation/delete?id=",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,成功 不等于1,失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork2:)]) {
                [self.delegate afternetwork2:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}





@end
