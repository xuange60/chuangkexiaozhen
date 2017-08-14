//
//  DetailYuanQuRenWuVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YuanQuRenWuTongGao.h"
@interface DetailYuanQuRenWuVC : BaseViewController<BussinessApiDelegate>


-(void)setStrId:(NSString*)strId  dict:(NSDictionary*)dic;
@property(nonatomic,strong)NSString*strID;
@property(nonatomic,strong)YuanQuRenWuTongGao*tonggao;
@property(nonatomic,strong)NSDictionary*dic;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *type;

@property (strong, nonatomic) IBOutlet UILabel *chengdu;

@property (strong, nonatomic) IBOutlet UILabel *person;

@property (strong, nonatomic) IBOutlet UITextView *content;



@property (strong, nonatomic) IBOutlet UILabel *time;








@end
