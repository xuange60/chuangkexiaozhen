//
//  TuanDuiYunYing.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "TuanDuiYunYing.h"

@implementation TuanDuiYunYing

-(void)queryData:(NSString*)type
{
    NSString* str=@"";
    if([type isEqualToString:@"高学历人才"]){
        str=@"highlyeducated";
    }else if([type isEqualToString:@"高技能人才"]){
        str=@"highskill";
    }else if([type isEqualToString:@"规划目标"]){
        str=@"companygoal";
    }else if([type isEqualToString:@"规模制度"]){
        str=@"comsummatebylaws";
    }else if([type isEqualToString:@"投融资情况"]){
        str=@"investmentandfinancing";
    }else if([type isEqualToString:@"社保缴纳"]){
        str=@"companyresource";
    }else if([type isEqualToString:@"社会责任履行"]){
        str=@"socialresponsibility";
    }else if([type isEqualToString:@"税务正规化"]){
        str=@"taxnormalization";
    }else if([type isEqualToString:@"员工福利"]){
        str=@"benefit";
    }
    [super querylistWithRole:@"ck" andRelativeUrl:[NSString stringWithFormat:@"/%@/search",str]];
}


-(void)queryDataAdmin:(NSString*)type
{
    NSString* str=@"";
    if([type isEqualToString:@"高学历人才"]){
        str=@"highlyeducated";
    }else if([type isEqualToString:@"高技能人才"]){
        str=@"highskill";
    }else if([type isEqualToString:@"规划目标"]){
        str=@"companygoal";
    }else if([type isEqualToString:@"规模制度"]){
        str=@"comsummatebylaws";
    }else if([type isEqualToString:@"投融资情况"]){
        str=@"investmentandfinancing";
    }else if([type isEqualToString:@"社保缴纳"]){
        str=@"companyresource";
    }else if([type isEqualToString:@"社会责任履行"]){
        str=@"socialresponsibility";
    }else if([type isEqualToString:@"税务正规化"]){
        str=@"taxnormalization";
    }else if([type isEqualToString:@"员工福利"]){
        str=@"benefit";
    }
    [super querylistWithRole:@"admin" andRelativeUrl:[NSString stringWithFormat:@"/%@/search",str]];
}

-(void)queryParam:(NSString*)type
{
    NSString* str=@"";
    if([type isEqualToString:@"高学历人才"]){
        str=@"highlyeducated";
    }else if([type isEqualToString:@"高技能人才"]){
        str=@"highskill";
    }else if([type isEqualToString:@"规划目标"]){
        str=@"companygoal";
    }else if([type isEqualToString:@"规模制度"]){
        str=@"comsummatebylaws";
    }else if([type isEqualToString:@"投融资情况"]){
        str=@"investmentandfinancing";
    }else if([type isEqualToString:@"社保缴纳"]){
        str=@"companyresource";
    }else if([type isEqualToString:@"社会责任履行"]){
        str=@"socialresponsibility";
    }else if([type isEqualToString:@"税务正规化"]){
        str=@"taxnormalization";
    }else if([type isEqualToString:@"员工福利"]){
        str=@"benefit";
    }
    [super queryParamMapwithRelativeUrl:[NSString stringWithFormat:@"/%@/add",str]];
}

-(void)addData:(NSDictionary*)param withType:(NSString*)type
{
    NSString* str=@"";
    if([type isEqualToString:@"高学历人才"]){
        str=@"highlyeducated";
    }else if([type isEqualToString:@"高技能人才"]){
        str=@"highskill";
    }else if([type isEqualToString:@"规划目标"]){
        str=@"companygoal";
    }else if([type isEqualToString:@"规模制度"]){
        str=@"comsummatebylaws";
    }else if([type isEqualToString:@"投融资情况"]){
        str=@"investmentandfinancing";
        [self addTouRongZiData:param];
        return;
    }else if([type isEqualToString:@"社保缴纳"]){
        str=@"companyresource";
    }else if([type isEqualToString:@"社会责任履行"]){
        str=@"socialresponsibility";
    }else if([type isEqualToString:@"税务正规化"]){
        str=@"taxnormalization";
    }else if([type isEqualToString:@"员工福利"]){
        str=@"benefit";
    }
    [super addWithData:param andRelativeUrl:[NSString stringWithFormat:@"/%@/save",str]];
}

