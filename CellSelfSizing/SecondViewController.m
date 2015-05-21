//
//  SecondViewController.m
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/14/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "SecondViewController.h"
#import "IBSecondTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UITableViewCell+CompressSize.h"
#import "Comment.h"
#import "Header.h"
#import "SecondTableViewCell.h"
#import "UITableView+CompressSize.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@end

@implementation SecondViewController

#pragma mark - viewDidLoad

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customizeDemand];
    [self addSubviews];
    [self makeConstraints];
}

- (void)customizeDemand {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"Reload" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleReload) forControlEvents:UIControlEventTouchDown];
        button;
    });
}

- (void)handleReload {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
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
    IBSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIBSecondTableViewCellIdenitfier forIndexPath:indexPath];
    [cell configureData:self.data[indexPath.row]];
    return cell;
#else
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSecondTableViewCellIdentifier forIndexPath:indexPath];
    [cell configureData:self.data[indexPath.row]];
    return cell;
#endif
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Comment *comment = self.data[indexPath.row];
    
#ifdef USE_IB_CELL
    return [tableView heightForReusableCellWithIdentifier:kIBSecondTableViewCellIdenitfier dataConfiguration:^(IBSecondTableViewCell *cell) {
        [cell configureData:comment];
    }];
#else
    return [tableView heightForReusableCellWithIdentifier:kSecondTableViewCellIdentifier dataConfiguration:^(SecondTableViewCell *cell) {
        [cell configureData:comment];
    }];
#endif
}


#pragma mark - Accessor

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
#ifdef USE_IB_CELL
        [_tableView registerNib:[UINib nibWithNibName:@"IBSecondTableViewCell" bundle:nil] forCellReuseIdentifier:kIBSecondTableViewCellIdenitfier];
#else
        [_tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:kSecondTableViewCellIdentifier];
#endif
    }
    
    return _tableView;
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
