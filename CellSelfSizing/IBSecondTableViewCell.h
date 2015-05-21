//
//  SecondTableViewCell.h
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/14/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kIBSecondTableViewCellIdenitfier;

@class Comment;

@interface IBSecondTableViewCell : UITableViewCell

- (void)configureData:(Comment *)data;

@end
