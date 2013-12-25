//
//  KFKyosya.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/22.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFKyosya.h"

@implementation KFKyosya

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_kyo.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_kyo.png";
    } else {
        return nil;
    }
}

- (NSString *)getImageNameWithSide:(NSInteger)side {
    if (side == THIS_SIDE) {
        return @"s_kyo.png";
    } else if (side == COUNTER_SIDE) {
        return @"g_kyo.png";
    } else {
        return nil;
    }
}

//- (NSInteger)pieceId {
- (NSString *)pieceId {
    return PIECE_ID_KYO;
}

@end
