//
//  KFKaku.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/21.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFKaku.h"

@implementation KFKaku

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_kaku.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_kaku.png";
    } else {
        return nil;
    }
}

@end
