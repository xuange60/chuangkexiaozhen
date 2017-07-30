//
//  BussinessApi.m
//  TestDemo
//
//  Created by zhangxuan on 17/7/23.
//  Copyright © 2017年 zhangxuan. All rights reserved.
//

#import "BussinessApi.h"

@implementation BussinessApi

-(id)init
{
    if (self=[super init])
    {
        
    }
    return self;
}











//用户登录
//参数 用户名，密码
//返回数组数据 [{"初始申请",["实体入驻","虚拟入驻","文档下载"]}]
-(void) loginWithName:(NSString*) name andPwd:(NSString*) pwd
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    //清除cookie缓存
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for(id obj in cookieArray)
    {
        [cookieJar deleteCookie:obj];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"chuangkexiaozhen.cookie"];
    [defaults synchronize];
    
    
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"username",pwd,@"password",@"1",@"holdme", nil];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/login"];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            if(0==result){
                NSLog(@"%@",@"用户名或密码错误"); //登陆失败
                /**
                 *登陆失败提示
                 */
            }
        }else if([contenttype containsString:@"html"]){ //登陆成功
            //保存cookies
            NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:cookiesData forKey:@"chuangkexiaozhen.cookie"];
            [defaults synchronize];
            
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//dl"];
            
            NSMutableArray* datas=[[NSMutableArray alloc]init];
            for (TFHppleElement *ele in arrays) {
                TFHppleElement* e1 =[ele firstChildWithTagName:@"dt"];
                NSString* title=[[e1 text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                NSArray* ary1=[ele searchWithXPathQuery:@"//a"];
                
                NSMutableArray* ary=[[NSMutableArray alloc] init];
                for (TFHppleElement *e2 in ary1) {
                    NSString* content=[e2.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    [ary addObject:content];
                }
                if([ary count]>0){
                    NSDictionary* dic=[[NSDictionary alloc] initWithObjectsAndKeys:ary,title,nil];
                    [datas addObject:dic];
                }
                
            }
            NSData *data = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);//datas包含了主界面相关数据
            /**
             *登陆成功界面显示
             */
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        //登陆失败 界面提示
    }];
}


//退出登录
-(void)logout
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    //清除cookie缓存
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for(id obj in cookieArray)
    {
        [cookieJar deleteCookie:obj];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"chuangkexiaozhen.cookie"];
    [defaults synchronize];
    
    
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/logout"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",@"登出成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

//检查用户名
//参数 用户名
//result:  false,用户名已被占用 非false，用户名可用
-(void) checkName:(NSString*)name
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"loginname", nil];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/register/check"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSString* result=[jsondata objectForKey:@"actionid"];
            NSLog(@"%@",result);
            //result:  false,用户名已被占用 非false，用户名可用
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}


//检查手机号码
//参数 手机号码
//result: false,手机号码不可用 非false,手机号码可用
-(void) checkMobile:(NSString*)mobile
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile", nil];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/register/check"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSString* result=[jsondata objectForKey:@"actionid"];
            NSLog(@"%@",result);
            //result: false,手机号码不可用 非false,手机号码可用
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}

//注册时，获取验证码
//参数，手机号码
//result: 1,验证码发送成功 不等于1,验证码发送失败
-(void) registerGetCode:(NSString*)mobile
{
    __block int yanZhengMaResult=0;
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile",[NSNumber numberWithInt:1],@"type", nil];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/auth/code"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            NSLog(@"%d",result);
            //result: 1,验证码发送成功 不等于1,验证码发送失败
            yanZhengMaResult=result;
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}



//用户注册
//result: 1,注册成功 不等于1,则注册失败
-(void) registerWithCode:(NSString*)checkcode name:(NSString*)name mobile:(NSString*)mobile email:(NSString*)email pwd:(NSString*)pwd type:(NSString*)type
{
    __block zhuCeResult=0;
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:checkcode,@"mcode",name,@"loginName",mobile,@"mobilePhone",email,@"email",pwd,@"plainPassword",type,@"typeidx", nil];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/register"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            NSLog(@"%d",result);
            //result: 1,注册成功 不等于1,则注册失败
            zhuCeResult=result;
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}




