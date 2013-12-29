//
//  KFNarikyo.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/29.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFNarikyo.h"

@implementation KFNarikyo

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
        return @"s_narikyo.png";
    } else if (self.side == COUNTER_SIDE) {
        return @"g_narikyo.png";
    } else {
        return nil;
    }
}

@end