-(void)addTouRongZiData:(NSDictionary*)param
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/investmentandfinancing/save"];
    
    NSString* investmentAmount=[param objectNotNullForKey:@"investmentAmount"];
    NSString* investmentWheel=[param objectNotNullForKey:@"investmentWheel"];
    NSString* resourceIds=[param objectNotNullForKey:@"resourceIds"];
    
    NSMutableString* investmentInstitutionsstr=[NSMutableString string];
    NSArray* ary1=(NSArray*)[param objectForKey:@"investmentInstitutions"];
    if([ary1 count]>0){
        investmentInstitutionsstr=[NSMutableString stringWithString:@"&"];
        for (int i=0; i<[ary1 count]; i++) {
            NSString* data=[ary1 objectAtIndex:i];
            [investmentInstitutionsstr appendFormat:@"investmentInstitutions=%@",data];
            if(i<([ary1 count]-1)){
                [investmentInstitutionsstr appendString:@"&"];
            }
        }
    }
    
    
    
    
    NSString* post=[NSString stringWithFormat:@"investmentAmount=%@&investmentWheel=%@%@&resourceIds=%@",investmentAmount,investmentWheel,investmentInstitutionsstr,resourceIds];
    
    
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

-(void)deleteData:(NSString*)ids withType:(NSString*)type
{
    NSString* str=@"";
    if([type isEqualToString:@"高学历人才"]){
        str=@"highlyeducated";
    }else if([type isEqualToString:@"高技能人才"]){
        str=@"highskill";
    }else if([type isEqualToString:@"规划目标"]){
        str=@"companygoal";
    }else if([type isEqualToString:@"规模制度"]){
        str=@"comsummatebylaws";
    }else if([type isEqualToString:@"投融资情况"]){
        str=@"investmentandfinancing";
    }else if([type isEqualToString:@"社保缴纳"]){
        str=@"companyresource";
    }else if([type isEqualToString:@"社会责任履行"]){
        str=@"socialresponsibility";
    }else if([type isEqualToString:@"税务正规化"]){
        str=@"taxnormalization";
    }else if([type isEqualToString:@"员工福利"]){
        str=@"benefit";
    }
    [super deleteWithId:ids andRelativeUrl:[NSString stringWithFormat:@"/%@/batchdelete",str]];
}



//查询记录详情
-(void)queryDetail:(NSString*)ids withType:(NSString*)type
{
    NSString* str=@"";
    if([type isEqualToString:@"高学历人才"]){
        str=@"highlyeducated";
    }else if([type isEqualToString:@"高技能人才"]){
        str=@"highskill";
    }else if([type isEqualToString:@"规划目标"]){
        str=@"companygoal";
    }else if([type isEqualToString:@"规模制度"]){
        str=@"comsummatebylaws";
    }else if([type isEqualToString:@"投融资情况"]){
        str=@"investmentandfinancing";
    }else if([type isEqualToString:@"社保缴纳"]){
        str=@"companyresource";
    }else if([type isEqualToString:@"社会责任履行"]){
        str=@"socialresponsibility";
    }else if([type isEqualToString:@"税务正规化"]){
        str=@"taxnormalization";
    }else if([type isEqualToString:@"员工福利"]){
        str=@"benefit";
    }
    [super queryDetailWithId:ids andRelativeUrl:[NSString stringWithFormat:@"/%@/detail",str]];

}


//审批记录
-(void)shenpiData:(NSDictionary*)param withType:(NSString*)type
{
    NSString* str=@"";
    if([type isEqualToString:@"高学历人才"]){
        str=@"highlyeducated";
    }else if([type isEqualToString:@"高技能人才"]){
        str=@"highskill";
    }else if([type isEqualToString:@"规划目标"]){
        str=@"companygoal";
    }else if([type isEqualToString:@"规模制度"]){
        str=@"comsummatebylaws";
    }else if([type isEqualToString:@"投融资情况"]){
        str=@"investmentandfinancing";
    }else if([type isEqualToString:@"社保缴纳"]){
        str=@"companyresource";
    }else if([type isEqualToString:@"社会责任履行"]){
        str=@"socialresponsibility";
    }else if([type isEqualToString:@"税务正规化"]){
        str=@"taxnormalization";
    }else if([type isEqualToString:@"员工福利"]){
        str=@"benefit";
    }
    [super updateWithData:param andRelativeUrl:[NSString stringWithFormat:@"/%@/status",str]];
}

@end
