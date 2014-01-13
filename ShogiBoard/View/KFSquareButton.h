//
//  KFSquareButton.h
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/21.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KFPiece;

@interface KFSquareButton : UIButton

@property (strong, nonatomic) KFPiece *locatedPiece;
@property int x;
@property int y;


//- (id)init;
- (id)copy;

- (void)setCoordinateX:(int) x Y:(int)y;

@end
