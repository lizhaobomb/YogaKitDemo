//
//  ShowTableViewCell.m
//  YogaKitDemo
//
//  Created by lizhao on 2017/7/19.
//  Copyright © 2017年 lizhao. All rights reserved.
//

#import "ShowTableViewCell.h"

@interface ShowTableViewCell ()

@end

@implementation ShowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:14.0];
        self.textLabel.numberOfLines = 2;
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.textLabel.minimumScaleFactor = 0.8;
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        
        UIImageView *accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        accessoryView.image = [UIImage imageNamed:@"download"];
        self.accessoryView = accessoryView;
        
        self.backgroundColor = [UIColor clearColor];
        self.separatorInset = UIEdgeInsetsZero;
    }
    return self;
}

- (void)setShow:(Show *)show {
    _show = show;
    self.textLabel.text = show.title;
    self.detailTextLabel.text = show.length;
    self.imageView.image = [UIImage imageNamed:show.image];
}

@end
