//
//  KFGin.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/22.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFGin.h"
#import "KFNarigin.h"

@implementation KFGin

- (id)initWithSide:(NSInteger)side {
    self = [super initWithSide:side];
    
    if (self) {
        self.canPromote = YES;
    }
    
    return self;
}

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

- (NSString *)getPromotedImageName {
    if (self.side == THIS_SIDE) {
        return @"s_narigin.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_narigin.png";
    } else {
        return nil;
    }
}

- (KFPiece *)getPromotedPiece {
    KFNarigin *promotedPiece = [[KFNarigin alloc] initWithSide:self.side];

    return promotedPiece;
}


//- (NSInteger)pieceId {
- (NSString *)pieceId {
    return PIECE_ID_GIN;
}

@end