//检查手机号和用户名是否一致
//result: false,用户名或密码错误 非false,用户名或密码一致
-(void) checkName:(NSString*)name mobile:(NSString*)mobile
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"loginname",mobile,@"mobile", nil];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/retrieve/check"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSString* result=[jsondata objectForKey:@"actionid"];
            NSLog(@"%@",result);
            //result: false,用户名或密码错误 非false,用户名或密码一致
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}


//重置时获取验证码
//result: 1,验证码发送成功 不等于1,验证码发送失败
-(void) resetGetCode:(NSString*)mobile
{
    __block int resetYzmResult=0;
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile",[NSNumber numberWithInt:2],@"type", nil];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/auth/code"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            NSLog(@"%d",result);
            //result: 1,验证码发送成功 不等于1,验证码发送失败
            resetYzmResult=result;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}


//重置密码
//result: 1,密码重置成功 不等于1,则密码重置失败
-(void) resetPwdWithCode:(NSString*)checkcode name:(NSString*)name mobile:(NSString*)mobile pwd:(NSString*)pwd
{
    __block int mimaResult=0;//加上——block在block里面就是地址传递
    
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:checkcode,@"mcode",name,@"loginName",mobile,@"mobilePhone",pwd,@"plainPassword",nil];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/retrieve/update"];
    
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
         NSString* contenttype=[headers objectForKey:@"Content-Type"];
         NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
         if([contenttype containsString:@"json"]){//返回json格式数据
             NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
             int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
             
             NSLog(@"%d",result);
             
             mimaResult=result;
             
             //result: 1,密码重置成功 不等于1,则密码重置失败
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error);
         
     }];
}


//实体入驻查询
//如果用户未提交过申请，不可以查到申请记录；用户层申请过申请，可以查到已提交的数据
/*如查询到记录时，返回字典数据可能为：
 {"resourceIds" : "","contact" : "张玄","companyName" : "测试机构","description" : "初创团队","contactType" : "18576672852","applyStatus" : "通过","businessline" : "电子信息"}
 入未查询到数据，字典数据为空；
 */
-(void) shiTiRuZhuQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/apply/add"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        
        if([contenttype containsString:@"html"]){
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//input"];
            NSMutableDictionary* dic=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * idstr=[ele objectForKey:@"id"];
                NSString* value=[ele objectForKey:@"value"];
                if(idstr!=nil && value!=nil){
                    [dic setObject:value forKey:idstr];
                }
            }
            
            //字典NSMutableDictionary* dic包含了查询到的数据
            
            //打印查询到的数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}







//参数 NSData类型的文件数据,文件类型如jpg，png等
//文件上传成功时返回ResourceId
-(void) shitiRuZhuFileup:(NSData*) filedata withType:(NSString*)type
{
    __block NSString*ids=nil;
    
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"实体入驻_%@.%@", str,type];
    NSLog(@"%@",fileName);
    
    NSDictionary *dict = @{@"":@""};
    NSString *urlString = @"http://116.228.176.34:9002/chuangke-serve/upload/save";
    [manager POST:urlString parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData){
    //[formData appendPartWithFileURL:[NSURLfileURLWithPath:@"文件地址"] name:@"file"fileName:@"1234.png"mimeType:@"application/octet-stream"error:nil];
    [formData appendPartWithFileData:filedata name:@"file" fileName:fileName mimeType:@"image/png"];
}progress:^(NSProgress * _Nonnull uploadProgress){
    // 打印下上传进度 此处界面可能要显示上传进度
    NSLog(@"%lld%@",100 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount,@"%");
}success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
    
    NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
    NSLog(@"%@",data);
    NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
    
    // 文件上传成功 获取ResourceId
    NSString* ResourceId=[jsondata objectForKey:@"ResourceId"];
    NSLog(@"%@",ResourceId);
    
    ids=ResourceId;
    
}failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
    // 请求失败
    NSLog(@"请求失败：%@", error);
}];
}



