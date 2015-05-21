//
//  UITableViewCell+CompressSize.m
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/10/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "UITableViewCell+CompressSize.h"

@implementation UITableViewCell (CompressSize)

- (CGFloat)fittingCompressedHeight {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    return [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1.0f;
}

@end
