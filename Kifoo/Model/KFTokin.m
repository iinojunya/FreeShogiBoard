//
//  KFTokin.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/29.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFTokin.h"

@implementation KFTokin

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_to.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_to.png";
    } else {
        return nil;
    }
}

@end
