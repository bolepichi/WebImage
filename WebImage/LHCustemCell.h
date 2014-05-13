//
//  LHCustemCell.h
//  WebImage
//
//  Created by Taagoo'iMac on 14-5-7.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef  void (^TapImage)(UIImage * image);


@interface LHCustemCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *image;


@property (nonatomic, copy) TapImage tapGetAImage;


@end
