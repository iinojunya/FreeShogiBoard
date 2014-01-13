//
//  KFMove.h
//  ShogiBoard
//
//  Created by Maeda Kazuya on 2014/01/12.
//  Copyright (c) 2014年 Kifoo, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KFPiece;
@class KFSquareButton;
@class KFCapturedPieceButton;

@interface KFMove : NSObject

/*
@property int previousX;
@property int previousY;
@property int currentX;
@property int currentY;
 */
/*
@property NSInteger previousX;
@property NSInteger previousY;
@property NSInteger currentX;
@property NSInteger currentY;
 */
@property (strong, nonatomic) KFSquareButton *previousSquare;
@property (strong, nonatomic) KFSquareButton *currentSquare;
@property (strong, nonatomic) KFCapturedPieceButton *capturedPieceButton;

@property (strong, nonatomic) KFPiece *movedPiece;
@property (strong, nonatomic) KFPiece *capturedPiece;
@property NSInteger side;

//@property BOOL isPromoted;
@property BOOL didPromote;

@end
