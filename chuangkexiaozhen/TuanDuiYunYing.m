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

@end
