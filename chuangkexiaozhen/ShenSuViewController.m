//
//  ShenSuViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ShenSuViewController.h"
#import "ShenSuCell.h"
#import "BussinessApi.h"
#import "ShenSuAddViewController.h"
@interface ShenSuViewController ()

@end

@implementation ShenSuViewController

- (void)viewDidLoad {
    self.datas=[NSArray array];
    [super viewDidLoad];
    self.navigationItem.title=@"申诉申请";
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    
    self.navigationItem.rightBarButtonItem=rightBtnItem;
    [self shenSuShenQingQuery];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shenSuShenQingQuery) name:@"ShenSuViewController" object:nil];
    // Do any additional setup after loading the view.
}

-(void)add
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"baodaoruzhu" bundle:nil];
    ShenSuAddViewController* add=[storyboard instantiateViewControllerWithIdentifier:@"ShenSuAddViewController"];
    [self.navigationController pushViewController:add animated:YES];
    NSLog(@"%@",@"add");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datas count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* str1=@"shensucell1";
    
    ShenSuCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[ShenSuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.tenantTitle.text=[dic objectForKey:@"tenantTitle"];
    cell.status.text=[dic objectForKey:@"status"];
    cell.createDate.text=[dic objectForKey:@"createDate"];
    cell.stateType.text=[dic objectForKey:@"stateType"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


-(void)shenSuShenQingQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/stateapply/search?start=0&length=1000"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            self.datas=result;
            [self.tableview reloadData];
            //result: 保存查询到的结果
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
