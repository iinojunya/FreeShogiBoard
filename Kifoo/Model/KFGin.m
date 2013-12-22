//
//  KFGin.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/22.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFGin.h"

@implementation KFGin

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_gin.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_gin.png";
    } else {
        return nil;
    }
}

- (NSString *)getImageNameWithSide:(NSInteger)side {
    if (side == THIS_SIDE) {
        return @"s_gin.png";
    } else if (side == COUNTER_SIDE) {
        return @"g_gin.png";
    } else {
        return nil;
    }
}

@end
