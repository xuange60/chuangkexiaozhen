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


- (IBAction)chanxueyanquery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chanXueYanQuery];
}

- (IBAction)chanxueyansubmit:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"设计大赛2",@"name",@"100万元",@"moneyLevel",@"1000000",@"money",@"合作机构一级",@"level",@"合作愉快",@"effect",@"",@"resourceIds", nil];
    [bussiness chanXueYanSubmit:param];
}

- (IBAction)chanxueyandelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chanXueYanDelete:@"597d4c2f80ab5e6790d52d17"];
}
- (IBAction)chanxueyanfilequery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chanXueYanQueryFile:@"597cc95080ab5e6790d528c3"];
}

- (IBAction)chanxueyanfiledelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chanXueYanDelete:@"597cc90c80ab5e6790d528c2" withEntityId:@"597cc95080ab5e6790d528c3"];
}


- (IBAction)huodongquery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness huoDongQuery];
}

- (IBAction)huodongsubmit:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"省市级活动",@"activityLevel",@"唱歌比赛",@"name",@"2",@"participant",@"深圳市政府",@"sponsor",@"",@"resourceIds", nil];
    [bussiness huoDongSubmit:param];
}

- (IBAction)huodongdelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness huoDongDelete:@"597d505080ab5e6790d52d1a"];
}


- (IBAction)huodongfilequery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness huoDongQueryFile:@"597d5ead80ab5e6790d52d1f"];
}

- (IBAction)huodongfiledelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness huoDongDelete:@"597d5e9e80ab5e6790d52d1d" withEntityId:@"597d5ead80ab5e6790d52d1f"];
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
