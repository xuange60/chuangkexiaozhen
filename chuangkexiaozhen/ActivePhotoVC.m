//
//  ActivePhotoVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ActivePhotoVC.h"
#import "ActivePhotoCell.h"
#import "BussinessApi.h"

@interface ActivePhotoVC ()

@end

@implementation ActivePhotoVC


-(void)ReceiveShuJuPhoto:(NSString*)str
{
    _entryID=[NSString stringWithString:str];
    _Marray=[NSMutableArray array];
    _num=0;
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    [_api huoDongQueryNew];
    

}

#pragma mark-BussinessApiDelegate
-(void)loadNetworkFinished:(id)data
{
    _Marray=(NSMutableArray*)data;
    
    [_tableView reloadData];
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
    NSString*ss=@"ActivePhotoCell";
    ActivePhotoCell*cell=[tableView dequeueReusableCellWithIdentifier:ss];
    
    if (!cell) {
        cell=(ActivePhotoCell*)[[ActivePhotoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ss];
    }
    
    
    NSDictionary*dic=[_Marray objectAtIndex:indexPath.row];
    NSString*str1=[dic objectForKey:@"name"];
    NSString*str2=[dic objectForKey:@"date"];
    
    cell.Name.text=str1;
    cell.Date.text=str2;
    
    return cell;
}

- (IBAction)activeDeleteClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*indexPath=[_tableView indexPathForRowAtPoint:point];
    _num=indexPath.row;
    
    NSDictionary*dic=[_Marray objectAtIndex:_num];
    NSString*strID=[dic objectForKey:@"id"];
    
//    [self chanXueYanDelete:strID withEntityId:_entryID];
    
//    [_api huoDongDeleteNew:<#(NSString *)#>];

    
    [_api huoDongDeleteNew:strID withEntityIdNew:_entryID];
}

/*
 7.2.5 删除已上传文件
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=6&entityId=597cc95080ab5e6790d528c3&id=597cc8ff80ab5e6790d528c1
 参数 entityid为合作项目id，id为文件id
 */
-(void) chanXueYanDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"6",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
            
//            if (result==1) {
//                
//                [self chanXueYanQueryFile:entityId];
//            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



- (IBAction)activeDownloadClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*indexPath=[_tableView indexPathForRowAtPoint:point];
    _num=indexPath.row;
    
    NSDictionary*dic=[_Marray objectAtIndex:_num];
    NSString*strID=[dic objectForKey:@"id"];
    
    
//    [self chushishenqingFileDownload:strID];

    
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
         
         
//         UIStoryboard*board=[UIStoryboard storyboardWithName:@"MyStoryboard1" bundle:nil];
//         xiazaiPhotoVC*vc= [board instantiateViewControllerWithIdentifier:@"xiazaiPhotoVC"];
//         [vc setData:responseObject];
//         [self.navigationController pushViewController:vc animated:YES];
         
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"%@",error);
     }
     ];
}


@end
