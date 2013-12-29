//
//  KFNarikei.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/29.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFNarikei.h"

@implementation KFNarikei

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_narikei.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_narikei.png";
    } else {
        return nil;
    }
}

@end
