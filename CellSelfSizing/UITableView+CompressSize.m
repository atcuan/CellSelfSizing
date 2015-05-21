//
//  UITableView+CompressSize.m
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/21/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "UITableView+CompressSize.h"
#import "UITableViewCell+CompressSize.h"

@implementation UITableView (CompressSize)

- (CGFloat)heightForReusableCellWithIdentifier:(NSString *)identifier dataConfiguration:(void (^)(id cell))dataConfiguration {
    return [self heightForReusableCellWithIdentifier:identifier preferredMaxLayoutWidth:CGRectGetWidth(self.bounds) dataConfiguration:dataConfiguration];
}

- (CGFloat)heightForReusableCellWithIdentifier:(NSString *)identifier preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth dataConfiguration:(void (^)(id cell))dataConfiguration {
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    NSAssert(nil != cell, @"Cell must be registered to table view for identifier - %@", identifier);
    [cell prepareForReuse];
    dataConfiguration(cell);
    // Important
    cell.bounds = CGRectMake(0.0f, 0.0f, preferredMaxLayoutWidth, CGRectGetHeight(cell.bounds));
    return [cell fittingCompressedHeight];
}

@end
