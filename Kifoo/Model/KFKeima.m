//
//  KFKeima.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/22.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFKeima.h"
#import "KFNarikei.h"

@implementation KFKeima

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_kei.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_kei.png";
    } else {
        return nil;
    }
}

- (NSString *)getImageNameWithSide:(NSInteger)side {
    if (side == THIS_SIDE) {
        return @"s_kei.png";
    } else if (side == COUNTER_SIDE) {
        return @"g_kei.png";
    } else {
        return nil;
    }
}

- (NSString *)getPromotedImageName {
    if (self.side == THIS_SIDE) {
        return @"s_narikei.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_narikei.png";
    } else {
        return nil;
    }
}

- (KFPiece *)getPromotedPiece {
    KFNarikei *promotedPiece = [[KFNarikei alloc] initWithSide:self.side];
    
    return promotedPiece;
}



//- (NSInteger)pieceId {
- (NSString *)pieceId {
    return PIECE_ID_KEI;
}

@end
