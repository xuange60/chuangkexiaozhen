//
//  ZhuDongTuiChu.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ZhuDongTuiChu.h"

@implementation ZhuDongTuiChu
/*
 2.17.1 主动性退出查询
 http://116.228.176.34:9002/chuangke-serve/quit/search?quitProperty=active&start=0&length=1000
 [{"id":"5983584f80ab5e6790d54020","quitCompany"
 :"测试机构4","quitCause":"11","quitDate":"2017-08-09","quitType":"局部","releaseResource":null,"status":"未
 处理"},{"id":"598354b880ab5e6790d5401d","quitCompany":"ceshi","quitCause":"1111","quitDate":null,"quitType"
 :"局部","releaseResource":null,"status":"未处理"},{"id":"596b921280ab5e6790d4f06c","quitCompany":"测试公司3","quitCause"
 :"退出","quitDate":null,"quitType":"整体","releaseResource":null,"status":"通过"}]
 
 
 2.17.2 主动性退出删除
 http://116.228.176.34:9002/chuangke-serve/quit/batchdelete?ids=594a6269075910c2d60d08d1
 
 2.17.3 主动性退出同意
 http://116.228.176.34:9002/chuangke-serve/quit/ifagree?ifagree=1&applyId=598354b880ab5e6790d5401d
 
 2.17.4 主动性退出拒绝
 http://116.228.176.34:9002/chuangke-serve/quit/ifagree?ifagree=2&applyId=5983584f80ab5e6790d54020
 
 
 2.17.5 主动性退出提交
 http://116.228.176.34:9002/chuangke-serve/quit/save
 quitCause	tuichuceshi
 quitDateStr	2017年8月16日
 quitProperty	active
 quitType	整体
 resourceIds	599464eaa92b0b6e2c92e91e
 tenants	597d7aba80ab5e6790d52d37
 
 
 2.17.6 主动性退出资源下载
 typeIndex	36
 
 ceshigaidong
 
 */
-(void) ZhuDongTuiChuQuery
{
    [super queryWithParam:@"quitProperty=active" RelativeUrl:@"/quit/search"];
}

-(void)ZhuDongTuiChuDelete:(NSString*)ids
{
    [super deleteWithId:ids andRelativeUrl:@"/quit/batchdelete"];
}

-(void)ZhuDongTuiChuSucc:(NSString*)ids
{
    NSString* str=[NSString stringWithFormat:@"ifagree=1&applyId=%@",ids];
    [super succWithParam:str andRelativeUrl:@"/quit/ifagree"];
}


-(void)ZhuDongTuiChuNo:(NSString*)ids
{
     NSString* str=[NSString stringWithFormat:@"ifagree=2&applyId=%@",ids];
    [super succWithParam:str andRelativeUrl:@"/quit/ifagree"];
}

-(void)ZhuDongTuiChuAdd:(NSDictionary*)param
{
    [super addWithData:param andRelativeUrl:@"/quit/save"];
}





@end
