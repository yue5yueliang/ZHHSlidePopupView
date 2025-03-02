//
//  ZHHViewController.m
//  ZHHSlidePopupView
//
//  Created by 桃色三岁 on 03/02/2025.
//  Copyright (c) 2025 桃色三岁. All rights reserved.
//

#import "ZHHViewController.h"
#import "ZHHCommentView.h"
#import <ZHHSlidePopupView/ZHHSlidePopupView.h>

@interface ZHHViewController () <ZHHCommentViewDelegate>

@property (nonatomic, strong) ZHHSlidePopupView *popupView;
@end

@implementation ZHHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZHHCommentView *commentView = [ZHHCommentView new];
    commentView.frame = CGRectMake(0, 0, self.view.frame.size.width, 500);
    commentView.delegate = self;
    ZHHSlidePopupView *popupView = [ZHHSlidePopupView popupViewWithFrame:[UIScreen mainScreen].bounds contentView:commentView];
    self.popupView = popupView;
    [popupView showFrom:self.view.window completion:^{

    }];
}

- (void)closeComment {
    [self.popupView dismiss:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
