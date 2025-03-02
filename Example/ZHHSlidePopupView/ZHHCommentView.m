//
//  ZHHCommnetView.m
//  ZHHSlidePopupView
//
//  Created by 桃色三岁 on 03/02/2025.
//  Copyright (c) 2025 桃色三岁. All rights reserved.
//

#import "ZHHCommentView.h"
#import "ZHHCommentCell.h"

static NSString *const commentCellIdentifier = @"commentCellIdentifier";

@interface ZHHCommentView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZHHCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setupBaseView];
    }
    return self;
}

- (void)setupBaseView {
    self.backgroundColor = [UIColor whiteColor];

    // 关闭按钮
    UIButton *closeBtn = [[UIButton alloc] init];
    [self addSubview:closeBtn];
    closeBtn.backgroundColor = [UIColor redColor];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeComment) forControlEvents:UIControlEventTouchUpInside];
    
    closeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [closeBtn.topAnchor constraintEqualToAnchor:self.topAnchor],
        [closeBtn.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [closeBtn.widthAnchor constraintEqualToConstant:50],
        [closeBtn.heightAnchor constraintEqualToConstant:40]
    ]];

    // 表格视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self addSubview:tableView];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[ZHHCommentCell class] forCellReuseIdentifier:commentCellIdentifier];
    
    [NSLayoutConstraint activateConstraints:@[
        [tableView.topAnchor constraintEqualToAnchor:closeBtn.bottomAnchor],
        [tableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [tableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [tableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];

    self.tableView = tableView;
}

- (void)closeComment {
    if([self.delegate respondsToSelector:@selector(closeComment)]) {
        [self.delegate closeComment];
    }
}

#pragma mark - UITableViewDataSource && UITableVideDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHHCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellIdentifier forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
