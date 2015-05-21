//
//  TableViewCell.m
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/9/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "TableViewCell.h"
#import "Comment.h"
#import <Masonry/Masonry.h>

NSString * const kTableViewCellIdentifier = @"TableViewCell";

@interface TableViewCell ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }

    self.avatarImageView.backgroundColor = [TableViewCell chx_randomRGBColor];
    
    [self addSubviews];
    [self makeConstraints];
    
    return self;
}

- (void)addSubviews {
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.commentLabel];
}

- (void)makeConstraints {
    UIView *superview = self.contentView;
    CGFloat padding = 8;
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(superview).offset(padding);
        make.width.equalTo(@40);
        make.width.equalTo(self.avatarImageView.mas_height);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(padding);
        make.top.equalTo(superview).offset(padding);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superview).offset(-padding);
        make.top.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(padding);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(padding);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.right.equalTo(superview).offset(-padding);
        make.bottom.equalTo(superview).offset(-padding).priority(999);
        make.bottom.greaterThanOrEqualTo(self.avatarImageView.mas_bottom);
    }];
    
    MASAttachKeys(superview, self.avatarImageView, self.nameLabel, self.timeLabel, self.commentLabel);

}

- (void)layoutSubviews {
    NSLog(@"%s", __FUNCTION__);
    
    [super layoutSubviews];

    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.commentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.commentLabel.bounds);
    self.avatarImageView.layer.cornerRadius = CGRectGetWidth(self.avatarImageView.bounds) / 2;
}

- (void)updateConstraints {
    NSLog(@"%s", __FUNCTION__);
    [super updateConstraints];
}

#pragma mark -

- (void)configureData:(Comment *)data {
    self.nameLabel.text = data.name;
    self.timeLabel.text = data.time;
    self.commentLabel.text = data.comment;
    self.avatarImageView.image = [UIImage imageNamed:@"valar"];
}

#pragma mark - Accessor

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [UIImageView new];
        _avatarImageView.layer.masksToBounds = YES;
    }
    
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.backgroundColor = [UIColor yellowColor];
    }
    
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.backgroundColor = [UIColor blueColor];
    }
    
    return _timeLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [UILabel new];
        _commentLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        _commentLabel.textColor = [UIColor grayColor];
        _commentLabel.backgroundColor = [UIColor cyanColor];
        _commentLabel.numberOfLines = 0;
    }
    
    return _commentLabel;
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
