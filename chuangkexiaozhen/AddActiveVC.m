//
//  AddActiveVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddActiveVC.h"
#import "ComboViewController.h"
@interface AddActiveVC ()

@end

@implementation AddActiveVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加活动";
    _mArray=[NSMutableArray array];//保存展示数据
    _Mstr=[NSMutableString string];//用于图片id连接
    
    _photosIDS=[NSString string];
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    
}


- (IBAction)ActiveLevelClick:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"省市级活动",@"区县级活动",@"园区镇街道活动", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"活动级别";
    [self.navigationController pushViewController:vc animated:YES];
    
}

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
    
    [_api shitiRuZhuFileup:data withType:@"jpg" withResult:_Mstr];
    
    
}

//从图库选择文件的代理
-(void)selectPhotoFromKu:(id)data
{
     _photosIDS=[NSString stringWithString:(NSString*)data];
}


- (IBAction)TiJiaoClick:(id)sender {
    
    /*
     7.3.2 活动添加
     请求 post http://116.228.176.34:9002/chuangke-serve/activity/save
     参数：
     活动级别 activityLevel	5879d979a5a121dff6b57a5f
     活动名称 name	展会活动
     参与人数 participant	2
     resourceIds	597d501c80ab5e6790d52d18,597d504b80ab5e6790d52d19
     主办单位 sponsor	深圳市真服
     响应：
        
     */
    

    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    [dic  setObject:_activeName.text forKey:@"name"];
    [dic setObject:_renShu.text forKey:@"participant"];
    [dic setObject:_danWei.text forKey:@"sponsor"];
    [dic setObject:_activeLevelBtn.currentTitle forKey:@"activityLevel"];
    [dic setObject:_photosIDS forKey:@"resourceIds"];
    
    [_api huoDongSubmitNew:dic];

}

//提交添加数据的代理

-(void)addData:(id)data
{
    NSNumber*num=data;
    int result=[num intValue];
    if (result==1)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDACTIVESCUUESS" object:nil];
    }
}


@end