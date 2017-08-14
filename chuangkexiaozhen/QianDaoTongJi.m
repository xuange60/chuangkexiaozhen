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
    [super queryParamMapwithRelativeUrl:@"/sign/add"];
}


/**
 5.添加签到统计数据
 http://116.228.176.34:9002/chuangke-serve/sign/save
 参数： 注意单选路演活动后，需要先进行参数转换
 实到人数 actualNum 30
 文档id otherResourceIds 5991d4e0a92b0b6e2c92dfdd
 出席率 percent 75.00%
 备注 remark xxx
 路演活动 roadshows 593620bc075910c2d60d079a
 应到人数 shouldNum 40
 签到文档 signResourceIds 5991d4d8a92b0b6e2c92dfdc
 */
-(void)QianDaoTongJiAdd:(NSDictionary*) dic
{
    [super addWithData:dic andRelativeUrl:@"/sign/save"];
}

@end
