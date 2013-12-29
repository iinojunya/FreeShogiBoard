//
//  KFUma.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/29.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFUma.h"

@implementation KFUma

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_uma.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_uma.png";
    } else {
        return nil;
    }
}

@end
