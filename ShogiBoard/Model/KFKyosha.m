//
//  KFKyosha.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/22.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFKyosha.h"
#import "KFNarikyo.h"

@implementation KFKyosha

- (id)initWithSide:(NSInteger)side {
    self = [super initWithSide:side];
    
    if (self) {
        self.canPromote = YES;
    }
    
    return self;
}

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

- (NSString *)getPromotedImageName {
    if (self.side == THIS_SIDE) {
        return @"s_narikyo.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_narikyo.png";
    } else {
        return nil;
    }
}

- (KFPiece *)getPromotedPiece {
    KFNarikyo *promotedPiece = [[KFNarikyo alloc] initWithSide:self.side];
    
    return promotedPiece;
}

- (NSString *)pieceId {
    return PIECE_ID_KYO;
}

@end
