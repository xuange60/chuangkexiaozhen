//
//  ShenSuShenQingGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/10.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"
#import "CommNetWork.h"
@interface ShenSuShenQingGuanLi : CommNetWork

//@property(nonatomic,assign)id <BussinessApiDelegate> delegate;







/*
 2.12.1 申诉申请查询
 http://116.228.176.34:9002/chuangke-serve/stateapply/search?start=0&length=10000
 [{"id":"597f525580ab5e6790d53202","stateType"
 :"周边环境嘈杂","stateContent":"12321","stateReason":"12321321","createDate":"2017-07-31","status":"已处理","tenantTitle"
 :"测试公司zhangxuan3"},{"id":"597f523680ab5e6790d53201","stateType":"周边推销骚扰","stateContent":"23121","stateReason"
 :"2312231","createDate":"2017-07-31","status":"未处理","tenantTitle":"测试公司zhangxuan3"},{"id":"597f521080ab5e6790d531ff"
 ,"stateType":"申诉类型","stateContent":"Ceshi1\t","stateReason":"Ceshiashi1","createDate":"2017-07-31","status"
 :"未处理","tenantTitle":"测试公司zhangxuan3"}
 
 查询到请求状态为未处理的，可以 删除、查看详情、受理
 */

-(void)ShenSuShenQingQuery;


/*
 2.12.2 申诉申请删除
 http://116.228.176.34:9002/chuangke-serve/stateapply/delete?id=597e148080ab5e6790d52d85
 */
-(void)ShenSuShenQingDelete:(NSString*)ids;



/*
 2.12.3 申诉申请受理
 http://116.228.176.34:9002/chuangke-serve/stateapply/batchsuccess?ids=597f525580ab5e6790d53202
 */
-(void)ShenSuShenQingSucc:(NSString*)ids;















@end
