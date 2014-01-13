//
//  KFUma.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/29.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFUma.h"
#import "KFKaku.h"

@implementation KFUma

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
    }
    
    return self;
}

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        return @"s_uma.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_uma.png";
    } else {
        return nil;
    }
}

- (KFPiece *)getOriginalPiece {
    KFKaku *originalPiece = [[KFKaku alloc] initWithSide:self.side];
    
    return originalPiece;
}

- (NSString *)pieceId {
    return PIECE_ID_KAKU;
}

@end
