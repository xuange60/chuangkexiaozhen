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
    
    _name.text=_dic[@"name"];
    _type.text=_dic[@"category"];
    _chengdu.text=_dic[@"level"];
    NSArray*ary= _dic[@"userNames"];
    _person.text=[ary componentsJoinedByString:@","];
    _content.text=_dic[@"content"];
    _time.text=_dic[@"endDate"];

}
















@end
