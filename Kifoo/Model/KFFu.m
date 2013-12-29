//
//  KFFu.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/21.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFFu.h"
#import "KFTokin.h"

@implementation KFFu

- (id)initWithSide:(NSInteger)side {
    self = [super initWithSide:side];
    
    if (self) {
        
    }

    return self;
}

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_fu.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_fu.png";
    } else {
        return nil;
    }
}

- (NSString *)getImageNameWithSide:(NSInteger)side {
    if (side == THIS_SIDE) {
        return @"s_fu.png";
    } else if (side == COUNTER_SIDE) {
        return @"g_fu.png";
    } else {
        return nil;
    }
}

- (NSString *)getPromotedImageName {
    if (self.side == THIS_SIDE) {
        return @"s_to.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_to.png";
    } else {
        return nil;
    }
}

- (KFPiece *)getPromotedPiece {
    KFTokin *promotedPiece = [[KFTokin alloc] initWithSide:self.side];

    return promotedPiece;
}


- (NSString *)pieceId {
    return PIECE_ID_FU;
}

@end
