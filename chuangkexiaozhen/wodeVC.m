//
//  wodeVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/18.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "wodeVC.h"
#import "MyView.h"
@interface wodeVC ()

@end

@implementation wodeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary*dic=[defaults dictionaryForKey:@"chuangkexiaozhen.userinfo"];
   
    
//    Printing description of dic:
//    {
//        "_class" = "cn.shunlu.entity.user.User";
//        "_id" = 59390581075910c2d60d0801;
//        adminFlag = 1;
//        companyName = "\U65b0\U65f6\U4ee3";
//        companyType = "\U4e92\U8054\U7f51\U548c\U79fb\U52a8\U4e92\U8054\U7f51";
//        companydescription = "\U521d\U521b\U56e2\U961f";
//        companyid = 5937757d075910c2d60d07bd;
//        companytitle = "\U4e91\U521b\U667a\U80fd\U79d1\U6280\U6709\U9650\U516c\U53f8";
//        createDate = "2017-06-08T08:06:25.815Z";
//        delflag = 0;
//        department = "***";
//        email = "8912631@qq.com";
//        loginName = cash;
//        mobilePhone = 13901100000;
//        modifier = admin;
//        modifyDate = "2017-07-29T08:18:48.162Z";
//        name = "\U5c0f\U7070\U7070";
//        password = e96963b09d6b327224db64614dcde5b168ac3bc1;
//        phone = 13901100000;
//        plainPassword = 123456;
//        rank = "***11111";
//        remark = "";
    
    _userName.text=[dic objectNotNullForKey:@"loginName"];
    
     _mobile.text=[dic objectNotNullForKey:@"mobilePhone"];
    
     _email.text=[dic objectNotNullForKey:@"email"];
    
    _companyName.text=[dic objectNotNullForKey:@"companytitle"];
    
    _type.text=[dic objectNotNullForKey:@"companyType"];

}



- (IBAction)tuichuClick:(id)sender {
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController*vc=[board instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self presentViewController:vc animated:YES completion:nil];

    
}






@end
