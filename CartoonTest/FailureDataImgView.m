//
//  FailureDataImgView.m
//  CartoonTest
//
//  Created by 一波 on 2017/5/3.
//  Copyright © 2017年 一波. All rights reserved.
//

#import "FailureDataImgView.h"
#import <Masonry.h>
# define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
# define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FailureDataImgView ()
@property (nonatomic) UIImageView *failureImgView;

@end

@implementation FailureDataImgView


+ (instancetype)shareFailureImgView{
    static dispatch_once_t once;
    static FailureDataImgView *view;
    dispatch_once(&once, ^ {
        view = [[FailureDataImgView alloc] init];
    });
    return view;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self setSubviews];
    }
    return self;
}
- (void)setSubviews{
    if (!_failureImgView) {
        _failureImgView = [[UIImageView alloc] init];
        [self addSubview:_failureImgView];
        __weak __typeof(self)weakself = self;
        [_failureImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakself);
        }];
        _failureImgView.image = [UIImage imageNamed:@"iv_not_loading_data"];
    }
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self.superview bringSubviewToFront:self];
}
- (void)dismiss{
    [self removeFromSuperview];
}

@end
