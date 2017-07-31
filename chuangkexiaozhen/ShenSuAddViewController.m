//
//  ShenSuAddViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ShenSuAddViewController.h"
#import "ComboViewController.h"
#import "BussinessApi.h"
#import "NSMutableDictionary+NSMutableDictory_Extend.h"
@interface ShenSuAddViewController ()

@end

@implementation ShenSuAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"申诉申请";
    [self initWithData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnclick:(id)sender {    
    ComboViewController*vc=[[ComboViewController alloc] initView];
    NSArray* array=[NSArray arrayWithObjects:@"周边环境嘈杂",@"周边推销骚扰",@"车位被人占用",@"室内环境不整洁",@"资源配置不合理", nil];
    [vc setDatas:array withBtn:sender];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)submit:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:self.type.currentTitle,@"stateType",self.detail.text,@"stateContent",self.liyou.text,@"stateReason", nil];
    [self shenSuShenQingSubmit:param];
}


-(void) initWithData
{
    if(self.data!=nil){
        [self.type setTitle:[self.data objectForKey:@"stateType"] forState:UIControlStateNormal];
        [self.type setUserInteractionEnabled:NO];
        self.detail.text=[self.data objectForKey:@"stateContent"];
        self.detail.editable=NO;
        self.liyou.text=[self.data objectForKey:@"stateReason"];
        self.liyou.editable=NO;
        [self.shensuSubmit setHidden:YES];
    }

}


//申诉申请提交
-(void)shenSuShenQingSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/stateapply/save"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,提交成功 不等于1,提交
            if(1==result){
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"申诉申请已提交" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertCon addAction:action2];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ShenSuViewController" object:nil];
                [self presentViewController:alertCon animated:YES completion:nil];
            }else{
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"申诉申请提交失败" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [alertCon addAction:action2];
                [self presentViewController:alertCon animated:YES completion:nil];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
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
