//
//  TuanDuiYunYing.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CommNetWork.h"

@interface TuanDuiYunYing : CommNetWork


-(void)queryData:(NSString*)type;

-(void)queryDataAdmin:(NSString*)type;

-(void)queryParam:(NSString*)type;

-(void)addData:(NSDictionary*)param withType:(NSString*)type;

-(void)deleteData:(NSString*)ids withType:(NSString*)type;



@end
