//
//  GenZongFuWuAddViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "GenZongFuWuAddViewController.h"

@interface GenZongFuWuAddViewController ()

@end

@implementation GenZongFuWuAddViewController

- (void)viewDidLoad {
    self.navigationItem.title=@"反馈意见";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    [super viewDidLoad];
    self.genzongfuwu=[[GenZongFuWu alloc] init];
    self.genzongfuwu.delegate=self;

    [self receiveCurrentViewController:self];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {

    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:self.content.text,@"content",self.genzongtitle.text,@"title", nil];
    [self.genzongfuwu GenZongFuWuSubmit:param];

}

//modify
-(void)addData:(id)data
{
    NSNumber* num=(NSNumber*)data;
    int result=[num intValue];
    if (result==1) {
        [self tiShiKuangDisplay:@"提交成功" viewController:self];
        [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:NO block:^(NSTimer * _Nonnull timer) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GenZongViewController" object:nil];
    }else{
        [self tiShiKuangDisplay:@"提交失败" viewController:self];
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
