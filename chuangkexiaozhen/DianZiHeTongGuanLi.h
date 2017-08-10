//
//  DianZiHeTongGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/10.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"

@interface DianZiHeTongGuanLi : NSObject

@property(nonatomic,assign)id <BussinessApiDelegate> delegate;

/*
 2.9.1 电子合同管理查询
 http://116.228.176.34:9002/chuangke-serve/electroniccontract/search?start=0&length=10
 [{"id":"5988838922637b17beb2f879","creator"
 :"cash","tenantTitle":"云创智能科技有限公司","createDate":"2017-08-07"},{"id":"5980815d80ab5e6790d536cb","creator"
 :"cash","tenantTitle":"云创智能科技有限公司","createDate":"2017-08-01"},{"id":"597fd8c780ab5e6790d53694","creator"
 :"cash","tenantTitle":"云创智能科技有限公司","createDate":"2017-08-01"}]
 */
-(void)DianZiHeTongQuery;

/*
 2.9.2 电子合同文档查询及下载
 http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=5988838922637b17beb2f879&typeIndex=29&start=0&length=10000
 参数 typeIndex=29
 */



@end
