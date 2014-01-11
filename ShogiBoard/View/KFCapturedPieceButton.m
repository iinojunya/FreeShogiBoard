//
//  KFCapturedPieceButton.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/25.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFCapturedPieceButton.h"

@implementation KFCapturedPieceButton

- (id)init {
    self = [super init];
    
    if (self) {
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 10, 32, 35)];
        self.countLabel.backgroundColor = [UIColor clearColor];
        self.countLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.countLabel];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
