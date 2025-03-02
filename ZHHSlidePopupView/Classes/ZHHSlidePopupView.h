//
//  ZHHSlidePopupView.h
//  ZHHAnneKitExample
//
//  Created by 桃色三岁 on 2022/8/19.
//  Copyright © 2022 桃色三岁. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// ZHHSlidePopupView - 支持通过拖拽关闭的弹出视图
@interface ZHHSlidePopupView : UIView
/// 创建并返回一个弹出视图实例
/// @param frame 弹出视图的框架
/// @param contentView 要显示的内容视图
/// @return 新创建的 ZHHSlidePopupView 实例
+ (instancetype)popupViewWithFrame:(CGRect)frame contentView:(UIView *)contentView;

/// 初始化弹出视图
/// @param frame 弹出视图的框架
/// @param contentView 要显示的内容视图
/// @return 初始化后的 ZHHSlidePopupView 实例
- (instancetype)initWithFrame:(CGRect)frame contentView:(UIView *)contentView;

/// 显示弹出视图
/// @param fromView 父视图，弹出视图将从该视图上显示
/// @param completion 显示完成后的回调
- (void)showFrom:(UIView *)fromView completion:(void (^)(void))completion;

/// 关闭弹出视图
/// @param completion 关闭完成后的回调（可选）
- (void)dismiss:(nullable void(^)(void))completion;
@end

NS_ASSUME_NONNULL_END
