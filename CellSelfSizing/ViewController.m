//
//  ViewController.m
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/9/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "TableViewCell.h"
#import "Comment.h"
#import "IBTableViewCell.h"

//#define USE_IB_CELL

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) IBTableViewCell *ibTableViewCellPrototype;
@property (nonatomic, strong) TableViewCell *tableViewCellPrototype;
@property (nonatomic, strong) NSArray *data;
@end

@implementation ViewController


- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customizeDemand];
    [self addSubviews];
    [self makeConstraints];
}


#pragma mark - viewDidLoad

- (void)customizeDemand {
    
}

- (void)addSubviews {
    [self.view addSubview:self.tableView];
}

- (void)makeConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#ifdef USE_IB_CELL
    IBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIBTableViewCellIdentifier forIndexPath:indexPath];
#else
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
#endif
    
    [cell configureData:self.data[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        return UITableViewAutomaticDimension;
    }

    Comment *comment = self.data[indexPath.row];
    
#ifdef USE_IB_CELL
    [self.ibTableViewCellPrototype configureData:comment];
    [self.ibTableViewCellPrototype setNeedsLayout];
    [self.ibTableViewCellPrototype layoutIfNeeded];
    
    CGSize size = [self.ibTableViewCellPrototype.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"%@", NSStringFromCGSize(size));
    return size.height + 1;
#else
    [self.tableViewCellPrototype configureData:comment];
    
    [self.tableViewCellPrototype setNeedsLayout];
    [self.tableViewCellPrototype layoutIfNeeded];
    
    CGSize size = [self.tableViewCellPrototype.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    NSLog(@"%@", NSStringFromCGSize(size));
    
    return size.height + 1;
#endif
}


#pragma mark - Accessor

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 300;
#ifdef USE_IB_CELL
        [_tableView registerNib:[UINib nibWithNibName:@"IBTableViewCell" bundle:nil] forCellReuseIdentifier:kIBTableViewCellIdentifier];
#else
        [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
#endif
        
    }
    
    return _tableView;
}

- (IBTableViewCell *)ibTableViewCellPrototype {
    if (!_ibTableViewCellPrototype) {
        _ibTableViewCellPrototype = [[[UINib nibWithNibName:@"IBTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    }
    
    return _ibTableViewCellPrototype;
}

- (TableViewCell *)tableViewCellPrototype {
    if (!_tableViewCellPrototype) {
        _tableViewCellPrototype = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewCellIdentifier];
    }
    
    return _tableViewCellPrototype;
}

- (NSArray *)data {
    if (!_data) {
        NSMutableArray *arr = [NSMutableArray new];
        for (int i = 0; i < 100; i++) {
            Comment *comment = [Comment commentInstance];
            [arr addObject:comment];
        }
        _data = [NSArray arrayWithArray:arr];
    }
    
    return _data;
}

@end
