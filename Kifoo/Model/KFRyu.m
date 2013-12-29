//
//  KFRyu.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/29.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFRyu.h"

@implementation KFRyu

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_ryu.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_ryu.png";
    } else {
        return nil;
    }
}

@end
