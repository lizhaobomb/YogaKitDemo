//
//  ViewController.m
//  YogaKitDemo
//
//  Created by lizhao on 2017/7/17.
//  Copyright © 2017年 lizhao. All rights reserved.
//

#import "ViewController.h"
#import <YogaKit/UIView+Yoga.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor lightGrayColor];
    [contentView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.width = YGPointValue(320);
        layout.height = YGPointValue(80);
        layout.marginTop = YGPointValue(40);
        layout.marginRight = YGPointValue(10);
    }];
    
    [self.view addSubview:contentView];
    
    [contentView.yoga applyLayoutPreservingOrigin:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
