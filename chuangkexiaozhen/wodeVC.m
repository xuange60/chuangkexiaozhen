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

    
    _userName.text=[dic objectNotNullForKey:@"loginName"];
    
     _mobile.text=[dic objectNotNullForKey:@"mobilePhone"];
    
     _email.text=[dic objectNotNullForKey:@"email"];
    
    _companyName.text=[dic objectNotNullForKey:@"companytitle"];
    
    _type.text=[dic objectNotNullForKey:@"companyType"];

}



- (IBAction)tuichuClick:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"chuangkexiaozhen.userinfo"];
    [defaults setObject:nil forKey:@"chuangkexiaozhen.cookie"];
    [defaults setObject:nil forKey:@"chuangkexiaozhen.zhujiemian"];
    [defaults setObject:nil forKey:@"chuangkexiaozhen.login"];
    [defaults synchronize];
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController*vc=[board instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self presentViewController:vc animated:YES completion:nil];

    
}








@end
