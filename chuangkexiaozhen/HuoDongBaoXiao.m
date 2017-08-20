//
//  HuoDongBaoXiao.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "HuoDongBaoXiao.h"

@implementation HuoDongBaoXiao






/*
 2.18.1 报销申请管理查询
 http://116.228.176.34:9002/chuangke-serve/expense/search?start=0&length=1000
 
 [{"id":"596b82d180ab5e6790d4f05b","totalPrice"
 :100.0,"approver":"王俊","proposer":"王俊","agree":"未同意","category":"餐饮","remark":null,"roadshowName":"123"
 ,"content":"餐饮"},{"id":"5949f1c9075910c2d60d08c8","totalPrice":10000.0,"approver":"王俊","proposer":null
 ,"agree":"未同意","category":"餐饮","remark":null,"roadshowName":"123","content":"***\r\n***\r\n***"}]
 */
-(void)HuoDongBaoXiaoQuery
{
    [super querylistWithRole:@"" andRelativeUrl:@"/expense/search"];
}



/*
 2.18.2 活动报销前查询所有活动，查询审批人，查询申请人
 http://116.228.176.34:9002/chuangke-serve/expense/add
 */
-(void)HuoDongBaoXiaoParamQuery
{
    [super queryParamMapwithRelativeUrl:@"/expense/add"];
}




/*
 2.18.3 活动报销添加
 http://116.228.176.34:9002/chuangke-serve/expense/save
 审批人 approver	58e5c52c19eb26b288dc9753
 种类 category	住宿
 内容 content	2222
 申请人 proposer	5875a60bee19799d1cc83824
 resourceIds
 活动种类 roadshows	58e7555e11c7b2939aa7a0fa
 金额 totalPrice	300
 */
-(void)HuoDongBaoXiaoAdd:(NSDictionary*)param
{
    [super addWithData:param andRelativeUrl:@"/expense/save"];
}


/*
 2.18.4 查询可下载的文件
 typeIndex	3
 */

// 2.18.5 审批同意  http://116.228.176.34:9002/chuangke-serve/expense/batchagree?ids=599952d3a92b0b6e2c92fb6b
-(void)HuoDongBaoXiaoSucc:(NSString*)ids
{
    [super succWithId:ids andRelativeUrl:@"/expense/batchagree"];
}


// 2.18.6 删除申请  http://116.228.176.34:9002/chuangke-serve/expense/batchdelete?ids=599952d3a92b0b6e2c92fb6b
-(void)HuoDongBaoXiaoDelete:(NSString*)ids
{
    [super deleteWithId:ids andRelativeUrl:@"/expense/batchdelete"];
}



@end
