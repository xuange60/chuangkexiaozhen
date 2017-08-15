//
//  KaoQinLuoJi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CommNetWork.h"

@interface KaoQinLuoJi : CommNetWork

-(void) KaoQinLuoJiQuery;

-(void) KaiQinLuoJiParamQuery;

-(void) KaoQinLuoJiAdd:(NSDictionary*)param;

-(void)KaoQinLuoJiDelete:(NSString*)ids;

-(void)KaoQinLuoJiModify:(NSDictionary*)param;


@end
