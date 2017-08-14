//
//  QianDaoTongJi.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/15.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "QianDaoTongJi.h"

@implementation QianDaoTongJi


/**
 1.查询签到统计列表
 http://116.228.176.34:9002/chuangke-serve/sign/search
 
 响应：
 [{"id":"5949ec5f075910c2d60d08c7","actualNum"
 :30,"shouldNum":40,"percent":"75.00%","remark":"","roadshowName":"123"}]
 
 路演活动：roadshowName
 实到人数: actualNum
 应到人数 shouldNum
 出勤率 percent
 备注 remark
 */
-(void)QianDaoTongJiQuery
{
    [super querylistWithRole:@"" andRelativeUrl:@"/sign/search"];
}




/**
 2.签到统计删除
 http://116.228.176.34:9002/chuangke-serve/sign/batchdelete?ids=5949ec5f075910c2d60d08c7
 参数：记录id
 */
-(void)QianDaoTongJiDelete:(NSString*)ids
{
    [super deleteWithId:ids andRelativeUrl:@"/sign/batchdelete"];
}




/**
 4.签到统计前查询所有的活动路演参数 在单选列表中使用
 */
-(void)QianDaoTongJiQueryParam
{
    [self queryParamMapwithRelativeUrl:@"/sign/add"];
}

@end
