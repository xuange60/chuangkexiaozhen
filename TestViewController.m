//
//  TestViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 17/7/26.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "TestViewController.h"
#import "BussinessApi.h"
//接口测试文件
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)login:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    // [bussiness loginWithName:@"gaogaihui" andPwd:@"123456"];
    //[bussiness loginWithName:@"zhangxuan" andPwd:@"111111"];
    [bussiness loginWithName:@"cash" andPwd:@"123456"];

}
- (IBAction)shitiruzhuquery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness shiTiRuZhuQuery];
}

//- (IBAction)shitiruzhufileup:(id)sender {
//    UIImage *image = [UIImage imageNamed:@"Snip20170722_1"];
//    NSData *data = UIImagePNGRepresentation(image);
//    BussinessApi* bussiness=[[BussinessApi alloc] init];
//    [bussiness shitiRuZhuFileup:data withType:@"png"];
//}
//- (IBAction)shitiruzhusubmit:(id)sender {
//    BussinessApi* bussiness=[[BussinessApi alloc] init];
//    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"电子信息",@"businessline",@"测试机构",@"companyname",@"小刚",@"contact",@"18576672852",@"contacttype",@"初创团队",@"description",@"597a200480ab5e6790d51fdd,597a213880ab5e6790d51fde",@"resourceids", nil];
//    [bussiness shiTiRuZhuSubmitWithParam:param];
//}


- (IBAction)xuniruzhusubmit:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"测试公司",@"branchname",@"小红",@"contact",@"18676672851",@"contacttype",@"展示推介机会,投融资需求,信息技术需求",@"coopcategories",@"备注备注备注备注",@"desc", nil];
    [bussiness xuniRuZhuSubmitWithParam:param];
}

- (IBAction)chushishenqingfilequery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chushishenqingFileQuery];
}

- (IBAction)shitiruzhufiledelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chushishenqingFileDelete:@"597a29e480ab5e6790d51fe3"];
}

- (IBAction)bisaiguanlifiledelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness biSaiGuanLiFileDelete:@"597c955280ab5e6790d528ba" withEntityId:@"597c955a80ab5e6790d528bb"];
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
