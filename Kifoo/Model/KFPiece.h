//
//  KFPiece.h
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/21.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFPiece : NSObject

@property NSInteger side;
@property NSString *pieceId;

@property BOOL canPromote;
@property BOOL isPromoted;

- (NSString *)getImageName;
- (NSString *)getImageNameWithSide:(NSInteger)side;
- (NSString *)getPromotedImageName;

- (KFPiece *)getPromotedPiece;
- (KFPiece *)getOriginalPiece;

- (id)initWithSide:(NSInteger)side;
- (id)copy;

@end
