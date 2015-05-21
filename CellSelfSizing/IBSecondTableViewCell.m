//
//  SecondTableViewCell.m
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/14/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "IBSecondTableViewCell.h"
#import "Comment.h"

NSString * const kIBSecondTableViewCellIdenitfier = @"IBSecondTableViewCell";

@interface IBSecondTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation IBSecondTableViewCell

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)awakeFromNib {
    // Initialization code
    self.descriptionLabel.numberOfLines = 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.descriptionLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.descriptionLabel.bounds);
//    NSLog(@"%@", NSStringFromCGRect(self.descriptionLabel.frame));
    
//    [super layoutSubviews];    
}

- (void)updateConstraints {
    self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
    
    [super updateConstraints];
}


- (void)configureData:(Comment *)data {
    self.titleLabel.text = data.name;
    self.descriptionLabel.text = data.comment;
}


@end
