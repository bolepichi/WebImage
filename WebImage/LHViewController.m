//
//  LHViewController.m
//  WebImage
//
//  Created by Taagoo'iMac on 14-5-7.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHViewController.h"
#import "LHCustemCell.h"

#import <SDWebImage/UIImageView+WebCache.h>





@interface LHViewController ()

@property (nonatomic , strong)NSArray *imageUrls;

@property (nonatomic ,strong)SDImageCache *imageCache;

@end

@implementation LHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _imageUrls = @[@"http://a3.att.hudong.com/88/25/19300500337403133540252738114_950.jpg",
                   @"http://www.chinadaily.com.cn/hqylss/att/site1/20060312/xin_4303031201325821522614.jpg",
                   @"http://pic.4j4j.cn/upload/pic/20130401/9cb22047c4.jpg",
                   @"http://pic.4j4j.cn/upload/pic/20130401/a035650ef6.jpg",
                   @"http://www.qupu123.com/Public/Uploads/geshou/%D5%C5%B9%FA%C8%D9.jpg",
                   @"http://gameonline.yesky.com/cmsimagelist/2008/092/p612j55673go.jpg"];
    
    
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    
    [refreshButton addTarget:self.tableView action:@selector(reloadData) forControlEvents:UIControlEventTouchUpInside];
    
    [refreshButton setFrame:CGRectMake(0, 0, 60, 40)];
    
 
    
    
    
    UIButton *cleanCacheButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [cleanCacheButton setTitle:@"清楚缓存" forState:UIControlStateNormal];
    
    [cleanCacheButton addTarget:self action:@selector(Clean) forControlEvents:UIControlEventTouchUpInside];
    
    [cleanCacheButton setFrame:CGRectMake(0, 0, 60, 40)];
    
    
    
    
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:refreshButton];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:cleanCacheButton];
    
    [self.navigationItem setRightBarButtonItems:@[leftItem,rightItem] animated:YES];

    
  
     _imageCache= [[SDImageCache sharedImageCache] initWithNamespace:@"imageCell"];
    
    
}


-(void)Clean{

    
    
    [_imageCache clearDisk];
    
   // [_imageCache clearMemory];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}



#pragma mark -UITableViewDataSource Methods


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _imageUrls.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"imageCell";
    
    LHCustemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    NSString *imageUrlString = [_imageUrls objectAtIndex:indexPath.row];
    
    
    NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
 
    
    [_imageCache queryDiskCacheForKey:imageUrlString done:^(UIImage *image, SDImageCacheType cacheType) {
        
        // 1.检查缓存中是否由已存在图片
        
        if (!image) {
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; //显示请求指示标
            
            [cell.image setImageWithURL:imageUrl
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              completed:^(UIImage *image,
                                          NSError *error,
                                          SDImageCacheType cacheType) {
                                  
                                  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //隐藏
                                  
                                  [_imageCache storeImage:image forKey:imageUrlString];
                                  
                              }];
        }
        else
        {
            [cell.image setImage:image];
        }
        
    }];
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 192.0f;
}

@end
