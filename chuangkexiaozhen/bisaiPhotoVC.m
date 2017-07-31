//
//  bisaiPhotoVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "bisaiPhotoVC.h"
#import "bisaiPhotoCell.h"
#import "xiazaiPhotoVC.h"
#import "BussinessApi.h"
@interface bisaiPhotoVC ()

@end

@implementation bisaiPhotoVC

-(void)ReceiveShuJuPhoto:(NSString*)str
{
     _Marray=[NSMutableArray array];
    
    [self biSaiGuanLiQueryFile:str];
    
    _entryID=str;
    
}

//7.1.4 孵化成长管理->日常活跃度管理->查询已上传的图片
-(void)biSaiGuanLiQueryFile:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",@"5",@"typeIndex", nil];
    
    [manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            //result: 保存查询到的结果
            
            _Marray=(NSMutableArray*)result;
            [_tableView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"文档下载";
    
    
      
}

#pragma mark-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_Marray.count==0)
    {
        return 0;
    }
    return _Marray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*ss=@"PhotoCell";
    bisaiPhotoCell*cell=[tableView dequeueReusableCellWithIdentifier:ss];
    
    if (!cell) {
        cell=(bisaiPhotoCell*)[[bisaiPhotoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ss];
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
   
    cell.Name.text=str1;
    cell.Date.text=str2;
    
    return cell;
}
- (IBAction)DeletePhotoClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*indexPath=[_tableView indexPathForRowAtPoint:point];
    _num=indexPath.row;
    
    NSDictionary*dic=[_Marray objectAtIndex:_num];
    NSString*strID=[dic objectForKey:@"id"];
    
    [self biSaiGuanLiFileDelete:strID withEntityId:_entryID];
    
}
//7.1.5 孵化成长管理->日常活跃度管理->已上传的文档删除
//参数为 文档的资源id； entityId比赛id
-(void) biSaiGuanLiFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"5",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
            
            [self biSaiGuanLiQueryFile:entityId];
           
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




- (IBAction)downloadBtnClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*indexPath=[_tableView indexPathForRowAtPoint:point];
    _num=indexPath.row;
    
    NSDictionary*dic=[_Marray objectAtIndex:_num];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    [self chushishenqingFileDownload:strID];
    
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
         
         NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
         NSString* file=[filePath stringByAppendingPathComponent:filename];
         NSLog(@"%@",file);
         NSFileManager* filemanager=[[NSFileManager alloc]init];
         if(![filemanager fileExistsAtPath:file]){
             [filemanager createFileAtPath:file contents:nil attributes:nil];
         }
         
         NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:file];
         [fileHandle writeData:(NSData*)responseObject];
         [fileHandle closeFile];
         
         //此时文件下载成功；
         
         
         //将文件id，文件路径保存下来
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:(NSData*)responseObject forKey:@"test"];
         
         
         NSDictionary* dic=[NSDictionary dictionaryWithObjectsAndKeys:file,resourceid, nil];
         [defaults setObject:dic forKey:@"chuangkexiaozhen.resource"];
         
         
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






@end
