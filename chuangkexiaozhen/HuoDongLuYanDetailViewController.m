//
//  HuoDongLuYanDetailViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/6.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "HuoDongLuYanDetailViewController.h"

@interface HuoDongLuYanDetailViewController ()

@end

@implementation HuoDongLuYanDetailViewController

- (void)viewDidLoad {
    _huodong=[[HuoDong alloc] init];
    _huodong.delegate=self;
    [super viewDidLoad];
    [self query];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)query
{
    [_huodong HuoDongLuYanDetailQuery:self.huodongid];
}


- (void)loadNetworkFinished:(id)data
{
    NSDictionary* result=(NSDictionary*)data;
    self.name.text=[result objectNotNullForKey:@"name"];
    self.address.text=[result objectNotNullForKey:@"address"];
    self.time.text=[result objectNotNullForKey:@"time"];
    self.organizationList.text=[result objectNotNullForKey:@"organizationList"];
    self.content.text=[result objectNotNullForKey:@"content"];
    self.url.text=[result objectNotNullForKey:@"url"];
    NSArray* notices=[result objectForKey:@"noticeList"];
    NSMutableString * noticestr=[NSMutableString string];
    if(notices!=nil && [notices count]>0){
        for (NSString* str in notices) {
            [noticestr appendString:@" "];
            [noticestr appendString:str];
        }
    }
    self.noticeList.text=[NSString stringWithString:noticestr];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
