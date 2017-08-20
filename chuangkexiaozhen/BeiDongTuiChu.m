//
//  BeiDongTuiChu.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BeiDongTuiChu.h"

@implementation BeiDongTuiChu



-(void)BeiDongTuiChuQuery
{
   [super queryWithParam:@"quitProperty=unactive" RelativeUrl:@"/quit/search"];
}


-(void)BeiDongTuiChuParamQuery
{
    [super getAllCompany];
}

/*
 quitCause 111
 quitDateStr 2017-08-17
 quitProperty unactive
 quitType 局部
 resourceIds 59996938a92b0b6e2c92fb6f
 tenants 598b3ad522637b17beb3016f
 */
-(void)BeiDongTuiChuAdd:(NSDictionary*)param
{
    [super addWithData:param andRelativeUrl:@"/quit/save"];
}

-(void)BeiDongTuiChuSucc:(NSString*)ids
{
    NSString* str=[NSString stringWithFormat:@"ifagree=1&applyId=%@",ids];
    [super succWithParam:str andRelativeUrl:@"/quit/ifagree"];
}

-(void)BeiDongTuiChuNo:(NSString*)ids
{
    NSString* str=[NSString stringWithFormat:@"ifagree=2&applyId=%@",ids];
    [super succWithParam:str andRelativeUrl:@"/quit/ifagree"];
}

-(void)BeiDongTuiChuDelete:(NSString*)ids
{
    [super deleteWithId:ids andRelativeUrl:@"/quit/batchdelete"];
}


@end
