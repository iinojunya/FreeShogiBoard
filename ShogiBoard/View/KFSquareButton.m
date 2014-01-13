//
//  KFSquareButton.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/21.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFSquareButton.h"

@implementation KFSquareButton

/*
- (id)init {
    self = [super init];
    
    if (self) {
        NSLog(@"[KFSquareButton] init is called!!!");
    }
    
    return self;
}
 */

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
- (void)awakeFromNib {
    NSLog(@"[KFSquareButton] AWAKE is called!!!");    
}
*/
 
- (id)copy {
    KFSquareButton *button = [[KFSquareButton alloc] init];
    
    button.locatedPiece = self.locatedPiece;
    
    return button;
}

- (void)setCoordinateX:(int)x Y:(int)y {
    self.x = x;
    self.y = y;
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
