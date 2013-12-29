//
//  KFKaku.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/21.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFKaku.h"
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

- (NSString *)getImageNameWithSide:(NSInteger)side {
    if (side == THIS_SIDE) {
        return @"s_kaku.png";
    } else if (side == COUNTER_SIDE) {
        return @"g_kaku.png";
    } else {
        return nil;
    }
}

- (NSString *)getPromotedImageName {
    if (self.side == THIS_SIDE) {
        return @"s_kaku.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_kaku.png";
    } else {
        return nil;
    }
}

- (KFPiece *)getPromotedPiece {
    KFKaku *promotedPiece = [[KFKaku alloc] initWithSide:self.side];
    
    return promotedPiece;
}



//- (NSInteger)pieceId {
- (NSString *)pieceId {
    return PIECE_ID_KAKU;
}

@end
