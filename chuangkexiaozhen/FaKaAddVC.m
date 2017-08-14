//
//  FaKaAddVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "FaKaAddVC.h"

@interface FaKaAddVC ()

@end

@implementation FaKaAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"发卡";
    _fakaguanli=[[FaKaGuanli alloc] init];
    _fakaguanli.delegate=self;
    [self queryParam];
    // Do any additional setup after loading the view.
}

-(void)queryParam
{
    [_fakaguanli FaKaParamMapQuery];
}

-(void) afternetwork6:(id)data
{
    _tenanids=[(NSDictionary*)data objectForKey:@"tenantId"];
    NSLog(@"%@",_tenanids);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)teamclick:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"ZiYuanPeiZhi" bundle:nil];
    DuoXuanVC* add=[storyboard instantiateViewControllerWithIdentifier:@"DuoXuanVC"];
    NSArray* keys=[_tenanids allKeys];
    [add setArray:keys btn:sender];
    [add setNavTitle:@"选择企业团队"];
 //   [add setDanXuan];
 //   [add setSelectedData:[NSMutableArray arrayWithObjects:@"上海天启科技有限公司", nil]];设置默认单选
    [add setSelectedData:[NSMutableArray arrayWithObjects:@"上海天启科技有限公司",@"上海猎天信息技术有限公司",@"xxx", nil]];
    [self.navigationController pushViewController:add animated:YES];
}



- (IBAction)nameclick:(id)sender {
}


- (IBAction)add:(id)sender {
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
