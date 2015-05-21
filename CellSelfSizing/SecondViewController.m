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

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) IBSecondTableViewCell *ibPrototypeCell;
@property (nonatomic, strong) SecondTableViewCell *prototypeCell;

@end

@implementation SecondViewController

#pragma mark - viewDidLoad

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
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        return UITableViewAutomaticDimension;
    }
    
    Comment *comment = self.data[indexPath.row];
    
#ifdef USE_IB_CELL
    [self.ibPrototypeCell configureData:comment];
    [self.ibPrototypeCell setNeedsUpdateConstraints];
    [self.ibPrototypeCell updateConstraintsIfNeeded];
    self.ibPrototypeCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(self.ibPrototypeCell.bounds));
    return [self.ibPrototypeCell fittingCompressedHeight];
#else
    [self.prototypeCell configureData:comment];
    [self.prototypeCell setNeedsUpdateConstraints];
    [self.prototypeCell updateConstraintsIfNeeded];
    self.prototypeCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(self.prototypeCell.bounds));
    return [self.prototypeCell fittingCompressedHeight];
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
        [_tableView registerNib:[UINib nibWithNibName:@"IBSecondTableViewCell" bundle:nil] forCellReuseIdentifier:kIBSecondTableViewCellIdenitfier];
        [_tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:kSecondTableViewCellIdentifier];
    }
    
    return _tableView;
}

- (IBSecondTableViewCell *)ibPrototypeCell {
    if (!_ibPrototypeCell) {
        _ibPrototypeCell = [[[UINib nibWithNibName:@"IBSecondTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    }
    
    return _ibPrototypeCell;
}

- (SecondTableViewCell *)prototypeCell {
    if (!_prototypeCell) {
        _prototypeCell = [[SecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSecondTableViewCellIdentifier];
    }
    
    return _prototypeCell;
    
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
