//
//  KFHisha.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/22.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFHisha.h"

@implementation KFHisha

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_hisha.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_hisya.png";
    } else {
        return nil;
    }
}

- (NSString *)getImageNameWithSide:(NSInteger)side {
    if (side == THIS_SIDE) {
        return @"s_hisha.png";
    } else if (side == COUNTER_SIDE) {
        return @"g_hisha.png";
    } else {
        return nil;
    }
}

//- (NSInteger)pieceId {
- (NSString *)pieceId {
    return PIECE_ID_HISHA;
}

@end
