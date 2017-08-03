//
//  xiazaiPhotoVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "xiazaiPhotoVC.h"

@interface xiazaiPhotoVC ()

@end

@implementation xiazaiPhotoVC



-(void)setData:(NSData *)data
{
    _imgdata=data;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"下载";
    _imgView.image= [UIImage imageWithData:_imgdata];
 
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imgView;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    
    [_imgView setCenter:CGPointMake(xcenter, ycenter)];
    
}


@end
