//
//  KFFu.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/21.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFFu.h"
//#import "KFPiece.h"

//@implementation KFFu<KFPieceDelegate>


@implementation KFFu

- (NSString *)getImageName {
    if (self.side == THIS_SIDE) {
        NSLog(@"######### THIS SIDE!!");
        return @"s_fu.png";
    } else if (self.side == COUNTER_SIDE) {
        NSLog(@"######### COUNTER SIDE!!");
        return @"g_fu.png";
    } else {
        NSLog(@"######### Not Defined!?");
        return nil;
    }
}

@end
