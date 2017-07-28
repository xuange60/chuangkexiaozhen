//
//  ShiTiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/24.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ShiTiVC.h"

@interface ShiTiVC ()

@end

@implementation ShiTiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"实体入驻";
    
    _textField1.layer.borderWidth=0.2;
    _textField1.layer.borderColor=[UIColor colorWithRed:242/255 green:241/255 blue:241/255 alpha:1.0].CGColor;
    
    _textField2.layer.borderWidth=0.2;
    _textField2.layer.borderColor=[UIColor colorWithRed:242/255 green:241/255 blue:241/255 alpha:1.0].CGColor;

    _textField3.layer.borderWidth=0.2;
    _textField3.layer.borderColor=[UIColor colorWithRed:242/255 green:241/255 blue:241/255 alpha:1.0].CGColor;

    
    _view1.layer.cornerRadius=2;
    _view1.layer.borderWidth=0.2;
    _view1.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    
    _view2.layer.cornerRadius=2;
    _view2.layer.borderWidth=0.2;
    _view2.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    _textF1.enabled=NO;
    _textF2.enabled=NO;
    
    _xuanWenJianBtn.layer.cornerRadius=10;
    
    
    
   
}

//对所属行业作出下拉选项
- (IBAction)btn1Click:(id)sender {
    
    _xialaView=[[[NSBundle mainBundle]loadNibNamed:@"XiaLaView" owner:self options:nil]lastObject];
    _xialaView.frame=CGRectMake(_view1.frame.origin.x,_view1.frame.origin.y, _view1.frame.size.width, 260);
    _xialaView.layer.cornerRadius=20;

    [_xialaView.btn1 setTitle:@"电子信息" forState:UIControlStateNormal];
    [_xialaView.btn2 setTitle:@"生物医药" forState:UIControlStateNormal];
    [_xialaView.btn3 setTitle:@"新材料" forState:UIControlStateNormal];
    [_xialaView.btn4 setTitle:@"互联网和移动互联网" forState:UIControlStateNormal];
    [_xialaView.btn5 setTitle:@"先进制造" forState:UIControlStateNormal];
    [_xialaView.btn6 setTitle:@"新能源及节能环保" forState:UIControlStateNormal];
    [_xialaView.btn7 setTitle:@"科技服务业" forState:UIControlStateNormal];
    [_xialaView.btn8 setTitle:@"农业科技" forState:UIControlStateNormal];
    [_xialaView.btn9 setTitle:@"艺术文化" forState:UIControlStateNormal];
    [_xialaView.btn10 setTitle:@"电子商务" forState:UIControlStateNormal];
    [_xialaView.btn11 setTitle:@"创投孵化" forState:UIControlStateNormal];

    [self.view addSubview:_xialaView];
    
}
//对团队描述作出下拉选项
- (IBAction)btn2Click:(id)sender {
    
    _xialaView=[[[NSBundle mainBundle]loadNibNamed:@"XiaLaView" owner:self options:nil]lastObject];
    _xialaView.frame=CGRectMake(_view2.frame.origin.x,_view2.frame.origin.y, _view2.frame.size.width, 120);
    _xialaView.layer.cornerRadius=20;
    
    [_xialaView.btn1 setTitle:@"初创团队" forState:UIControlStateNormal];
    [_xialaView.btn2 setTitle:@"小微企业" forState:UIControlStateNormal];
    [_xialaView.btn3 setTitle:@"加速企业" forState:UIControlStateNormal];
     _xialaView.btn4.hidden=YES;
     _xialaView.btn5.hidden=YES;
     _xialaView.btn6.hidden=YES;
     _xialaView.btn7.hidden=YES;
     _xialaView.btn8.hidden=YES;
     _xialaView.btn9.hidden=YES;
     _xialaView.btn10.hidden=YES;
     _xialaView.btn11.hidden=YES;
    
    [self.view addSubview:_xialaView];
    

}

//选中某一个下拉选项后处理事件
- (IBAction)XiaLaBtnClick:(id)sender {
    
    UIButton*btn=(UIButton*)sender;
    
    
    if ([btn.currentTitle containsString:@"团队"] || [btn.currentTitle containsString:@"企业"]   )
    {
        _textF2.text=btn.currentTitle;
    }else{
       _textF1.text=btn.currentTitle;
    }
    
    _xialaView.hidden=YES;
    
}

//对于选择文件，打开图库操作
- (IBAction)xuaWenJianBtnClick:(id)sender {
    
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
    self.imgView.image = info[UIImagePickerControllerOriginalImage];
}

//上传数据
- (IBAction)shenQingBtnClick:(id)sender {
    
    //5.2 实体入驻时文件上传
    //参数 NSData类型的文件数据,文件类型如jpg，png等
    //文件上传成功时返回ResourceId
    
    
    //??????????????????????????//////
    
    NSData*data=UIImageJPEGRepresentation(_imgView.image, 0.5);
    
    NSString*resourceIds=[BussinessApi shitiRuZhuFileup:data withType:@"jpg"];
    
    
    //5.3 实体入驻申请提交
    //参数为字典： businessline=电子信息 companyname=测试机构 contact=小明 contacttype=18576672852
    // description=初创团队
    // resourceids=597a213880ab5e6790d51fde,597a214a80ab5e6790d51fdf
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setObject:_textField1.text forKey:@"contact"];
    [dic setObject:_textField2.text forKey:@"contacttype"];
    [dic setObject:_textField3.text forKey:@"companyname"];
    [dic setObject:_textF1.text forKey:@"businessline"];
    [dic setObject:_textF2.text forKey:@"description"];
    [dic setObject:resourceIds forKey:@"resourceids"];
    
    int result=[BussinessApi shiTiRuZhuSubmitWithParam:dic];
    
    if (result==1) {
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:nil message:@"提交成功，请等待审核" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertCon animated:YES completion:^{
            
            [NSThread sleepForTimeInterval:0.5];
            [self dismissViewControllerAnimated:YES completion:^{
                
                [NSThread sleepForTimeInterval:0.3];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }];
 
    }else{
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:nil message:@"提交失败，请重新填写" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertCon animated:YES completion:^{
            [NSThread sleepForTimeInterval:0.5];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}












@end
