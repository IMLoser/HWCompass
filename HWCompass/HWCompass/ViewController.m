//
//  ViewController.m
//  HWCompass
//
//  Created by 曹航玮 on 2016/12/23.
//  Copyright © 2016年 曹航玮. All rights reserved.
//

#import "ViewController.h"
#import "HWCompass.h"

@interface ViewController ()

/**
 *  指南针
 */
@property (nonatomic, weak) HWCompass * compass;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor blackColor];
    
    HWCompass * compass = [HWCompass getCompass];
    _compass = compass;
    compass.frame = CGRectMake(0, 0, 200, 200);
    compass.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    [self.view addSubview:compass];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_compass startUpdateHeading];
}

@end