-(void) shiTiRuZhuSubmitWithParam:(NSDictionary*)param
{
    __block int shiTiResult=0;
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:param];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/apply/save"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            NSLog(@"%d",result);
            //result: 1,实体入驻提交成功 不等于1,则提交失败
            shiTiResult=result;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}


//虚拟入驻申请
-(void) xuniRuZhuSubmitWithParam:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:param];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/apply/saveresapply"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            NSLog(@"%d",result);
            //result: 1,虚拟入驻提交成功 不等于1,则提交失败
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}


//初始申请上传的所有文件查询
-(void) chushishenqingFileQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/search"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"start",@"100",@"length", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            //数组result为结果数据
            
            //打印查询到的数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



//5.6 初始申请时上传的文档删除
//参数为 文档的资源id；
-(void) chushishenqingFileDelete:(NSString*)resourceid
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


//5.7 初始申请时上传的文档下载
-(void) chushishenqingFileDownload:(NSString*)resourceid
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/down"];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id", nil];
    
    [manager GET:url parameters:parameters
        progress:^(NSProgress * _Nonnull downloadProgress)
     {
         // 打印下下载进度
         NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
     }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
         NSString* Disposition=[headers objectForKey:@"Content-Disposition"];
         NSString* filename=nil;
         if(Disposition!=nil){
             NSRange range=[Disposition rangeOfString:@"filename"];
             if(range.location>0){
                 filename=[Disposition substringFromIndex:(range.location+range.length+1)];
                 NSLog(@"%@",filename);
             }
         }
         if(filename==nil){
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             formatter.dateFormat = @"yyyyMMddHHmmss";
             NSString *str = [formatter stringFromDate:[NSDate date]];
             filename = [NSString stringWithFormat:@"实体入驻_%@.jpg", str];
         }
         
         NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
         NSString* file=[filePath stringByAppendingPathComponent:filename];
         NSLog(@"%@",file);
         NSFileManager* filemanager=[[NSFileManager alloc]init];
         if(![filemanager fileExistsAtPath:file]){
             [filemanager createFileAtPath:file contents:nil attributes:nil];
         }
         
         NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:file];
         [fileHandle writeData:(NSData*)responseObject];
         [fileHandle closeFile];
         
         //此时文件下载成功；
         
         //将文件id，文件路径保存下来
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         NSMutableDictionary* dic=[defaults objectForKey:@"chuangkexiaozhen.resource"];
         if(dic==nil){
             dic=[NSMutableDictionary dictionary];
         }
         [dic setObject:file forKey:resourceid];
         [defaults setObject:dic forKey:@"chuangkexiaozhen.resource"];
         
         
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"%@",error);
     }
     ];
}







//开通主线查询
//查询成功数据保存在字典中；字典中没有数据，代表未申请过，可以提交申请；字典中有数据，显示数据即可，不可以提交数据
-(void)kaiTongZhuXianQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/mainline/add"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        
        if([contenttype containsString:@"html"]){
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//input"];
            NSMutableDictionary* tmpdic=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * idstr=[ele objectForKey:@"id"];
                NSString* value=[ele objectForKey:@"value"];
                if(idstr!=nil && value!=nil){
                    [tmpdic setObject:value forKey:idstr];
                }
            }
            
            NSMutableDictionary* dic=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * idstr=[ele objectForKey:@"name"];
                NSString* value=[ele objectForKey:@"value"];
                if(idstr!=nil && value!=nil){
                    [dic setObject:value forKey:idstr];
                }
            }
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str); //打印查询到的数据
            if([tmpdic objectForKey:@"submit"]!=nil){//如果有提交按钮，则需要用户录入注册数据；
                dic=nil;
            }
            
            //字典NSMutableDictionary* dic包含了查询到的数据
            //查询成功数据保存在字典中；字典中没有数据，代表未申请过，可以提交申请；字典中有数据，显示数据即可，不可以提交数据
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}



