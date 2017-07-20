//
//  Show.m
//  YogaKitDemo
//
//  Created by lizhao on 2017/7/18.
//  Copyright © 2017年 lizhao. All rights reserved.
//

#import "Show.h"

@interface Show ()


@end

@implementation Show

+ (NSArray *)loadShows {
    return [self loadMixersFromPlist:@"Shows"];
}

+ (NSArray *)loadMixersFromPlist:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *shows = [NSMutableArray arrayWithCapacity:4];
    for (NSDictionary *dict in dictArray) {
        Show *show = [[Show alloc] init];
        show.title = dict[@"title"];
        show.length = dict[@"length"];
        show.detail = dict[@"detail"];
        show.image = dict[@"image"];
        [shows addObject:show];
    }
    return shows;
}

@end
