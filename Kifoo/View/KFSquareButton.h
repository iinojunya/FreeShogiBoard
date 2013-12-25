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

- (id)copy;

@end