//开通主线申请
/*参数：
 公司名称 	companyname
 统一号	uninumber
 入驻人数  reportedbodies
 租赁面积 leasearea
 楼层 floor
 通信要求 communications
 汽车车位 parkingLot
 就餐人数 repastbodies
 工商要求 businessneeds
 法务要求 legalneeds
 文印要求 printneeds
 企业状况 companystatus
 */
-(void)kaiTongZhuXian:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"true",@"applynetshare",
                                     @"无特殊需求",@"bearing",@"",@"commie",@"",@"democrat",@"",@"junior",
                                     @"",@"master",@"",@"returnees",@"",@"spts",@"",@"undergraduate",@"",@"other",@"无特殊需求",@"electricity",@"无特殊需求",@"water",@"false",@"reformdecoration", nil];
    [parameters addEntriesFromDictionary:param];
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/mainline/save"];
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
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


//我的资源配置
-(void)woDeZiYuanPeizhiQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resourceallocation/owner"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        
        if([contenttype containsString:@"html"]){
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//input"];
            NSMutableDictionary* dic=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * idstr=[ele objectForKey:@"name"];
                NSString* value=[ele objectForKey:@"value"];
                if(idstr!=nil && value!=nil){
                    [dic setObject:value forKey:idstr];
                }
            }
            
            
            //查询到的我的资源配置信息
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str); //打印查询到的数据
            
            //字典NSMutableDictionary* dic包含了查询到的数据
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


//申诉申请查询
-(void)shenSuShenQingQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/stateapply/search?start=0&length=1000"];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



//申诉申请提交
-(void)shenSuShenQingSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/stateapply/save"];
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
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}





//申诉请求删除
-(void)shenSuShenQingDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?ids=%@",baseurl,@"/stateapply/batchdelete",ids];
    
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
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}




//7.1.1孵化成长管理->日常活跃度管理->比赛管理查询
/*
 响应 	响应数据为array；如下格式
 [{"id":"5937dbe5075910c2d60d07c6","name"
 :"上海市创新创业大赛","competeLevel":"省部级比赛","prizeAwarded":"一等奖","hornerName":"********","orgnizationUnit":""
 ,"date":"2017-06-07 10:56:37","ownerCompetition":"是","score":14,"company":"云创智能科技有限公司"}]
 */
-(void)biSaiGuanLiQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/competition/search?start=0&length=1000"];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




//7.1.2孵化成长管理->日常活跃度管理->比赛管理添加
/*
 请求参数：
 比赛级别 competeLevel
 荣誉名称 hornerName
 比赛名称 name
 组织单位 orgnizationUnit
 是否本园区组织 ownerCompetition
 获奖名次 prizeAwarded
 上传图片的资源id resourceIds
 */
-(void)biSaiGuanLiSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* competeLevels=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c2114c1a48b6fd96506a",@"国家级比赛",@"58c7c2114c1a48b6fd96506b",@"省部级比赛",@"58c7c2114c1a48b6fd96506c",@"区县级比赛",@"58c7c2114c1a48b6fd96506d",@"一般比赛", nil];
    NSString* value=[parameters objectForKey:@"competeLevel"];
    [parameters setObject: [competeLevels objectForKey:value] forKey:@"competeLevel"];
    
    NSDictionary* prizeAwardeds=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c3c44c1ae760f68a1013",@"一等奖",@"58c7c3c44c1ae760f68a1014",@"二等奖",@"58c7c3c44c1ae760f68a1015",@"三等奖", nil];
    NSString* value2=[parameters objectForKey:@"prizeAwarded"];
    [parameters setObject: [prizeAwardeds objectForKey:value2] forKey:@"prizeAwarded"];
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/competition/save"];
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
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}




