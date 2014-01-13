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
@property KFSquareButton *previousSquare;
@property KFSquareButton *currentSquare;

@property NSInteger side;
//@property int *side;
@property KFPiece *movedPiece;
@property KFPiece *capturedPiece;


//@property BOOL isPromoted;
@property BOOL didPromote;

@end
