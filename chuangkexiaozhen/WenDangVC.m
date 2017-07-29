//
//  WengDangVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/27.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "WenDangVC.h"
#import "BussinessApi.h"
#import "XiaZaiCell.h"
@interface WenDangVC ()

@end

@implementation WenDangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.navigationItem.title=@"文档下载";
    
    
    _Marray=[NSMutableArray array];
    
    [self chushishenqingFileQuery];
    
}

//初始申请上传的所有文件查询
-(void) chushishenqingFileQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/search"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"start",@"100",@"length", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            //数组result为结果数据
            
            _Marray=(NSMutableArray*)result;
            [_tableView reloadData];
            
            //打印查询到的数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _Marray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*ss=@"xiazaicell";
    XiaZaiCell*cell=[tableView dequeueReusableCellWithIdentifier:ss];
    
    if (!cell) {
        cell=(XiaZaiCell*)[[XiaZaiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ss];
    }
    
    //5.5 初始申请时上传的所有文件查询
    /*返回值为数组，其中id为文件id
     [
     {"id":"5974ccc080ab5e6790d50e90",
     "name":"fuwiimg.jpg",
     "path":"gaogaihui/busiplan/20170723/1500855616000.jpg",
     "date":"2017-07-23"},
     {"id":"597a0a0280ab5e6790d51fd9"
     ,"name":"Snip20170703_1.png","path":"gaogaihui/busiplan/20170727/1501198978000.png","date":"2017-07-27"
     }
     ]
     */

    NSDictionary*dic=[_Marray objectAtIndex:indexPath.row];
    NSString*str1=[dic objectForKey:@"name"];
    NSString*str2=[dic objectForKey:@"date"];
    NSArray*ary=[NSArray arrayWithObjects:str1,str2, nil];

    [cell setCellShuJu:ary];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}



- (IBAction)DeleteBtnClick:(id)sender {
//    UIButton*btn=(UIButton*)sender;
    
}


- (IBAction)DownLoadBtnClick:(id)sender {
     UIButton*btn=(UIButton*)sender;
    
    
    
    
}























@end