//7.1.3孵化成长管理->日常活跃度管理->比赛管理删除
-(void)biSaiGuanLiDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?ids=%@",baseurl,@"/competition/batchdelete",ids];
    
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
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}





//7.1.4 孵化成长管理->日常活跃度管理->查询已上传的图片
-(void)biSaiGuanLiQueryFile:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",@"5",@"typeIndex", nil];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



//7.1.5 孵化成长管理->日常活跃度管理->已上传的文档删除
//参数为 文档的资源id； entityId比赛id
-(void) biSaiGuanLiFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"5",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}









//7.2.1 产学研管理查询
/*
 响应 [{"id":"5938cb27075910c2d60d07dd","name"
 :"111","money":3000.0,"effect":"","date":"2017-06-08 03:57:27","company":"云创智能科技有限公司"},{"id":"5938cb08075910c2d60d07db"
 ,"name":"*****","money":2.0,"effect":"","date":"2017-06-08 03:56:56","company":"云创智能科技有限公司"}]
 */
-(void) chanXueYanQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/cooperatorunitInfo/search?start=0&length=1000"];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}





//7.2.2 添加产学研项目
/*
 首先要上传文件；
	提交数据时，请求地址 post http://116.228.176.34:9002/chuangke-serve/cooperatorunitInfo/save
	参数：
 文件id resourceIds
 合作机构名称 name
 合作金额级别 moneyLevel
 合作金额 money
 机构级别 level
 合作效果 effect
 合作机构级别有：
 <option value="5879d94ea5a121dff6b57a5d">合作机构一级</option>
 <option value="58be68b9cfdfdf03086a8833">合作机构三级</option>
 <option value="58c7c57bce7229367c55853e">合作机构二级</option>
	
 合作金额级别有：
 <option value="58be6e1a769052b56d66e91e">1万元以下</option>
 <option value="58be6e54769052b56d66e91f">10万元</option>
 <option value="58be6e72cfdfdf03086a8835">100万元</option>
 */
-(void)chanXueYanSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* levels=[NSDictionary dictionaryWithObjectsAndKeys:@"5879d94ea5a121dff6b57a5d",@"合作机构一级",@"58be68b9cfdfdf03086a8833",@"合作机构三级",@"58c7c57bce7229367c55853e",@"合作机构二级", nil];
    NSString* value=[parameters objectForKey:@"level"];
    [parameters setObject: [levels objectForKey:value] forKey:@"level"];
    
    NSDictionary* moneyLevels=[NSDictionary dictionaryWithObjectsAndKeys:@"58be6e1a769052b56d66e91e",@"1万元以下",@"58be6e54769052b56d66e91f",@"10万元",@"58be6e72cfdfdf03086a8835",@"100万元", nil];
    NSString* value2=[parameters objectForKey:@"moneyLevel"];
    [parameters setObject: [moneyLevels objectForKey:value2] forKey:@"moneyLevel"];
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/cooperatorunitInfo/save"];
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
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}






/*
 7.2.3 合作项目删除
 请求 get  http://116.228.176.34:9002/chuangke-serve/cooperatorunitInfo/delete?id=5938cb08075910c2d60d07db
 参数id为 合作项目id
 */
-(void)chanXueYanDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?id=%@",baseurl,@"/cooperatorunitInfo/delete",ids];
    
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
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




/*
 7.2.4 已上传文件查询
 请求 get
 http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597cc95080ab5e6790d528c3&typeIndex=6
 参数id为 合作项目id
 [{"id":"597cc8ff80ab5e6790d528c1","name"
 :"warn(1).jpg","path":"cash/busiplan/20170729/1501378943000.jpg","date":"2017-07-29"},{"id":"597cc90c80ab5e6790d528c2"
 ,"name":"warn.jpg","path":"cash/busiplan/20170729/1501378956000.jpg","date":"2017-07-29"}]
 */
