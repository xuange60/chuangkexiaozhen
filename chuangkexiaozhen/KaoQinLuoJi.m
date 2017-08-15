//
//  KaoQinLuoJi.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "KaoQinLuoJi.h"

@implementation KaoQinLuoJi


-(void) KaoQinLuoJiQuery
{
    [super querylistWithRole:@"" andRelativeUrl:@"/attendancelogic/search"];
}

-(void) KaiQinLuoJiParamQuery
{
    [super queryParamMapwithRelativeUrl:@"/attendancelogic/add"];
}

-(void) KaoQinLuoJiAdd:(NSDictionary*)param
{
    [super addWithData:param andRelativeUrl:@"/attendancelogic/save"];
}

-(void)KaoQinLuoJiDelete:(NSString*)ids
{
    [super deleteWithId:ids andRelativeUrl:@"/attendancelogic/batchdelete"];
}

-(void)KaoQinLuoJiModify:(NSDictionary*)param
{
    [super addWithData:param andRelativeUrl:@"/attendancelogic/update"];
}







@end
