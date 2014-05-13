//
//  LHBigImageViewController.m
//  WebImage
//
//  Created by Taagoo'iMac on 14-5-8.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHBigImageViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface LHBigImageViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

static CGPoint point;

@implementation LHBigImageViewController
{
    NSArray  * _imagesArray;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imagesArray = @[@"http://a3.att.hudong.com/88/25/19300500337403133540252738114_950.jpg",
                     @"http://www.chinadaily.com.cn/hqylss/att/site1/20060312/xin_4303031201325821522614.jpg",
                     @"http://pic.4j4j.cn/upload/pic/20130401/9cb22047c4.jpg",
                     @"http://pic.4j4j.cn/upload/pic/20130401/a035650ef6.jpg",
                     @"http://www.qupu123.com/Public/Uploads/geshou/%D5%C5%B9%FA%C8%D9.jpg",
                     @"http://gameonline.yesky.com/cmsimagelist/2008/092/p612j55673go.jpg"];
    
    
    
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[_imagesArray objectAtIndex:0]];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 310, self.scrollView.bounds.size.height * (310/image.size.height))];
    
    imageview.center = CGPointMake(320*0.5, (self.scrollView.bounds.size.height-64)*0.5 );
    
    
    [imageview setImage:image];
    
    [self.scrollView setContentSize:CGSizeMake(310, imageview.bounds.size.height)];
    
    [self.scrollView addSubview:imageview];
    
    
    [_scrollView setMinimumZoomScale:1.0];
    
    [_scrollView setMaximumZoomScale:3.0];
    


    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenNavgationbar)];
    
    [self.scrollView addGestureRecognizer:tapGesture];
    
}



-(void)hidenNavgationbar{
    
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
}



-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView.subviews lastObject];
}


-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [scrollView setContentOffset:CGPointMake(point.x*scale, point.y*scale)];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    point = scrollView.contentOffset;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
