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



- (IBAction)DeleteBtnClick:(id)sender {
//    UIButton*btn=(UIButton*)sender;
    
}

- (IBAction)downloadBtnClick:(id)sender forEvent:(UIEvent *)event {
    
     NSSet*touches=[event allTouches];
     UITouch*touch=[touches anyObject];
     CGPoint point=[touch locationInView:_tableView];
     NSIndexPath*indexPath=[_tableView indexPathForRowAtPoint:point];
     _num=indexPath.row;
    
    NSDictionary*dic=[_Marray objectAtIndex:_num];
    NSString*strID=[dic objectForKey:@"id"];
    
    NSData* imgdata=[self getCacheFile:strID];
    
    if(imgdata!=nil){
        NSLog(@"%@",@"use cache file");
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"MyStoryboard1" bundle:nil];
        xiazaiPhotoVC*vc= [board instantiateViewControllerWithIdentifier:@"xiazaiPhotoVC"];
        [vc setData:imgdata];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSLog(@"%@",@"download file");
        [self chushishenqingFileDownload:strID];
    }
    

    
}
//5.7 初始申请时上传的文档下载
-(void) chushishenqingFileDownload:(NSString*)resourceid
{

    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/down"];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id", nil];
    
    [manager GET:url parameters:parameters
        progress:^(NSProgress * _Nonnull downloadProgress)
     {
         // 打印下下载进度
         NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
     }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
         NSString* Disposition=[headers objectForKey:@"Content-Disposition"];
         NSString* filename=nil;
         if(Disposition!=nil){
             NSRange range=[Disposition rangeOfString:@"filename"];
             if(range.location>0){
                 filename=[Disposition substringFromIndex:(range.location+range.length+1)];
                 NSLog(@"%@",filename);
             }
         }
         if(filename==nil){
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             formatter.dateFormat = @"yyyyMMddHHmmss";
             NSString *str = [formatter stringFromDate:[NSDate date]];
             filename = [NSString stringWithFormat:@"实体入驻_%@.jpg", str];
         }
         
         [self cacheFile:resourceid withData:responseObject];
         
         UIStoryboard*board=[UIStoryboard storyboardWithName:@"MyStoryboard1" bundle:nil];
         xiazaiPhotoVC*vc= [board instantiateViewControllerWithIdentifier:@"xiazaiPhotoVC"];
         [vc setData:responseObject];
         [self.navigationController pushViewController:vc animated:YES];
         
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"%@",error);
     }
     ];
}





-(NSData*) getCacheFile:(NSString*)resourceid
{
    if(resourceid==nil){
        return nil;
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        return (NSData*)[defaults objectForKey:resourceid];
    }
}


-(void)cacheFile:(NSString*) resourceid withData:(NSData*)data
{
    @try {
        //将文件id，文件路径保存下来
        if(resourceid==nil){
            return;
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        id ary=[defaults objectForKey:@"chuangkexiaozhen.resource"];
        NSMutableArray* tmp=[NSMutableArray array];
        if([ary isKindOfClass:[NSArray class]] && [ary count]>0 ){
            [tmp addObjectsFromArray:(NSArray*)ary];
        }
        [tmp removeObject:resourceid];
        [tmp addObject:resourceid];
        [defaults setObject:tmp forKey:@"chuangkexiaozhen.resource"];
        
        
        [defaults setObject:data forKey:resourceid];
    } @catch (NSException *exception) {
        NSLog(@"缓存异常%@",exception);
    }
    
}


















@end
