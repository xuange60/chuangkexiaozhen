//
//  AddBiSaiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface AddBiSaiVC : BaseViewController<UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *bisaiName;

@property (strong, nonatomic) IBOutlet UITextField *rongyuName;

@property (strong, nonatomic) IBOutlet UITextField *zuzhijigouName;

@property (strong, nonatomic) IBOutlet UIButton *CompleteLevelBtn;

@property (strong, nonatomic) IBOutlet UIButton *prizeAwardsBtn;

@property (strong, nonatomic) IBOutlet UIView *myView;

@property(nonatomic,strong)NSMutableString*Mstr;
@property(nonatomic,strong) UIImageView*imgView;
@property(nonatomic,strong)NSMutableArray*mArray;

@property(nonatomic,strong)NSString*photosIDS;

- (IBAction)BiSaiLevelCkicl:(id)sender forEvent:(UIEvent *)event;

- (IBAction)MingCiCkick:(id)sender forEvent:(UIEvent *)event;







@end
