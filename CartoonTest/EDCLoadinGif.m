//
//  EDCLoadinGif.m
//  EverydayCoach
//
//  Created by 一波 on 2017/4/20.
//  Copyright © 2017年 jiaheng. All rights reserved.
//

#import "EDCLoadinGif.h"
#import <Masonry.h>

@interface EDCLoadinGif ()
@property (nonatomic) UIImageView *lodingImgView;
@end



@implementation EDCLoadinGif

+ (EDCLoadinGif *)sharedView {
    static dispatch_once_t once;
    static EDCLoadinGif *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[EDCLoadinGif alloc] init];
    });
    return sharedView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return self;
}


- (UIImageView *)lodingImgView{
    if (!_lodingImgView) {
        __weak __typeof(self)weakself = self;
        _lodingImgView = [[UIImageView alloc] init];
        [self addSubview:_lodingImgView];
        
        [_lodingImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakself);
        }];
        NSMutableArray *gifImages = @[].mutableCopy;
        for (int i = 1; i < 7; i ++) {
            NSString *imgName = [NSString stringWithFormat:@"loading%d",i];
            [gifImages addObject:[UIImage imageNamed:imgName]];
        }
        if (gifImages.count > 0) {
            _lodingImgView.animationImages = gifImages;
            _lodingImgView.animationDuration = 0.5;
        }else{
            NSAssert(false, @"no iamges");
        }
    }
    return _lodingImgView;
}

+ (void)show{
    [[self sharedView] showWithMaskType:EDCLodingMaskTypeNone];
}

+ (void)showWithMaskType:(EDCLodingMaskType)type{
    [[self sharedView] showWithMaskType:type];
}


- (void)showWithMaskType:(EDCLodingMaskType)type{
    UIColor *backgroundColor;
    if (type == EDCLodingMaskTypeNone) {
        self.userInteractionEnabled = NO;
        backgroundColor = [UIColor clearColor];
    }
    if (type == EDCLodingMaskTypeBlack) {
        self.userInteractionEnabled = YES;
        backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    }
    self.backgroundColor = backgroundColor;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self.superview bringSubviewToFront:self];
    [self.lodingImgView startAnimating];
}
// 暂未实现
+ (void)showWithCenter:(CGPoint)point maskType:(EDCLodingMaskType)type{

}


+ (void)dismiss{
    [[self sharedView].lodingImgView stopAnimating];
    [self sharedView].backgroundColor = [UIColor clearColor];
    [[self sharedView] removeFromSuperview];
}
+ (void)dismissWithDelay:(CGFloat)delayInSeconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
