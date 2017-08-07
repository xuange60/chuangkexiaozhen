//
//  FilelistViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "FilelistViewController.h"

@interface FilelistViewController ()

@end

@implementation FilelistViewController

-(id) initView
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    self=[storyboard instantiateViewControllerWithIdentifier:@"FilelistViewController"];
    return self;
}



-(id)initView:(NSString*) entityid withType:(NSString*)type
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    self=[storyboard instantiateViewControllerWithIdentifier:@"FilelistViewController"];
    self.entityid=entityid;
    self.type=type;
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"相关文档列表";
    self.datas=nil;
    [self FileQuery:_entityid withType:_type];
    // Do any additional setup after loading the view.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger num=[self.datas count];
    return num;
}

//modify 加载单元格数据时使用 注意设置单元格的Identifier
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* str1=@"FilelistCell";
    
    FilelistCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[FilelistCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.filename.text=(NSString*)[dic objectForKey:@"name"];
    cell.filedate.text=(NSString*)[dic objectForKey:@"date"];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
*/


- (IBAction)deletefile:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    [self FileDelete:dic withEntityId:self.entityid withType:self.type];
    NSLog(@"%@",@"delete file");
}


- (IBAction)downloadfile:(id)sender forEvent:(UIEvent *)event {

    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
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
        [self FileDownload:strID];
    }



    
    
    
}

-(void) FileDownload:(NSString*)resourceid
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
             filename = [NSString stringWithFormat:@"下载文件_%@.jpg", str];
         }
         
         [self cacheFile:resourceid withData:(NSData*)responseObject];

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



-(void)FileQuery:(NSString*)ids withType:(NSString*)type
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",type,@"typeIndex", nil];
    
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
            self.datas=result;
            [self.tableview reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



-(void)FileDelete:(NSDictionary*)data withEntityId:(NSString*) entityId withType:(NSString*)type
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* resourceid=[data objectForKey:@"id"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",type,@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            if(result==1){
                NSMutableArray* array=[NSMutableArray arrayWithArray:self.datas];
                int index=-1;
                for (int i=0; i<[array count]; i++) {
                    NSString* tmpid=[[array objectAtIndex:i] objectForKey:@"id"];
                    if([resourceid isEqualToString:tmpid]){
                        index=i;
                    }
                }
                if(index>-1){
                    [array removeObjectAtIndex:index];
                    self.datas=array;
                    [self.tableview reloadData];
                }else{
                    [self FileQuery:_entityid withType:_type];
                }
                
            }
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



@end
