//
//  KFTokin.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/29.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFTokin.h"
#import "KFFu.h"

@implementation KFTokin

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
        return @"s_to.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_to.png";
    } else {
        return nil;
    }
}

- (KFPiece *)getOriginalPiece {
    KFFu *originalPiece = [[KFFu alloc] initWithSide:self.side];
    
    return originalPiece;
}

@end
