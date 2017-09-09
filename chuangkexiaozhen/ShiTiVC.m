//
//  ShiTiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/24.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ShiTiVC.h"
#import "ComboViewController.h"

@interface ShiTiVC ()

@end

@implementation ShiTiVC

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
       
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"实体入驻";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(shenQingBtnClick:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;

    
     [self shiTiRuZhuQuery];
    [self receiveCurrentViewController:self];
    
}

//对所属行业作出下拉选项
- (IBAction)btn1Click:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"电子信息",@"生物医药",@"新材料",@"互联网和移动互联网",@"先进制造",@"新能源及节能环保",@"科技服务业",@"农业科技",@"艺术文化",@"电子商务",@"创投孵化", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"行业类别";
    [self.navigationController pushViewController:vc animated:YES];


    
}
//对团队描述作出下拉选项
- (IBAction)btn2Click:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"初创团队",@"小微企业",@"加速企业", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"团队类别";
    [self.navigationController pushViewController:vc animated:YES];

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
    
    
    //??????????????????????????????????????????????????????????????????
    //5.2 实体入驻时文件上传
    //参数 NSData类型的文件数据,文件类型如jpg，png等
    //文件上传成功时返回ResourceId
    NSData*data=UIImageJPEGRepresentation(_imgView.image, 0.5);
    [self shitiRuZhuFileup:data withType:@"jpg"];

}

//上传数据
- (IBAction)shenQingBtnClick:(id)sender {
    //5.3 实体入驻申请提交
    //参数为字典： businessline=电子信息 companyname=测试机构 contact=小明 contacttype=18576672852
    // description=初创团队
    // resourceids=597a213880ab5e6790d51fde,597a214a80ab5e6790d51fdf
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setNotNullStrObject:_textField1.text forKey:@"contact"];
    [dic setNotNullStrObject:_textField2.text forKey:@"contacttype"];
    [dic setNotNullStrObject:_textField3.text forKey:@"companyname"];
    [dic setNotNullStrObject:_btn1.currentTitle forKey:@"businessline"];
    [dic setNotNullStrObject:_btn2.currentTitle forKey:@"description"];
    if(_resourceID==nil){
        _resourceID=@"";
    }
    [dic setNotNullStrObject:_resourceID forKey:@"resourceids"];
    
    [self shiTiRuZhuSubmitWithParam:dic];
    
}




//实体入驻查询
//如果用户未提交过申请，不可以查到申请记录；用户层申请过申请，可以查到已提交的数据
/*如查询到记录时，返回字典数据可能为：
 {"resourceIds" : "","contact" : "张玄","companyName" : "测试机构","description" : "初创团队","contactType" : "18576672852","applyStatus" : "通过","businessline" : "电子信息"}
 入未查询到数据，字典数据为空；
 */
-(void) shiTiRuZhuQuery
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/apply/add"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSLog(@"%@",[[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding]);
        if([contenttype containsString:@"html"])
        {
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//input"];
            NSMutableDictionary* dic=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays)
            {
                NSString * idstr=[ele objectForKey:@"id"];
                NSString* value=[ele objectForKey:@"value"];
                if(idstr!=nil && value!=nil){
                    [dic setObject:value forKey:idstr];
                }
            }
            

            
            
            //字典NSMutableDictionary* dic包含了查询到的数据
            //打印查询到的数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            if([dic objectNotNullForKey:@"submit"].length>0){
                dic=nil;
            }
            
            if (dic==nil) {
                _view4.hidden=YES;
                _view3.hidden=NO;
                self.navigationItem.rightBarButtonItem=self.rightbutton;
            }else{
                
                _textField1.text=[dic objectNotNullForKey:@"contact"];
                _textField2.text=[dic objectNotNullForKey:@"contactType"];
                _textField3.text=[dic objectNotNullForKey:@"companyName"];
                [_btn1 setTitle:[dic objectNotNullForKey:@"businessline"] forState:UIControlStateNormal];
                [_btn2 setTitle:[dic objectNotNullForKey:@"description"] forState:UIControlStateNormal];
                _statueF.text=[dic objectNotNullForKey:@"applyStatus"];
                [_textField1 setUserInteractionEnabled:NO];
                [_textField2 setUserInteractionEnabled:NO];
                [_textField3 setUserInteractionEnabled:NO];
                [_btn1 setUserInteractionEnabled:NO];
                [_btn2 setUserInteractionEnabled:NO];
                [_statueF setUserInteractionEnabled:NO];
                _view3.hidden=YES;
                _btn3.hidden=YES;
                _btn4.hidden=YES;
                
                _view4.hidden=NO;
                
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


//参数 NSData类型的文件数据,文件类型如jpg，png等
//文件上传成功时返回ResourceId
-(void) shitiRuZhuFileup:(NSData*) filedata withType:(NSString*)type
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"实体入驻_%@.%@", str,type];
    NSLog(@"%@",fileName);
    
    NSDictionary *dict = [NSDictionary dictionary];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"],@"/upload/save"];
    
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
    NSLog(@"%@",ResourceId);
    if(_resourceID==nil || [_resourceID length]<2){
        _resourceID=ResourceId;
    }else{
        _resourceID=[NSString stringWithFormat:@"%@,%@",_resourceID,ResourceId];
    }
    
    
}failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
    // 请求失败
    NSLog(@"请求失败：%@", error);
}];
}


- (IBAction)shangchuan:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ShiTiVCFileUp" AndTitle:@"上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ShiTiVCFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}

-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        
        _resourceID=(NSString*)tmp.object;
    }
    
}


-(void) shiTiRuZhuSubmitWithParam:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:param];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/apply/save"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            NSLog(@"%d",result);
            //result: 1,实体入驻提交成功 不等于1,则提交失败
           
            if (result==1) {
                [self tiShiKuangDisplay:@"提交成功" viewController:self];
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


@end
