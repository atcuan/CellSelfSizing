//
//  IBTableViewCell.m
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/9/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "IBTableViewCell.h"
#import "Comment.h"

NSString * const kIBTableViewCellIdentifier = @"IBTableViewCell";

@interface IBTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *commentLabel;

@end

@implementation IBTableViewCell

- (void)awakeFromNib {
    self.commentLabel.numberOfLines = 0;
    
    self.avatarImageView.backgroundColor = [IBTableViewCell chx_randomRGBColor];
    self.avatarImageView.layer.cornerRadius = CGRectGetWidth(self.avatarImageView.bounds) / 2;
    self.avatarImageView.layer.masksToBounds = YES;
    
    self.nameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    self.timeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    self.commentLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    
    self.commentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.commentLabel.bounds);
//    NSLog(@"self.commentLabel: %@", NSStringFromCGRect(self.commentLabel.frame));
}

- (void)configureData:(Comment *)data {
    self.nameLabel.text = data.name;
    self.timeLabel.text = data.time;
    self.commentLabel.text = data.comment;
    self.avatarImageView.image = [UIImage imageNamed:@"valar"];    
}
#pragma mark - Helpers

+ (UIColor *)chx_randomRGBColor {
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        // srandom()这个函数是初始化随机数产生器
        srandom((unsigned)time(NULL));
    }
    // random()函数产生随即值
    CGFloat red   = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue  = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
