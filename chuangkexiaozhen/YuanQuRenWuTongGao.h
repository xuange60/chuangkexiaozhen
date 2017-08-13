//
//  YuanQuRenWuTongGao.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/13.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommNetWork.h"
@interface YuanQuRenWuTongGao :  CommNetWork


//查询所有任务通告
-(void)YuanQuRenWuQuery;

//删除某条任务通告
-(void)YuanQuRenWuDelete:(NSString*)ids;

//完成某条任务通告
-(void)YuanQuRenWuSucc:(NSString*)ids;

//添加任务通告前，查询到任务通告参数
/*
 users =     {
 "" = 596ffd0480ab5e6790d501a2;
 ceshi = 5981e17b80ab5e6790d53b59;
 ceshi121 = 598356e380ab5e6790d5401e;
 ceshi201701a = 59849a3280ab5e6790d54495;
 ceshigongsi = 598495bc80ab5e6790d54493;
 }
 */
-(void)YuanQuRenWuParamQuery;

/*
 添加任务通告
 参数：
 通告类型 category 整理内务
 通告内容 content xxxx
 截止时间 enddate 2017-08-14 14:38:31
 file
 紧急程度 levels 紧急
 通告主题 name ceshi
 文件id resourceIds 598ff39922637b17beb31415
 涉及人员 users 597d807680ab5e6790d52d45 users 597db39c80ab5e6790d52d6a
 workId
 */
-(void)YuanQuRenWuAdd:(NSDictionary*)param;



//任务通告详情查询
-(void)YuanQuRenWuDetail:(NSString*)ids;


@end
