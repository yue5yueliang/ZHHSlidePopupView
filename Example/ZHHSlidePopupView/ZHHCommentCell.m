//
//  ZHHCommentCell.m
//  ZHHSlidePopupView
//
//  Created by 桃色三岁 on 03/02/2025.
//  Copyright (c) 2025 桃色三岁. All rights reserved.
//

#import "ZHHCommentCell.h"

@interface ZHHCommentCell ()

@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation ZHHCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.commentLabel = [[UILabel alloc] initWithFrame:self.frame];
        [self.contentView addSubview:self.commentLabel];
        self.commentLabel.text = @"这是一条评论";
    }
    return self;
}



@end
