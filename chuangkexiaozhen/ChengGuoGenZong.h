//
//  ChengGuoGenZong.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CommNetWork.h"

@interface ChengGuoGenZong : CommNetWork


/*
 2.19.1 成果跟踪查询
 http://116.228.176.34:9002/chuangke-serve/report/search?start=0&length=1000
 */

-(void)ChengGuoGenZongQuery;

/*
 2.19.2 成果跟踪参数查询
 http://116.228.176.34:9002/chuangke-serve/report/add
 */
-(void)ChengGuoGenZongParamQuery;

/*
 2.19.3 成果跟踪提交
 http://116.228.176.34:9002/chuangke-serve/report/save
 name	1111
 resourceIds
 roadshows	58e7554611c7b2939aa7a0f9
 */
-(void)ChengGuoGenZongAdd:(NSDictionary*)param;

/*
 2.19.4 相关文档下载
 typeIndex	4
 */

/*
 2.19.5 成果删除
 http://116.228.176.34:9002/chuangke-serve/report/batchdelete?ids=594a0d29075910c2d60d08c9
 */
-(void)ChengGuoGenZongDelete:(NSString*)ids;


@end
