//
//  AddChanXueYanVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddChanXueYanVC.h"
#import "BussinessApi.h"
#import "ComboViewController.h"

@interface AddChanXueYanVC ()

@end

@implementation AddChanXueYanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加产学研";
    _mArray=[NSMutableArray array];//保存展示数据
    _Mstr=[NSMutableString string];//用于图片id连接
    
    _photosIDS=[NSString string];
}


- (IBAction)jiGouLevelClick:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"合作机构一级",@"合作机构二级",@"合作机构三级", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"比赛级别";
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)moneyLevelClick:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"1万元以下",@"10万元",@"100万元", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"合作金额级别";
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)PingZhengBtnClick:(id)sender {
    
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
        
        
        if (_mArray.count==1) {
            _iv1.image=[_mArray objectAtIndex:0];
        }else if (_mArray.count==2){
            _iv2.image=[_mArray objectAtIndex:1];
        }else if (_mArray.count==3){
            _iv3.image=[_mArray objectAtIndex:2];
        }
        

        // 文件上传
        //参数 NSData类型的文件数据,文件类型如jpg，png等
        //文件上传成功时返回ResourceId
        NSData*data=UIImageJPEGRepresentation(image, 0.5);
        
        
        [self shitiRuZhuFileup:data withType:@"jpg"  withResult:_Mstr];
        
    }
    
    
    
-(void) shitiRuZhuFileup:(NSData*) filedata withType:(NSString*)type withResult:(NSMutableString*) string
    {
        __block NSString*ids=nil;
        
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

    
    
    
    
    
- (IBAction)CommitBtnClick:(id)sender {
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    //7.2.2 添加产学研项目
    /*
     首先要上传文件；
     提交数据时，请求地址 post http://116.228.176.34:9002/chuangke-serve/cooperatorunitInfo/save
     参数：
     文件id resourceIds
     合作机构名称 name
     合作金额级别 moneyLevel
     合作金额 money
     机构级别 level
     合作效果 effect
     合作机构级别有：
     <option value="5879d94ea5a121dff6b57a5d">合作机构一级</option>
     <option value="58be68b9cfdfdf03086a8833">合作机构三级</option>
     <option value="58c7c57bce7229367c55853e">合作机构二级</option>
     
     合作金额级别有：
     <option value="58be6e1a769052b56d66e91e">1万元以下</option>
     <option value="58be6e54769052b56d66e91f">10万元</option>
     <option value="58be6e72cfdfdf03086a8835">100万元</option>
     */

        [dic  setObject:_name.text forKey:@"name"];
        [dic setObject:_effct.text forKey:@"effect"];
        [dic setObject:_money.text forKey:@"money"];
        [dic setObject:_moneyLevel.currentTitle forKey:@"moneyLevel"];
        [dic setObject:_jiGouLevel.currentTitle forKey:@"level"];
        [dic setObject:_photosIDS forKey:@"resourceIds"];
    
        [self chanXueYanSubmit:dic];

}
    
-(void)chanXueYanSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* levels=[NSDictionary dictionaryWithObjectsAndKeys:@"5879d94ea5a121dff6b57a5d",@"合作机构一级",@"58be68b9cfdfdf03086a8833",@"合作机构三级",@"58c7c57bce7229367c55853e",@"合作机构二级", nil];
    NSString* value=[parameters objectForKey:@"level"];
    [parameters setObject: [levels objectForKey:value] forKey:@"level"];
    
    NSDictionary* moneyLevels=[NSDictionary dictionaryWithObjectsAndKeys:@"58be6e1a769052b56d66e91e",@"1万元以下",@"58be6e54769052b56d66e91f",@"10万元",@"58be6e72cfdfdf03086a8835",@"100万元", nil];
    NSString* value2=[parameters objectForKey:@"moneyLevel"];
    [parameters setObject: [moneyLevels objectForKey:value2] forKey:@"moneyLevel"];
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/cooperatorunitInfo/save"];
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
                [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDCHANYEXUESCUUESS" object:nil];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}







@end
