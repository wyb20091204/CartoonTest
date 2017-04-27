//
//  EDCLoadinGif.h
//  EverydayCoach
//
//  Created by 一波 on 2017/4/20.
//  Copyright © 2017年 jiaheng. All rights reserved.
//


/*
 * 暂时有个缺陷，EDCLodingMaskTypeNone的时候，没法在页面返回的时候，dismiss
 *
 */

#import <UIKit/UIKit.h>
# define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
# define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height



typedef NS_ENUM(NSUInteger, EDCLodingMaskType) {
    EDCLodingMaskTypeNone = 1,
    EDCLodingMaskTypeBlack
};


@interface EDCLoadinGif : UIView
+ (void)show;
+ (void)showWithMaskType:(EDCLodingMaskType)type;
+ (void)showErrorWithStatus:(NSString *)status;
/**
  * 暂未实现
  */
+ (void)showWithCenter:(CGPoint)point maskType:(EDCLodingMaskType)type;

+ (void)dismiss;
+ (void)dismissWithDelay:(CGFloat)delayInSeconds;

@end
