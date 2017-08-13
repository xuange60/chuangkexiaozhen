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


//role为用户种类 relativeurl为相对url
-(void) querylistWithRole:(NSString*)role andRelativeUrl:(NSString*) relativeurl;

//查询某条记录详情
-(void) queryDetailWithId:(NSString*)ids andRelativeUrl:(NSString*) relativeurl;


-(void) deleteWithId:(NSString*)ids andRelativeUrl:(NSString*) relativeurl;

-(void) succWithId:(NSString*)ids andRelativeUrl:(NSString*) relativeurl;

-(void) addWithData:(NSDictionary*)param andRelativeUrl:(NSString*) relativeurl;

@end
