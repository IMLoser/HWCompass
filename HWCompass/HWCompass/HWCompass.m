//
//  HWCompass.m
//  HWCompass
//
//  Created by 曹航玮 on 2016/12/23.
//  Copyright © 2016年 曹航玮. All rights reserved.
//

#import "HWCompass.h"
#import <CoreLocation/CoreLocation.h>

@interface HWCompass () <CLLocationManagerDelegate>

/** 指南针视图 */
@property (nonatomic, weak) UIImageView * compassView;

/** 定位管理者 */
@property (strong, nonatomic) CLLocationManager * clManager;

@end

@implementation HWCompass

#pragma mark - lazy
- (CLLocationManager *)clManager
{
    if (!_clManager) {
        _clManager = [[CLLocationManager alloc] init];
        _clManager.delegate = self;
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [_clManager requestAlwaysAuthorization];
        }
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
            [_clManager allowsBackgroundLocationUpdates];
        }
        
    }
    return _clManager;
}

+ (instancetype)getCompass
{
    HWCompass * compass = [[HWCompass alloc] init];
    compass.backgroundColor = [UIColor clearColor];
    return compass;
}

- (void)startUpdateHeading
{
    [self.clManager startUpdatingHeading];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initailSetting];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initailSetting];
}

- (void)initailSetting
{
    UIImageView * compassView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compass"]];
    _compassView = compassView;
    [self addSubview:compassView];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 长宽相等
        CGRect tmpFrame = self.frame;
        tmpFrame.size.height = tmpFrame.size.width;
        self.frame = tmpFrame;
        
        // 设置指南针视图
        _compassView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
    });
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {

    [UIView animateWithDuration:0.1 animations:^{
        _compassView.transform = CGAffineTransformMakeRotation(M_PI * 2 - M_PI / 180 * newHeading.magneticHeading);
    }];
}

@end
