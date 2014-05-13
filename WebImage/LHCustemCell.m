//
//  LHCustemCell.m
//  WebImage
//
//  Created by Taagoo'iMac on 14-5-7.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHCustemCell.h"

@implementation LHCustemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)reigstTapGuest
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getImageOFTap)];
    
    [self.image addGestureRecognizer:tapGesture];
}

-(void)getImageOFTap{
     _tapGetAImage (self.image.image);
}

@end
