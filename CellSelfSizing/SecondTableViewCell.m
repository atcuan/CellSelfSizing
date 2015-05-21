//
//  SecondTableViewCell.m
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/14/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "SecondTableViewCell.h"

#import <Masonry/Masonry.h>
#import "Comment.h"

NSString * const kSecondTableViewCellIdentifier = @"SecondTableViewCell";

@interface SecondTableViewCell ()
@property (strong, nonatomic) UIView *topItemBackgroundView;
@property (strong, nonatomic) UIView *tagImageContainerView;
@property (strong, nonatomic) UILabel *descripitonLabel;
@property (strong, nonatomic) UIView *likedPeoplesView;
@property (strong, nonatomic) UIView *actionsView;
@end


@implementation SecondTableViewCell

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    [self addSubviews];
    
    [self makeConstraints];
    
    [self bindReactiveSignals];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.descripitonLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.descripitonLabel.bounds);
}

- (void)addSubviews {
    [self.contentView addSubview:self.topItemBackgroundView];
    [self.contentView addSubview:self.tagImageContainerView];
    [self.contentView addSubview:self.descripitonLabel];
    [self.contentView addSubview:self.likedPeoplesView];
    [self.contentView addSubview:self.actionsView];
}

- (void)makeConstraints {
    UIView *superView = self.contentView;
    CGFloat padding = 8;
    
    [self.topItemBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(superView).insets(UIEdgeInsetsZero);
        make.height.equalTo(@68);
    }];
    
    [self.tagImageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topItemBackgroundView.mas_bottom);
        make.left.and.right.equalTo(superView).insets(UIEdgeInsetsZero);
        make.height.equalTo(self.tagImageContainerView.mas_width).priorityHigh();
    }];
    
    [self.descripitonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(superView).insets(UIEdgeInsetsMake(0, padding, 0, padding));
        make.top.equalTo(self.tagImageContainerView.mas_bottom).offset(padding);
    }];
    
    [self.likedPeoplesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descripitonLabel.mas_bottom).offset(padding);
        make.left.and.right.equalTo(superView).insets(UIEdgeInsetsZero);
        make.height.equalTo(@40);
    }];
    
    [self.actionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.likedPeoplesView.mas_bottom);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@35);
        make.bottom.equalTo(superView).offset(-padding);
    }];
}

- (void)bindReactiveSignals {
    
}

#pragma mark -  Configure data

- (void)configureData:(Comment *)data {
    self.descripitonLabel.text = data.comment;
}

#pragma mark -  Accessor

- (UIView *)topItemBackgroundView {
    if (!_topItemBackgroundView) {
        _topItemBackgroundView = [UIView new];
        _topItemBackgroundView.backgroundColor = [UIColor redColor];
    }
    
    return _topItemBackgroundView;
}

- (UIView *)tagImageContainerView {
    if (!_tagImageContainerView) {
        _tagImageContainerView = [UIView new];
        _tagImageContainerView.backgroundColor = [UIColor cyanColor];
    }
    
    return _tagImageContainerView;
}

- (UILabel *)descripitonLabel {
    if (!_descripitonLabel) {
        _descripitonLabel = [UILabel new];
        _descripitonLabel.backgroundColor = [UIColor purpleColor];
        _descripitonLabel.numberOfLines = 0;
    }
    
    return _descripitonLabel;
}

- (UIView *)likedPeoplesView {
    if (!_likedPeoplesView) {
        _likedPeoplesView = [UIView new];
        _likedPeoplesView.backgroundColor = [UIColor blueColor];
    }
    return _likedPeoplesView;
}

- (UIView *)actionsView {
    if (!_actionsView) {
        _actionsView = [UIView new];
        _actionsView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _actionsView;
}

@end
