//
//  HWCompass.h
//  HWCompass
//
//  Created by 曹航玮 on 2016/12/23.
//  Copyright © 2016年 曹航玮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWCompass : UIView

// 获得指南针
+ (instancetype)getCompass;

// 开始获取方向
- (void)startUpdateHeading;

@end
