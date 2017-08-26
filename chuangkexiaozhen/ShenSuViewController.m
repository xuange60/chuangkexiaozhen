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
    NSUInteger num=[self.datas count];
    return num;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* str1=@"shensucell1";
    
    ShenSuCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[ShenSuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.tenantTitle.text=[dic objectNotNullForKey:@"tenantTitle"];
    cell.status.text=[dic objectNotNullForKey:@"status"];
    cell.createDate.text=[dic objectNotNullForKey:@"createDate"];
    cell.stateType.text=[dic objectNotNullForKey:@"stateType"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


-(void)shenSuShenQingQuery
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
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

- (IBAction)ShenSuDetail:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"baodaoruzhu" bundle:nil];
    ShenSuAddViewController* add=[storyboard instantiateViewControllerWithIdentifier:@"ShenSuAddViewController"];
    add.data=dic;
    [self.navigationController pushViewController:add animated:YES];
    NSLog(@"%@",@"add");
    
}

- (IBAction)ShenSuDelete:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    NSString* id=[dic objectForKey:@"id"];
    [self shenSuShenQingDelete:id];
    
}


//申诉请求删除
-(void)shenSuShenQingDelete:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?ids=%@",baseurl,@"/stateapply/batchdelete",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,删除成功 不等于1,失败
            
            //result: 1,提交成功 不等于1,提交
            if(1==result){
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"申诉申请已删除" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self shenSuShenQingQuery];
                }];
                [alertCon addAction:action2];
                [self presentViewController:alertCon animated:YES completion:nil];
            }else{
                UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"申诉申请删除失败" preferredStyle:UIAlertControllerStyleAlert];
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
