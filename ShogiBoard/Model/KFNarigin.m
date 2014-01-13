//
//  KFNarigin.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/29.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFNarigin.h"
#import "KFGin.h"

@implementation KFNarigin

/*
- (id)init {
    self = [super init];
    
    if (self) {
        self.isPromoted = YES;
    }
    
    return self;
}
 */
- (id)initWithSide:(NSInteger)side {
    self = [super initWithSide:side];
    
    if (self) {
        self.isPromoted = YES;
//        self.canPromote = NO;
    }
    
    return self;
}


- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_narigin.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_narigin.png";
    } else {
        return nil;
    }
}

- (NSString *)getImageNameWithSide:(NSInteger)side {
    if (side == THIS_SIDE) {
        return @"s_narigin.png";
    } else if (side == COUNTER_SIDE) {
        return @"g_narigin.png";
    } else {
        return nil;
    }
}

- (KFPiece *)getOriginalPiece {
    KFGin *originalPiece = [[KFGin alloc] initWithSide:self.side];
    
    return originalPiece;
}

- (NSString *)pieceId {
    return PIECE_ID_GIN;
}

@end
