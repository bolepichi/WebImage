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
    

    
    
    
  
     _imageCache= [[SDImageCache sharedImageCache] initWithNamespace:@"imageCell"];
    
    
    

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
    
    cell.tapGetAImage =^(UIImage *image){
        
        UIImage *image2 = image;
        
        NSLog(@"%@",image2);
        
        
    };
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 192.0f;
}



@end
