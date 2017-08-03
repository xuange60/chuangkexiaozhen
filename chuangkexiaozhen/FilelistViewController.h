//
//  FilelistViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "FilelistCell.h"
#import "xiazaiPhotoVC.h"

@interface FilelistViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableview;


@property (strong,nonatomic) NSArray* datas;
@property (strong,nonatomic) NSString* entityid;
@property (strong,nonatomic) NSString* type;

-(id) initView;

//entityid为记录id type为业务类型
-(id)initView:(NSString*) entityid withType:(NSString*)type;
@end