-(void)chanXueYanQueryFile:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",@"6",@"typeIndex", nil];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}







/*
 7.2.5 删除已上传文件
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=6&entityId=597cc95080ab5e6790d528c3&id=597cc8ff80ab5e6790d528c1
 参数 entityid为合作项目id，id为文件id
 */
-(void) chanXueYanDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"6",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 7.3.1 活动查询
 请求：get http://116.228.176.34:9002/chuangke-serve/activity/search?start=0&length=1000
 响应： [{"id":"5938cd4b075910c2d60d07de","name"
 :"******","activityLevel":"省市级活动","sponsor":"科创小镇","participant":3,"ownerActivity":"否","company":"云创
 智能科技有限公司","date":"2017-06-08 04:06:35"}]
 */
-(void) huoDongQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/activity/search?start=0&length=1000"];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}






/*
 7.3.2 活动添加
 请求 post http://116.228.176.34:9002/chuangke-serve/activity/save
 参数：
 活动级别 activityLevel	5879d979a5a121dff6b57a5f
 活动名称 name	展会活动
 参与人数 participant	2
 resourceIds	597d501c80ab5e6790d52d18,597d504b80ab5e6790d52d19
 主办单位 sponsor	深圳市真服
 响应：
 */
-(void) huoDongSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* activityLevels=[NSDictionary dictionaryWithObjectsAndKeys:@"5879d979a5a121dff6b57a5f",@"省市级活动",@"5879d983a5a121dff6b57a60",@"区县级活动",@"58de163d19eb91a825cd816c",@"园区镇街道活动", nil];
    NSString* value=[parameters objectForKey:@"activityLevel"];
    [parameters setObject: [activityLevels objectForKey:value] forKey:@"activityLevel"];
    
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/activity/save"];
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
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}





/*
 7.3.3 活动删除
 请求 get http://116.228.176.34:9002/chuangke-serve/activity/delete?id=5938cd4b075910c2d60d07de
 参数 活动id
 */
-(void)huoDongDelete:(NSString*) ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?id=%@",baseurl,@"/activity/delete",ids];
    
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
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




/*
 7.3.4 活动管理上传文件下载
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597d505080ab5e6790d52d1a&typeIndex=7
 响应 [{"id":"597d501c80ab5e6790d52d18","name"
 :"warn.jpg","path":"cash/busiplan/20170730/1501413532000.jpg","date":"2017-07-30"},{"id":"597d504b80ab5e6790d52d19"
 ,"name":"warn(1).jpg","path":"cash/busiplan/20170730/1501413579000.jpg","date":"2017-07-30"}]
 */
-(void)huoDongQueryFile:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",@"7",@"typeIndex", nil];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 7.3.5 活动管理文件删除
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=7&entityId=597d505080ab5e6790d52d1a&id=597d504b80ab5e6790d52d19
 参数 entityid为活动id，id为文件id
 */
-(void) huoDongDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"7",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}







/*
 7.4.1 专业知识产权查询
 请求 get http://116.228.176.34:9002/chuangke-serve/knowledge/search?start=0&length=1000
 响应 [{"id":"5937e243075910c2d60d07c8","name"
 :"********","code":"********","type":"软件著作权","date":"2017-06-07 19:23:47","company":"云创智能科技有限公司"}]
 */
-(void)zhuanYeZhiShiQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/knowledge/search?start=0&length=1000"];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 7.4.2 专业知识产权新增
 请求 post  http://116.228.176.34:9002/chuangke-serve/knowledge/save
 参数
 产权编码 code	123131312
 知识名称 name	test
 文件 	 resourceIds	597d60d680ab5e6790d52d21,597d60d980ab5e6790d52d22
 知识类型 type	58be754fcfdfdf03086a8837
 <option value="58be754fcfdfdf03086a8837">软件著作权</option>
 <option value="58be756fcfdfdf03086a8839">集成电路布图设计</option>
 <option value="58be7588cfdfdf03086a883b">商标</option>
 <option value="58be75a9cfdfdf03086a883d">实用新型专利</option>
 <option value="58be75c8cfdfdf03086a883f">发明专利</option>
 <option value="58be75e3cfdfdf03086a8841">文学著作权</option>
 */
