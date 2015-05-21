//
//  UITableView+CompressSize.h
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/21/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CompressSize)

- (CGFloat)heightForReusableCellWithIdentifier:(NSString *)identifier dataConfiguration:(void (^)(id cell))dataConfiguration;
- (CGFloat)heightForReusableCellWithIdentifier:(NSString *)identifier preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth dataConfiguration:(void (^)(id cell))dataConfiguration;

@end
