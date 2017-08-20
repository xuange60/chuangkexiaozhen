//
//  BeiDongTuiChu.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CommNetWork.h"

@interface BeiDongTuiChu : CommNetWork


-(void)BeiDongTuiChuQuery;


-(void)BeiDongTuiChuParamQuery;


-(void)BeiDongTuiChuAdd:(NSDictionary*)param;

-(void)BeiDongTuiChuSucc:(NSString*)ids;

-(void)BeiDongTuiChuNo:(NSString*)ids;

-(void)BeiDongTuiChuDelete:(NSString*)ids;







@end
