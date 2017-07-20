//
//  Show.h
//  YogaKitDemo
//
//  Created by lizhao on 2017/7/18.
//  Copyright © 2017年 lizhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Show : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *image;


+ (NSArray *)loadShows;

@end
