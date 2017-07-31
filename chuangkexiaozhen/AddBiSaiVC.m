//
//  AddBiSaiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddBiSaiVC.h"
#import "ComboViewController.h"
@interface AddBiSaiVC ()

@end

@implementation AddBiSaiVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=@"添加比赛";
     _mArray=[NSMutableArray array];
    
    
}


- (IBAction)BiSaiLevelCkicl:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"国家级比赛",@"省部级比赛",@"区县级比赛",@"一般比赛", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"比赛级别";
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)MingCiCkick:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"一等奖",@"二等奖",@"三等奖", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"获奖名次";
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)shangChuangClick:(id)sender {

    
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
    
    

    //??????????????????????????????????????????????????????????????????
    //5.2 实体入驻时文件上传
    //参数 NSData类型的文件数据,文件类型如jpg，png等
    //文件上传成功时返回ResourceId
    NSData*data=UIImageJPEGRepresentation(_imgView.image, 0.5);
    
    [self setData];
    
//    [self shitiRuZhuFileup:data withType:@"jpg"];
    
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






- (IBAction)commitedClick:(id)sender {
    
    
    
    
    
    

}









@end
