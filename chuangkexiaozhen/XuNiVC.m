//
//  XuNiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/25.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "XuNiVC.h"
#import "BussinessApi.h"
#import "xuNiView.h"
#import "ComBoRowsViewController.h"
@interface XuNiVC ()

@end

@implementation XuNiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"虚拟入驻";
    // Do any additional setup after loading the view.

   _Mstr=[NSMutableString string];
    
}

- (IBAction)duoxianBtnClick2:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComBoRowsViewController* vc=[storyboard instantiateViewControllerWithIdentifier:@"ComBoRowsViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"展示推介机会",@"投融资需求",@"信息技术需求",@"制造加工及场地需求",@"农艺新品种需求",@"交流合作机会",@"咨询管理",@"其他", nil];
    [vc setDatas:array withBtn:self.duoxuan];
    [vc setNavigationItemTitle:@"寻求类别"];
    //[self presentViewController:vc animated:YES completion:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)duoxuanBtnClick:(id)sender {
    /*
    xuNiView*view=[[[NSBundle mainBundle]loadNibNamed:@"xuNiView" owner:self options:nil]lastObject];
    
    view.frame=CGRectMake(_MyView.frame.origin.x, _MyView.frame.origin.y+10, _MyView.frame.size.width, 180);
*/
//    view.frame=CGRectMake(0, 300, 300, 200);
 //    [self.view addSubview:view];
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComBoRowsViewController* vc=[storyboard instantiateViewControllerWithIdentifier:@"ComBoRowsViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"展示推介机会",@"投融资需求",@"信息技术需求",@"制造加工及场地需求",@"农艺新品种需求",@"交流合作机会",@"咨询管理",@"其他", nil];
    [vc setDatas:array withBtn:sender];
    [vc setNavigationItemTitle:@"寻求类别"];
    //[self presentViewController:vc animated:YES completion:nil];
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)XianShiBtnClick:(id)sender {
    
    UIButton*btn=(UIButton*)sender;
    
    [_Mstr appendString:btn.currentTitle];
    //_label.text=_Mstr;
}





- (IBAction)BtnClicked:(id)sender {
    
    NSString*userName=_F1.text;
    NSString*contactMobile=_F2.text;
    
    
    
    
    NSDictionary*dic=[NSDictionary dictionary];
    [dic setValue:_F1.text forKey:@"contact"];
    [dic setValue:_F2.text forKey:@"contacttype"];
    [dic setValue:_F3.text forKey:@"branchname"];
    
  //  [dic setValue :_label.text    forKey:@"coopcategories"];
    [dic setValue:_textView.text forKey:@"desc"];
    
    [self xuniRuZhuSubmitWithParam:dic];
}


//5.4 虚拟入驻申请
// 参数为字典：branchname=测试虚拟入驻  contact=小明  contacttype=18576672852  coopcategories=展示推介机会,投融资需求,信息技术需求
//desc=测试备注

-(void) xuniRuZhuSubmitWithParam:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:param];
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/apply/saveresapply"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            NSLog(@"%d",result);
            //result: 1,虚拟入驻提交成功 不等于1,则提交失败
            
            if (result==1) {
                
            }else{
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"提交失败，请重新填写" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action=[UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:nil];
                [alertCon addAction:action];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}














@end
