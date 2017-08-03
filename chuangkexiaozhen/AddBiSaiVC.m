//
//  AddBiSaiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddBiSaiVC.h"
#import "ComboViewController.h"
#import "BussinessApi.h"
@interface AddBiSaiVC ()

@end

@implementation AddBiSaiVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=@"添加比赛";
     _mArray=[NSMutableArray array];//保存展示数据
     _Mstr=[NSMutableString string];//用于图片id连接
    _photosIDS=[NSString string];
    
}

// 比赛级别选择的事件处理
- (IBAction)BiSaiLevelCkicl:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"国家级比赛",@"省部级比赛",@"区县级比赛",@"一般比赛", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"比赛级别";
    [self.navigationController pushViewController:vc animated:YES];

}

//获奖名次选择的事件处理
- (IBAction)MingCiCkick:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"一等奖",@"二等奖",@"三等奖", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"获奖名次";
    [self.navigationController pushViewController:vc animated:YES];
    
}

//上传图片的事件处理
- (IBAction)shangChuanClick:(id)sender {

    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
    

}

#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    UIImage*image = info[UIImagePickerControllerOriginalImage];
    
    [_mArray addObject:image];
    
     [self setData];//显示图片

    // 文件上传
    //参数 NSData类型的文件数据,文件类型如jpg，png等
    //文件上传成功时返回ResourceId
    NSData*data=UIImageJPEGRepresentation(image, 0.5);
    
    
    [self shitiRuZhuFileup:data withType:@"jpg"  withResult:_Mstr];
    
}

-(void)setData
{
    UIImageView*iv1=[_myView viewWithTag:900];
    UIImageView*iv2=[_myView viewWithTag:901];
    UIImageView*iv3=[_myView viewWithTag:902];
    
    if (_mArray.count ==0) {
        return;
    }else if (_mArray.count==1){
        
        iv1.image=[_mArray objectAtIndex:0];
    }else if (_mArray.count==2){
        
        iv2.image=[_mArray objectAtIndex:1];
    }else if (_mArray.count==3){
        
        iv3.image=[_mArray objectAtIndex:2];
    }
    
}


-(void) shitiRuZhuFileup:(NSData*) filedata withType:(NSString*)type withResult:(NSMutableString*) string
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"文件上传_%@.%@", str,type];
    NSLog(@"%@",fileName);
    
    NSDictionary *dict = @{@"":@""};
    NSString *urlString = @"http://116.228.176.34:9002/chuangke-serve/upload/save";
    [manager POST:urlString parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData){
    //[formData appendPartWithFileURL:[NSURLfileURLWithPath:@"文件地址"] name:@"file"fileName:@"1234.png"mimeType:@"application/octet-stream"error:nil];
    [formData appendPartWithFileData:filedata name:@"file" fileName:fileName mimeType:@"image/png"];
}progress:^(NSProgress * _Nonnull uploadProgress){
    // 打印下上传进度 此处界面可能要显示上传进度
    NSLog(@"%lld%@",100 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount,@"%");
}success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
    
    NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
    NSLog(@"%@",data);
    NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
    
    // 文件上传成功 获取ResourceId
    NSString* ResourceId=[jsondata objectForKey:@"ResourceId"];
    if(string.length==0){
        [string appendString:ResourceId];
    }else{
        [string appendString:@","];
        [string appendString:ResourceId];
    }
    
    //结果在string
    NSLog(@"%@",string);
    
    _photosIDS=[NSString stringWithString:string];
    
    
}failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
    // 请求失败
    NSLog(@"请求失败：%@", error);
}];
}


- (IBAction)commitedClick:(id)sender {
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    
    [dic  setObject:_bisaiName.text forKey:@"name"];
    [dic setObject:_rongyuName.text forKey:@"hornerName"];
    [dic setObject:_zuzhijigouName.text forKey:@"orgnizationUnit"];
//    [dic setObject:_rongyuName forKey:@"ownerCompetition"];
    [dic setObject:_CompleteLevelBtn.currentTitle forKey:@"competeLevel"];
    [dic setObject:_prizeAwardsBtn.currentTitle forKey:@"prizeAwarded"];
    [dic setObject:_photosIDS forKey:@"resourceIds"];
    
    [self biSaiGuanLiSubmit:dic];
    
   
}

//7.1.2孵化成长管理->日常活跃度管理->比赛管理添加
/*
 请求参数：
 比赛级别 competeLevel
 荣誉名称 hornerName
 比赛名称 name
 组织单位 orgnizationUnit
 是否本园区组织 ownerCompetition
 获奖名次 prizeAwarded
 上传图片的资源id resourceIds
 */
-(void)biSaiGuanLiSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* competeLevels=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c2114c1a48b6fd96506a",@"国家级比赛",@"58c7c2114c1a48b6fd96506b",@"省部级比赛",@"58c7c2114c1a48b6fd96506c",@"区县级比赛",@"58c7c2114c1a48b6fd96506d",@"一般比赛", nil];
    NSString* value=[parameters objectForKey:@"competeLevel"];
    [parameters setObject: [competeLevels objectForKey:value] forKey:@"competeLevel"];
    
    NSDictionary* prizeAwardeds=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c3c44c1ae760f68a1013",@"一等奖",@"58c7c3c44c1ae760f68a1014",@"二等奖",@"58c7c3c44c1ae760f68a1015",@"三等奖", nil];
    NSString* value2=[parameters objectForKey:@"prizeAwarded"];
    [parameters setObject: [prizeAwardeds objectForKey:value2] forKey:@"prizeAwarded"];
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/competition/save"];
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
            
            if (result==1)
            {
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDSUCCESS" object:nil];
                
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}








@end
