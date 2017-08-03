//
//  AddZhuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddZhuanLiVC.h"

@interface AddZhuanLiVC ()

@end

@implementation AddZhuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加专利知识";
    _mArray=[NSMutableArray array];//保存展示数据
    _Mstr=[NSMutableString string];//用于图片id连接
    
    _photosIDS=[NSString string];
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    
}

- (IBAction)leiBieBtnClick:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"软件著作权",@"集成电路布图设计",@"商标",@"实用新型专利",@"发明专利",@"文学著作权", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"类型";
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
     7.4.2 专业知识产权新增
     请求 post  http://116.228.176.34:9002/chuangke-serve/knowledge/save
     参数
     产权编码 code	123131312
     知识名称 name	test
     文件 	 resourceIds	597d60d680ab5e6790d52d21,597d60d980ab5e6790d52d22
     知识类型 type	58be754fcfdfdf03086a8837
     <option value="58be754fcfdfdf03086a8837">软件著作权</option>
     <option value="58be756fcfdfdf03086a8839">集成电路布图设计</option>
     <option value="58be7588cfdfdf03086a883b">商标</option>
     <option value="58be75a9cfdfdf03086a883d">实用新型专利</option>
     <option value="58be75c8cfdfdf03086a883f">发明专利</option>
     <option value="58be75e3cfdfdf03086a8841">文学著作权</option>
     */    
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    [dic  setObject:_name.text forKey:@"name"];
    [dic setObject:_biMa.text forKey:@"code"];
    [dic setObject:_leiBieBtn.currentTitle forKey:@"type"];
    [dic setObject:_photosIDS forKey:@"resourceIds"];
    
    [_api zhuanYeZhiShiSubmit:dic];
    
}

//提交添加数据的代理

-(void)addData:(id)data
{
    NSNumber*num=data;
    int result=[num intValue];
    if (result==1)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDZHUANLISCUUESS" object:nil];
    }
}

@end
