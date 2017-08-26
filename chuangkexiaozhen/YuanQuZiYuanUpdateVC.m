//
//  YuanQuZiYuanUpdateVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YuanQuZiYuanUpdateVC.h"

@interface YuanQuZiYuanUpdateVC ()

@end

@implementation YuanQuZiYuanUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _yuanquziyuanguanli=[[YuanQuZiYuanGuanLi alloc] init];
    _yuanquziyuanguanli.delegate=self;
    self.navigationItem.title=@"添加资源";
    
    if(_isModify!=nil && [_isModify isEqualToString:@"Y"]){
        self.navigationItem.title=@"修改资源";
        [_category setTitle:[_curdata objectNotNullForKey:@"category"] forState:UIControlStateNormal];
        _code.text=[_curdata objectNotNullForKey:@"code"];
        _content.text=[_curdata objectNotNullForKey:@"content"];
    }
    
    
    // Do any additional setup after loading the view.
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)companyclick:(id)sender {
    DuoXuanVC* add=[[DuoXuanVC alloc] init];
    NSArray* keys=[_categorys allKeys];
    [add setArray:keys btn:sender];
    [add setNavTitle:@"选择资产类型"];
    [add setDanXuan];
    NSString* curtitle=[_category currentTitle];
    if(curtitle!=nil){
        [add setSelectedData:[NSMutableArray arrayWithObject:curtitle]];
    }
    
    [self.navigationController pushViewController:add animated:YES];
    
}




- (IBAction)submit:(id)sender {
    if(_isModify!=nil && [_isModify isEqualToString:@"Y"]){
        NSString* categorystr=[_categorys objectNotNullForKey:[_category currentTitle]];
        NSMutableDictionary* param=[NSMutableDictionary dictionary];
        [param setNotNullStrObject:categorystr forKey:@"category"];
        [param setNotNullStrObject:_code.text forKey:@"code"];
        [param setNotNullStrObject:_content.text forKey:@"content"];
        [param setNotNullStrObject:[_curdata objectNotNullForKey:@"resourceIds"] forKey:@"resourceIds"];
        [param setNotNullStrObject:[_curdata objectForKey:@"id"] forKey:@"id"];
        [_yuanquziyuanguanli YuanQuZiYuanModify:param];
    }else{
        NSString* categorystr=[_categorys objectNotNullForKey:[_category currentTitle]];
        NSMutableDictionary* param=[NSMutableDictionary dictionary];
        [param setNotNullStrObject:categorystr forKey:@"category"];
        
        [param setNotNullStrObject:_code.text forKey:@"code"];
        [param setNotNullStrObject:_content.text forKey:@"content"];
        [param setNotNullStrObject:[_curdata objectForKey:@"resourceIds"] forKey:@"resourceIds"];
        [_yuanquziyuanguanli YuanQuZiYuanAdd:param];
    }
    
    
}


-(void) afternetwork4:(id)data
{
    NSNumber* num=(NSNumber*)data;
    int result=[num intValue];
    if(1==result){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YuanQuZiYuanVC" object:nil];
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
