//
//  TuanDuiYunYing.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CommNetWork.h"

@interface TuanDuiYunYing : CommNetWork

//查询所有数据
-(void)queryData:(NSString*)type;

//管理员查询所有数据
-(void)queryDataAdmin:(NSString*)type;

//添加前查询参数
-(void)queryParam:(NSString*)type;

//添加数据
-(void)addData:(NSDictionary*)param withType:(NSString*)type;

//删除数据
-(void)deleteData:(NSString*)ids withType:(NSString*)type;

//查询记录详情
-(void)queryDetail:(NSString*)ids withType:(NSString*)type;

//审批记录
-(void)shenpiData:(NSDictionary*)param withType:(NSString*)type;
@end
