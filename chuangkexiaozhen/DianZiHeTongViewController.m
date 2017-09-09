//
//  DianZiHeTongViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "DianZiHeTongViewController.h"

@interface DianZiHeTongViewController ()

@end

@implementation DianZiHeTongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"电子合同上传";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    _images=[NSMutableArray array];
    _resourceids=[NSMutableString string];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)selectFile:(id)sender {
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
    
    [_images addObject:image];
    
    [self setData];//显示图片
    
    // 文件上传
    //参数 NSData类型的文件数据,文件类型如jpg，png等
    //文件上传成功时返回ResourceId
    NSData*data=UIImageJPEGRepresentation(image, 0.5);
    
    
    [self shitiRuZhuFileup:data withType:@"jpg"  withResult:_resourceids];
    
}

-(void)setData
{
    if (_images.count ==0) {
        _iv1.hidden=YES;
        [_ind1 stopAnimating];
        _iv2.hidden=YES;
        [_ind2 stopAnimating];
        _iv3.hidden=YES;
        [_ind3 stopAnimating];
        return;
    }else if (_images.count==1){
        _iv1.image=[_images objectAtIndex:0];
        _iv1.hidden=NO;
        [_ind1 startAnimating];
    }else if (_images.count==2){
        _iv2.image=[_images objectAtIndex:1];
        _iv2.hidden=NO;
        [_ind2 startAnimating];
    }else if (_images.count==3){
        _iv3.image=[_images objectAtIndex:2];
        _iv3.hidden=NO;
        [_ind3 startAnimating];
    }
    
}


//参数 NSData类型的文件数据,文件类型如jpg，png等
//文件上传成功时返回ResourceId
-(void) shitiRuZhuFileup:(NSData*) filedata withType:(NSString*)type withResult:(NSMutableString*) string
{
    NSInteger index=_images.count;
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"电子合同文件_%@.%@", str,type];
    NSLog(@"%@",fileName);
    
    NSDictionary *dict =[NSDictionary dictionary];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"],@"/upload/save"];
    [manager POST:urlString parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData){
    //[formData appendPartWithFileURL:[NSURLfileURLWithPath:@"文件地址"] name:@"file"fileName:@"1234.png"mimeType:@"application/octet-stream"error:nil];
    [formData appendPartWithFileData:filedata name:@"file" fileName:fileName mimeType:@"image/png"];
}progress:^(NSProgress * _Nonnull uploadProgress){
    // 打印下上传进度 此处界面可能要显示上传进度
    long long int pro=100 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
    NSString* progressstr=[NSString stringWithFormat:@"%lld%@",pro,@"%"];
    NSLog(@"%@",progressstr);

  /*
   NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:index],@"index",progressstr,@"progressstr", nil];
   文件上传时，界面显示进度，以下两种方式均为达到理想效果
    //  [self performSelectorOnMainThread:@selector(refreshProgress:) withObject:param waitUntilDone:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refreshProgress:param];
    });
   */
    
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
    if(![self.rightbutton isEnabled]){
        self.rightbutton.enabled=YES;
    }

  //  NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:index],@"index",@"100%",@"progressstr", nil];
 //   [self performSelectorOnMainThread:@selector(refreshProgress:) withObject:param waitUntilDone:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (index==1){
            [_ind1 stopAnimating];
        }else if (index==2){
            [_ind2 stopAnimating];
        }else if (index==3){
            [_ind3 stopAnimating];
        }
    });

    //结果在string
    NSLog(@"%@",string);
    
    
}failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
    // 请求失败
    if (index==1){
        [_ind1 stopAnimating];
    }else if (index==2){
        [_ind2 stopAnimating];
    }else if (index==3){
        [_ind3 stopAnimating];
    }
}];
}



- (IBAction)submit:(id)sender {
    if(_resourceids==nil || _resourceids.length<1){
        return;
    }
    [self dianZiHeTongSubmit];
}



/*上传图片的资源id resourceIds
*/
-(void)dianZiHeTongSubmit
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setNotNullStrObject:[NSString stringWithString:_resourceids] forKey:@"resourceIds"];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/electroniccontract/save"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectNotNullForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,提交成功 不等于1,提交
            
            if (result==1) {
                [self tiShiKuangDisplay:@"提交成功" viewController:self];
                if(_ids!=nil && _ids.length>1){
                    [self baodao];
                }
                [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:NO block:^(NSTimer * _Nonnull timer) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                
            }else{
                [self tiShiKuangDisplay:@"提交失败" viewController:self];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}



-(void)baodao
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setNotNullStrObject:_ids forKey:@"id"];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/apply/update/inplace"];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectNotNullForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,提交成功 不等于1,提交
            
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
