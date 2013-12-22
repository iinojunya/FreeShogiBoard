//
//  KFPiece.h
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/21.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
enum {
    FIRST_MOVE = 0,
    SECOND_MOVE = 1
};
 */

/*
@protocol KFPieceDelegate <NSObject>
- (NSString *)getImageName;
@end
 */

//@interface KFPiece : NSObject <KFPieceDelegate>
@interface KFPiece : NSObject

//@property NSInteger moveOrder;
@property NSInteger side;
//@property (weak, nonatomic) id<KFPieceDelegate> delegate;

- (NSString *)getImageName;
- (NSString *)getImageNameWithSide:(NSInteger)side;

- (id)initWithSide:(NSInteger)side;

@end
