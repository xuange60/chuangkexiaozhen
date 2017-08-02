//
//  FuWuShenQingAddViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "FuWuShenQingAddViewController.h"

@interface FuWuShenQingAddViewController ()

@end

@implementation FuWuShenQingAddViewController

- (void)viewDidLoad {
    self.resourids=@"";
    self.yuanqufuwushenqing=[[YuanQuFuWuShenQing alloc] init];
    self.yuanqufuwushenqing.delegate=self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击下拉菜单按钮 modify
- (IBAction)comboview:(id)sender {
    ComboViewController*vc=[[ComboViewController alloc] initView];
    NSArray* array=[NSArray arrayWithObjects:@"物业维修", @"加工服务", @"广告服务", @"会议会务 ", @"企业培训", @"工商服务", @"知识产权服务", @"人才公寓服务", @"补贴福利", @"联谊活动", @"人才招聘需求", nil];
    [vc setDatas:array withBtn:sender];
    [self.navigationController pushViewController:vc animated:YES];
}


//点击文件上传按钮 modify
- (IBAction)fileup:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"FuWuShenQingAddViewControllerFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"FuWuShenQingAddViewControllerFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}

-(void)getfile:(id)data
{
    if(data!=nil){
        self.resourids=(NSString*)data;
    }

}


//点击提交按钮 modify
- (IBAction)submit:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:self.fuwucontent.text,@"content",self.resourids,@"resourceIds",self.fuwutype.currentTitle,@"serveCategory", nil];
    [self.yuanqufuwushenqing YuanQuFuWuSubmit:param];
}

//modify
-(void)addData:(id)data
{
    NSNumber* num=(NSNumber*)data;
    int result=[num intValue];
    if(1==result){
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"服务申请已提交" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertCon addAction:action2];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FuWuViewController" object:nil];
        [self presentViewController:alertCon animated:YES completion:nil];
    }else{
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"服务申请提交失败" preferredStyle:UIAlertControllerStyleAlert];
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
