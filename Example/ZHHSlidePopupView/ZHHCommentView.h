//
//  ZHHCommnetView.h
//  ZHHSlidePopupView
//
//  Created by 桃色三岁 on 03/02/2025.
//  Copyright (c) 2025 桃色三岁. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZHHCommentViewDelegate <NSObject>

- (void)closeComment;

@end

@interface ZHHCommentView : UIView

@property (nonatomic, weak) id<ZHHCommentViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