-(void)zhuanYeZhiShiSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* types=[NSDictionary dictionaryWithObjectsAndKeys:@"58be754fcfdfdf03086a8837",@"软件著作权",@"58be756fcfdfdf03086a8839",@"集成电路布图设计",@"58be7588cfdfdf03086a883b",@"商标",@"58be75a9cfdfdf03086a883d",@"实用新型专利",@"58be75c8cfdfdf03086a883f",@"发明专利",@"58be75e3cfdfdf03086a8841",@"文学著作权", nil];
    NSString* value=[parameters objectForKey:@"type"];
    [parameters setObject: [types objectForKey:value] forKey:@"type"];
    
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/knowledge/save"];
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
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 7.4.3 专业知识产权删除
 请求 get http://116.228.176.34:9002/chuangke-serve/knowledge/delete?id=597d616180ab5e6790d52d25
 参数为 知识id
 */
-(void)zhuanYeZhiShiDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?id=%@",baseurl,@"/knowledge/delete",ids];
    
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
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 7.4.4 专业知识产权上传文件查询
 请求 get  http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597d60ea80ab5e6790d52d23&typeIndex=8
 响应 [{"id":"597d60d680ab5e6790d52d21","name"
 :"warn(1).jpg","path":"cash/busiplan/20170730/1501417814000.jpg","date":"2017-07-30"},{"id":"597d60d980ab5e6790d52d22"
 ,"name":"warn.jpg","path":"cash/busiplan/20170730/1501417817000.jpg","date":"2017-07-30"}]
 */
-(void)zhuanYeZhiShiFileQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",@"8",@"typeIndex", nil];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 7.4.5  专业知识产权文件删除
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=8&entityId=597d60ea80ab5e6790d52d23&id=597d60d980ab5e6790d52d22
 参数 entityid为知识产权d，id为文件id
 */
-(void) zhuanYeZhiShiFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"8",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 7.5.1 项目管理查询
 请求 get http://116.228.176.34:9002/chuangke-serve/project/search?start=0&length=1000
 响应 [{"id":"5938e5d9075910c2d60d07e1","name"
 :"******","projectLevel":"国家级","competentunit":"******","code":"******","company":"云创智能科技有限公司","date"
 :"2017-06-08 13:51:21"}]
 */
-(void) xiangMuQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/project/search?start=0&length=1000"];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*
 7.5.2 项目提交
 请求 post http://116.228.176.34:9002/chuangke-serve/project/save
 参数：项目编码 code	1231231231
 项目单位 competentunit	12123
 项目名称 name	test1
 项目级别 projectLevel	58c7c6c24c1a3bea9c268d9d
 项目文件 resourceIds	597d6d7280ab5e6790d52d26,597d6d7480ab5e6790d52d27
 <option value="58c7c6c24c1a3bea9c268d9d">国家级</option>
 <option value="58c7c6c24c1a3bea9c268d9e">省部级</option>
 <option value="58c7c6c24c1a3bea9c268d9f">区县级</option>
 <option value="58c7c6c24c1a3bea9c268da0">一般</option>
 */
-(void) xiangMuSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* types=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c6c24c1a3bea9c268d9d",@"国家级",@"58c7c6c24c1a3bea9c268d9e",@"省部级",@"58c7c6c24c1a3bea9c268d9f",@"区县级",@"58c7c6c24c1a3bea9c268da0",@"一般", nil];
    NSString* value=[parameters objectForKey:@"type"];
    [parameters setObject: [types objectForKey:value] forKey:@"type"];
    
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/project/save"];
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
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 7.5.3 项目删除
 请求 get http://116.228.176.34:9002/chuangke-serve/project/delete?id=597d6e1a80ab5e6790d52d29
 参数 id为项目id
 */
