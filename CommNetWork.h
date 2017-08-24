//
//  CommNetWork.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/13.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"
@interface CommNetWork : NSObject

@property(nonatomic,assign)id <BussinessApiDelegate> delegate;


//通用查询 多条记录查询
-(void) queryWithParam:(NSString*)param RelativeUrl:(NSString*) relativeurl;

//删除某条记录
-(void) deleteWithParam:(NSString*)str andRelativeUrl:(NSString*) relativeurl;

//审批通过 或 完成操作
-(void) succWithParam:(NSString*)str andRelativeUrl:(NSString*) relativeurl;



//role为用户种类 relativeurl为相对url 查询所有记录
-(void) querylistWithRole:(NSString*)role andRelativeUrl:(NSString*) relativeurl;

//查询某条记录详情
-(void) queryDetailWithId:(NSString*)ids andRelativeUrl:(NSString*) relativeurl;




//删除某条记录
-(void) deleteWithId:(NSString*)ids andRelativeUrl:(NSString*) relativeurl;




//审批通过 或 完成操作
-(void) succWithId:(NSString*)ids andRelativeUrl:(NSString*) relativeurl;




//提交操作
-(void) addWithData:(NSDictionary*)param andRelativeUrl:(NSString*) relativeurl;

//提交操作，自动转换参数  先查询所有参数，再将请求中的参数进行转换
//-(void) addWithData:(NSDictionary*)param andParamMap:(NSDictionary*)parammap andRelativeUrl:(NSString*) relativeurl;


//查询参数映射
-(void) queryParamMapWithId:(NSString*)ids andRelativeUrl:(NSString*) relativeurl;

//查询参数映射
-(void) queryParamMapwithRelativeUrl:(NSString*) relativeurl;


//修改操作
-(void) updateWithData:(NSDictionary*)param andRelativeUrl:(NSString*) relativeurl;

//获取用户信息
-(void)getUserinfo:(NSString *)name;

//查询主动退出
-(void)getActiveQuit:(NSString *)ids;


//查询被动退出
-(void)getUnActiveQuit:(NSString *)ids;

//获取url地址
-(void)getBaseUrl;

//查询所有公司
-(void)getAllCompany;

@end
