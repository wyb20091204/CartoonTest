//
//  UIImageView+FailureImgView.m
//  CartoonTest
//
//  Created by 一波 on 2017/5/3.
//  Copyright © 2017年 一波. All rights reserved.
//

#import "UIImageView+FailureImgView.h"

@implementation UIImageView (FailureImgView)
- (void)show{
    self.image = [UIImage imageNamed:@"iv_not_loading_data"];
}
- (void)dismiss{
    self.image = [UIImage imageNamed:@""];
}
@end
