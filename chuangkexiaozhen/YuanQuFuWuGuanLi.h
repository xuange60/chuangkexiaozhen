//
//  YuanQuFuWuGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/13.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"
@interface YuanQuFuWuGuanLi :  NSObject

@property(nonatomic,assign)id <BussinessApiDelegate> delegate;


/*
 7.3.1 园区服务申请查询 --管理员查询
 */
-(void)YuanQuFuWuQuerywithAdmin;


/*
 8.3 园区服务申请受理 管理员处理  当申请状态为未处理时，可以点击受理  申请状态为通过时，不现实受理按钮；
 http://116.228.176.34:9002/chuangke-serve/serveapply/batchsuccess?ids=598fe53722637b17beb31414
 参数 id为服务申请记录id
 */

-(void)YuanQuFuWuSucc:(NSString*)ids;


@end
