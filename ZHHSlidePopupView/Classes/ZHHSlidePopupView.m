//
//  ZHHSlidePopupView.m
//  ZHHAnneKitExample
//
//  Created by 桃色三岁 on 2022/8/19.
//  Copyright © 2022 桃色三岁. All rights reserved.
//

#import "ZHHSlidePopupView.h"

@interface ZHHSlidePopupView()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView *contentView;  // 弹出视图的内容视图
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;   // 点击手势
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;   // 拖拽手势

@property (nonatomic, weak) UIScrollView *scrollView;   // 当前被拖拽的UIScrollView
@property (nonatomic, assign) BOOL isDragScrollView;    // 是否正在拖拽UIScrollView
@property (nonatomic, assign) CGFloat lastTransitionY;  // 上一次拖拽的Y轴偏移量

@end

@implementation ZHHSlidePopupView

/// 创建并返回一个弹出视图实例
+ (instancetype)popupViewWithFrame:(CGRect)frame contentView:(UIView *)contentView {
    return [[self alloc] initWithFrame:frame contentView:contentView];
}

/// 初始化弹出视图
- (instancetype)initWithFrame:(CGRect)frame contentView:(UIView *)contentView {
    if (self = [super initWithFrame:frame]) {
        self.contentView = contentView;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        // 将内容视图放置在屏幕底部以外，初始状态不显示
        CGRect contentFrame = contentView.frame;
        contentFrame.origin.y = CGRectGetHeight(frame);
        self.contentView.frame = contentFrame;
        [self addSubview:self.contentView];
        
        // 添加点击和拖拽手势
        [self addGestureRecognizer:self.tapGesture];
        [self.contentView addGestureRecognizer:self.panGesture];
    }
    return self;
}

/// 显示弹出视图
- (void)showFrom:(UIView *)fromView completion:(void (^)(void))completion {
    [fromView addSubview:self];
    [self showWithCompletion:completion];
}

/// 显示内容视图的动画
- (void)showWithCompletion:(void (^)(void))completion {
    [UIView animateWithDuration:0.15f animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.y = CGRectGetHeight(self.frame) - CGRectGetHeight(frame);
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

/// 关闭弹出视图
- (void)dismiss:(void (^)(void))completion {
    [UIView animateWithDuration:0.15f animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.y = CGRectGetHeight(self.frame);
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (completion) completion();
    }];
}

#pragma mark - UIGestureRecognizerDelegate
/// 手势识别器是否应该接收触摸事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.panGesture) {
        UIView *touchView = touch.view;
        while (touchView) {
            if ([touchView isKindOfClass:[UIScrollView class]]) {
                self.scrollView = (UIScrollView *)touchView;
                self.isDragScrollView = YES;
                break;
            }
            if (touchView == self.contentView) {
                self.isDragScrollView = NO;
                break;
            }
            touchView = (UIView *)[touchView nextResponder];
        }
    }
    return YES;
}

/// 手势识别器是否应该开始识别手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.tapGesture) {
        CGPoint point = [gestureRecognizer locationInView:self.contentView];
        return ![self.contentView.layer containsPoint:point];
    }
    return YES;
}

/// 手势识别器是否可以与其他手势同时识别
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.panGesture) {
        if ([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - HandleGesture
/// 处理点击手势事件
- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    CGPoint point = [tapGesture locationInView:self.contentView];
    if (![self.contentView.layer containsPoint:point]) {
        [self dismiss:nil];
    }
}

/// 处理拖拽手势事件
- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    CGPoint translation = [panGesture translationInView:self.contentView];
    
    if (self.isDragScrollView && self.scrollView.contentOffset.y <= 0) {
        // 当 UIScrollView 滑动到顶部且向下拖拽时，允许拖拽视图
        if (translation.y > 0) {
            self.scrollView.contentOffset = CGPointZero;
            self.scrollView.panGestureRecognizer.enabled = NO;
            self.isDragScrollView = NO;
        }
    }
    
    if (!self.isDragScrollView) {
        // 控制内容视图的拖拽效果
        CGRect contentFrame = self.contentView.frame;
        contentFrame.origin.y = MIN(MAX(contentFrame.origin.y + translation.y, CGRectGetHeight(self.frame) - CGRectGetHeight(contentFrame)), CGRectGetHeight(self.frame));
        self.contentView.frame = contentFrame;
    }
    
    [panGesture setTranslation:CGPointZero inView:self.contentView];
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [panGesture velocityInView:self.contentView];
        self.scrollView.panGestureRecognizer.enabled = YES;
        
        // 当拖拽速度足够快且拖拽距离大于5时，关闭弹出视图
        if (velocity.y > 0 && self.lastTransitionY > 5) {
            [self dismiss:nil];
        } else {
            [self showWithCompletion:nil];
        }
    }
    
    self.lastTransitionY = translation.y;
}

#pragma mark - 懒加载
/// 懒加载点击手势
- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}

/// 懒加载拖拽手势
- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        _panGesture.delegate = self;
    }
    return _panGesture;
}

@end
