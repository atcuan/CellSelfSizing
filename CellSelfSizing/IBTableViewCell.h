//
//  IBTableViewCell.h
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/9/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kIBTableViewCellIdentifier;
@class Comment;


@interface IBTableViewCell : UITableViewCell

- (void)configureData:(Comment *)data;

@end