-(void) xiangMuDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?id=%@",baseurl,@"/project/delete",ids];
    
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
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 7.5.4 项目上传文件查询
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597d6d7b80ab5e6790d52d28&typeIndex=9
 参数为 项目id
 响应 [{"id":"597d6d7280ab5e6790d52d26","name"
 :"warn(1).jpg","path":"cash/busiplan/20170730/1501421042000.jpg","date":"2017-07-30"},{"id":"597d6d7480ab5e6790d52d27"
 ,"name":"warn.jpg","path":"cash/busiplan/20170730/1501421044000.jpg","date":"2017-07-30"}]
 */
-(void) xiangMuFileQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",@"9",@"typeIndex", nil];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*
 7.5.5 项目上传的文件删除
 请求 get  http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=9&entityId=597d6d7b80ab5e6790d52d28&id=597d6d7280ab5e6790d52d26
 参数 entityid为项目id，id为文件id
 */
-(void) xiangMuFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"9",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}






/*
 
 7.6.1 奖励管理查询
 请求 get http://116.228.176.34:9002/chuangke-serve/award/search?start=0&length=1000
 响应 [{"id":"5938e5ec075910c2d60d07e2","name"
 :"******","awardLevel":"一级奖励","awardunit":"******","code":"******","date":"2017-06-08 13:51:40","company"
 :"云创智能科技有限公司"}]
 */
-(void)jiangLiQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/award/search?start=0&length=1000"];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 7.6.2 奖励管理提交
 请求 post http://116.228.176.34:9002/chuangke-serve/award/save
 参数
 名称 name	羽毛球奖
 级别 awardLevel	58c7c7094c1a775d6de79f72
 单位 awardunit	体委
 编码 code	131231
 文件id  resourceIds	597d6fcb80ab5e6790d52d2a,597d6fcf80ab5e6790d52d2b
 <option value="58c7c7094c1a775d6de79f72">一级奖励</option>
 <option value="58c7c7094c1a775d6de79f73">二级奖励</option>
 <option value="58c7c7094c1a775d6de79f74">三级奖励</option>
 */
-(void)jiangLiSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* types=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c7094c1a775d6de79f72",@"一级奖励",@"58c7c7094c1a775d6de79f73",@"二级奖励",@"58c7c7094c1a775d6de79f74",@"三级奖励", nil];
    NSString* value=[parameters objectForKey:@"type"];
    [parameters setObject: [types objectForKey:value] forKey:@"type"];
    
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/award/save"];
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
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




/*
 7.6.3 奖励删除
 请求 get http://116.228.176.34:9002/chuangke-serve/award/delete?id=597d708280ab5e6790d52d2d
 参数 id为奖励id
 */
-(void)jiangLiDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?id=%@",baseurl,@"/award/delete",ids];
    
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
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 7.6.4 奖励上传的文件查询
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597d700b80ab5e6790d52d2c&typeIndex=10
 参数id为奖励id
 响应 为 [{"id":"597d6fcb80ab5e6790d52d2a","name"
 :"warn(1).jpg","path":"cash/busiplan/20170730/1501421643000.jpg","date":"2017-07-30"},{"id":"597d6fcf80ab5e6790d52d2b"
 ,"name":"warn.jpg","path":"cash/busiplan/20170730/1501421647000.jpg","date":"2017-07-30"}]
 */
-(void)jiangLiFileQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",@"10",@"typeIndex", nil];
    
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*
 7.6.5 奖励上传的文件删除
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=10&entityId=597d700b80ab5e6790d52d2c&id=597d6fcb80ab5e6790d52d2a
 参数 entityid为奖励id，id为文件id
 */

-(void) jiangLiFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"10",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}





@end
