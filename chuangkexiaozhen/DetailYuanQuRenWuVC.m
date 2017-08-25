//
//  DetailYuanQuRenWuVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "DetailYuanQuRenWuVC.h"

@interface DetailYuanQuRenWuVC ()

@end

@implementation DetailYuanQuRenWuVC
-(void)setStrId:(NSString *)strId dict:(NSDictionary*)dic
{
    _strID=strId;
    _dic=dic;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _name.text=[_dic  objectNotNullForKey:@"name"];
    _type.text=[_dic  objectNotNullForKey:@"category"];
    _chengdu.text=[_dic  objectNotNullForKey:@"level"];
    NSArray*ary= [_dic  objectForKey:@"userNames"];
    _person.text=[ary componentsJoinedByString:@","];
    _content.text=[_dic  objectNotNullForKey:@"content"];
    _time.text=[_dic  objectNotNullForKey:@"endDate"];

}
















@end
