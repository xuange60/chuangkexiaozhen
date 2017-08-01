//
//  ImgeUpViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"


@interface ImgeUpViewController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic) NSMutableString* resourceids;
@property (strong,nonatomic) NSMutableArray* images;

@property (strong,nonatomic) NSString* notifyname;
@property (strong,nonatomic) NSString* navigatitle;


@property (strong, nonatomic) IBOutlet UIImageView *iv1;

@property (strong, nonatomic) IBOutlet UIImageView *iv2;

@property (strong, nonatomic) IBOutlet UIImageView *iv3;




@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ind1;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ind2;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ind3;

//视图控制器生成后，在push后调用； name：通知name，title:导航项标题
-(void) setNotifyName:(NSString*)name AndTitle:(NSString*) title;


@end
