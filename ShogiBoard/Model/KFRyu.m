//
//  KFRyu.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/29.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFRyu.h"
#import "KFHisha.h"

@implementation KFRyu

- (id)initWithSide:(NSInteger)side {
    self = [super initWithSide:side];
    
    if (self) {
        self.isPromoted = YES;
    }
    
    return self;
}

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_ryu.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_ryu.png";
    } else {
        return nil;
    }
}

- (NSString *)getImageNameWithSide:(NSInteger)side {
    if (side == THIS_SIDE) {
        return @"s_ryu.png";
    } else if (side == COUNTER_SIDE) {
        return @"g_ryu.png";
    } else {
        return nil;
    }
}

- (KFPiece *)getOriginalPiece {
    KFHisha *originalPiece = [[KFHisha alloc] initWithSide:self.side];
    
    return originalPiece;
}

- (NSString *)pieceId {
    return PIECE_ID_HISHA;
}

@end
