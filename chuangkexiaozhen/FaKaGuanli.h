//
//  FaKaGuanli.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommNetWork.h"
@interface FaKaGuanli : CommNetWork

-(void)FaKaQuery;

-(void)FaKaDelete:(NSString*)ids;

-(void)FaKaParamMapQuery;

-(void)FaKaAdd:(NSDictionary*)param;


@end
