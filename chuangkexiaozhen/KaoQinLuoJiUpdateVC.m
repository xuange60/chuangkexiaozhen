//
//  KaoQinLuoJiUpdateVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "KaoQinLuoJiUpdateVC.h"

@interface KaoQinLuoJiUpdateVC ()

@end

@implementation KaoQinLuoJiUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _kaoqinluoji=[[KaoQinLuoJi alloc] init];
    _kaoqinluoji.delegate=self;
    self.navigationItem.title=@"添加考勤逻辑";
    
    if(_isModify!=nil && [_isModify isEqualToString:@"Y"]){
        self.navigationItem.title=@"修改考勤逻辑";
        [_company setTitle:[_curdata objectNotNullForKey:@"companyName"] forState:UIControlStateNormal];
        NSString* start=[_curdata objectNotNullForKey:@"startTime"];
        if([start length]>5){
            start=[start substringToIndex:5];
        }
        _starttime.text=start;
        NSString* end=[_curdata objectNotNullForKey:@"endTime"];
        if([end length]>5){
            end=[end substringToIndex:5];
        }
        _endtime.text=end;
    }
    
    if(_tenantids==nil){
        _tenantids=[NSDictionary dictionary];
    }
    [_kaoqinluoji KaiQinLuoJiParamQuery];

    // Do any additional setup after loading the view.
}


-(void) afternetwork6:(id)data
{
    _tenantids=[(NSDictionary*)data objectForKey:@"tenantId"];
    if(_tenantids==nil){
        _tenantids=[NSDictionary dictionary];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)companyclick:(id)sender {
    DuoXuanVC* add=[[DuoXuanVC alloc] init];
    NSArray* keys=[_tenantids allKeys];
    [add setArray:keys btn:sender];
    [add setNavTitle:@"选择企业团队"];
    [add setDanXuan];
    NSString* curtitle=[_company currentTitle];
    if(curtitle!=nil){
        [add setSelectedData:[NSMutableArray arrayWithObject:curtitle]];
    }

    [self.navigationController pushViewController:add animated:YES];
    
}




- (IBAction)submit:(id)sender {
    if(_isModify!=nil && [_isModify isEqualToString:@"Y"]){
        NSString* companystr=[_tenantids objectNotNullForKey:[_company currentTitle]];
        NSMutableDictionary* param=[NSMutableDictionary dictionary];
        [param setNotNullObject:companystr forKey:@"tenantId"];
        [param setNotNullObject:_starttime.text forKey:@"startTime"];
        [param setNotNullObject:_endtime.text forKey:@"endTime"];
        [param setNotNullObject:@"" forKey:@"resourceIds"];
        [param setNotNullObject:[_curdata objectForKey:@"id"] forKey:@"id"];
        [_kaoqinluoji KaoQinLuoJiModify:param];
    }else{
        NSString* companystr=[_tenantids objectNotNullForKey:[_company currentTitle]];
        NSMutableDictionary* param=[NSMutableDictionary dictionary];
        [param setNotNullObject:companystr forKey:@"tenantId"];
        [param setNotNullObject:_starttime.text forKey:@"startTime"];
        [param setNotNullObject:_endtime.text forKey:@"endTime"];
        [param setNotNullObject:@"" forKey:@"resourceIds"];
        [_kaoqinluoji KaoQinLuoJiAdd:param];
    }
    

}


-(void) afternetwork4:(id)data
{
    NSNumber* num=(NSNumber*)data;
    int result=[num intValue];
    if(1==result){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KaoQinLuoJiVC" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"提交失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertCon addAction:action2];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
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
