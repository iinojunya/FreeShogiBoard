//
//  KFBoardViewController.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/01.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFBoardViewController.h"
#import "KFSquareButton.h"
#import "KFCapturedPieceButton.h"
#import "KFPiece.h"
#import "KFMove.h"
#import "KFFu.h"
#import "KFKyosha.h"
#import "KFKeima.h"
#import "KFGin.h"
#import "KFKin.h"
#import "KFGyoku.h"
#import "KFHisha.h"
#import "KFKaku.h"

@interface KFBoardViewController ()

@end

@implementation KFBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeBoard];
    [self setCoordinate];
}

# pragma mark - Private method
// マス目を選択
- (void)selectSquare:(id)sender {
    if (self.isLocatedPieceSelected || self.isCapturedPieceSelected) { // 移動先のマスを選択した場合
        NSLog(@"駒の移動先が選択されました");
        
        self.shouldClearSelectedPiece = YES;
        self.targetSquare = sender;
        
        if (self.isLocatedPieceSelected) { //盤上の駒を動かす場合
            //同じ駒を再度選択した場合は選択状態をキャンセルする
            if (self.selectedPiece == self.targetSquare.locatedPiece) {
                self.isLocatedPieceSelected = NO;
                
                [self.selectedSquare setBackgroundColor:[UIColor clearColor]];
                self.selectedPiece = nil;
                self.selectedSquare = nil;
                
                return;
            }
            
//            NSLog(@"selectedPiece : %@", self.selectedPiece);
            
            // 成り駒判定
            if (!self.selectedPiece.isPromoted && self.selectedPiece.canPromote) {
//                NSLog(@"未成駒");
                
                if (self.selectedPiece.side == THIS_SIDE) {
                    if (self.targetSquare.y < 4 || self.selectedSquare.y < 4) {
//                        NSLog(@"敵陣突入！！");
                        [self showPromotionAlert];
                        return;
                    }
                } else {
                    if (self.targetSquare.y > 6 || self.selectedSquare.y > 6) {
//                        NSLog(@"敵陣突入！！");
                        [self showPromotionAlert];
                        return;
                    }
                }
            }
            
            // 指し手を保存
//            [self saveMoveWithPromotion:NO];
            
            
            if (self.targetSquare.locatedPiece) { //移動先に駒がある場合
                // 駒を取る
//                NSLog(@"駒を取る。サイドは？targetSquare.side : %ld", self.targetSquare.locatedPiece.side);
                [self capture:self.targetSquare.locatedPiece];
            }
  
            self.isLocatedPieceSelected = NO;
        } else if (self.isCapturedPieceSelected) { //持ち駒を盤上に打つ場合
            if (self.targetSquare.locatedPiece) { //移動先に駒がある場合
//                NSLog(@"駒の上に駒は打てません！");
                // 何もしない
                return;
            }
            
            // 指し手を保存
//            [self saveMoveWithPromotion:NO];
            
            if (self.selectedPiece.side == THIS_SIDE) {
                [self subtractCapturedPiece:self.selectedPiece
                                     button:(KFCapturedPieceButton *)self.selectedSquare
                                       side:THIS_SIDE];
            } else {
                [self subtractCapturedPiece:self.selectedPiece
                                     button:(KFCapturedPieceButton *)self.selectedSquare
                                       side:COUNTER_SIDE];
            }
            
            self.isCapturedPieceSelected = NO;
        }
        
        // 指し手を保存
        [self saveMoveWithPromotion:NO];
        
        // 盤面を更新
        [self updateSquareViewWithPromotion:NO];
      
        NSLog(@"移動処理終了");
    } else { // 移動元の駒を選択した場合
        KFSquareButton *selectedSquare = sender;
        
        // 空白のマスを選択した場合は何もしない
        if (!selectedSquare.locatedPiece) {
            return;
        }
        
        // オブジェクトを渡すよりcopyした方が良いかも？
        self.selectedSquare = selectedSquare;
        self.selectedPiece = selectedSquare.locatedPiece;
        
        NSLog(@"移動する駒が選択されました : %@ : %@", self.selectedSquare, self.selectedPiece);
        
        // 選択されたマスの背景色を変える
        [self.selectedSquare setBackgroundColor:[UIColor grayColor]];
        
        // 駒が選択された状態にする
        self.isLocatedPieceSelected = YES;
    }
}

// 盤面を更新
- (void)updateSquareViewWithPromotion:(BOOL)didPromote {
    /*
    NSLog(@"何が起きてるか暫定確認");
    NSLog(@"###### BEFORE #######");
    NSLog(@"Previous square : %@", ((KFMove *)[self.moveArray lastObject]).previousSquare);
    NSLog(@"self.square77.locatedPiece : %@", self.square77.locatedPiece);
    NSLog(@"self.square76.locatedPiece : %@", self.square76.locatedPiece);
    NSLog(@"movedPiece : %@", ((KFMove *)[self.moveArray lastObject]).previousSquare.locatedPiece);
    */
    
    // 移動先のマスの駒の表示, objectを更新する
    if (didPromote) {
        [self.targetSquare setImage:[UIImage imageNamed:[self.selectedPiece getPromotedImageName]] forState:UIControlStateNormal];
        self.targetSquare.locatedPiece = [self.selectedPiece getPromotedPiece];
    } else {
        [self.targetSquare setImage:[UIImage imageNamed:[self.selectedPiece getImageName]] forState:UIControlStateNormal];
        self.targetSquare.locatedPiece = self.selectedPiece;
    }

    // 移動元のマス目の背景色を消す
    [self.selectedSquare setBackgroundColor:[UIColor clearColor]];
    
    if (self.shouldClearSelectedPiece) {
        // 移動元のマス目の駒のObject、画像を消す
        self.selectedSquare.locatedPiece = nil;
        [self.selectedSquare setImage:nil forState:UIControlStateNormal];
    }
    
    // 選択された駒、マスを初期化
    self.selectedSquare = nil;
    self.selectedPiece = nil;
    

    /*
    NSLog(@"###### ATER #######");
    NSLog(@"Previous square : %@", ((KFMove *)[self.moveArray lastObject]).previousSquare);
    
    NSLog(@"self.square77.locatedPiece : %@", self.square77.locatedPiece);
    NSLog(@"self.square76.locatedPiece : %@", self.square76.locatedPiece);
    
    NSLog(@"movedPiece : %@", ((KFMove *)[self.moveArray lastObject]).previousSquare.locatedPiece);
     */
}

// 指し手を保存
- (void)saveMoveWithPromotion:(BOOL)didPromote {
    KFMove *move = [[KFMove alloc] init];
    
    move.previousSquare = self.selectedSquare;
    move.previousSquare.locatedPiece = self.selectedSquare.locatedPiece;
    
    move.currentSquare = self.targetSquare;
    move.side = self.selectedPiece.side;
    move.didPromote = didPromote;

    move.movedPiece = [self.selectedPiece copy];
    move.capturedPiece = [self.targetSquare.locatedPiece copy];

    if (move.capturedPiece) {
        if (move.side == THIS_SIDE) {
            move.capturedPieceButton = [self.thisSideCapturedPieceButtons objectForKey:move.capturedPiece.pieceId];
        } else {
            move.capturedPieceButton = [self.counterSideCapturedPieceButtons objectForKey:move.capturedPiece.pieceId];
        }
    }

    [self.moveArray addObject:move];
}

//TODO:MOVE
// 待った
- (IBAction)waitButtonTapped:(id)sender {
    NSLog(@"######### 待った!! ##########");
    // 駒が選択されている状態の時は何もしない
    if (self.isLocatedPieceSelected || self.isCapturedPieceSelected) {
        return;
    }
    
    KFMove *lastMove = [self.moveArray lastObject];
    
    NSLog(@"movedPiece : %@", lastMove.movedPiece);
    NSLog(@"capturedPiece : %@", lastMove.capturedPiece);
    NSLog(@"movedPiece.side : %ld", lastMove.movedPiece.side);
    NSLog(@"capturedPiece.side : %ld", lastMove.capturedPiece.side);
    
    // 元の場所に駒を復元する
    if ([lastMove didPromote]) {
        [lastMove.previousSquare setImage:[UIImage imageNamed:[[lastMove.currentSquare.locatedPiece getOriginalPiece] getImageName]] forState:UIControlStateNormal];
        lastMove.previousSquare.locatedPiece = [lastMove.currentSquare.locatedPiece getOriginalPiece];
    } else {
        [lastMove.previousSquare setImage:[UIImage imageNamed:[lastMove.currentSquare.locatedPiece getImageName]] forState:UIControlStateNormal];
        lastMove.previousSquare.locatedPiece = lastMove.currentSquare.locatedPiece;
    }


    if (lastMove.capturedPiece) { //（駒を取った場合は元々そこにあった駒に戻す）
        lastMove.currentSquare.locatedPiece = lastMove.capturedPiece;
//        NSInteger capturedPieceSide = [self getOppositeSide:lastMove.capturedPiece.side];
        NSInteger capturedPieceSide = lastMove.capturedPiece.side;
        
        [lastMove.currentSquare setImage:[UIImage imageNamed:[lastMove.capturedPiece getImageNameWithSide:capturedPieceSide]]
                                forState:UIControlStateNormal];

        // 駒台の駒を元に戻す (駒台の駒を打った場合も考慮する（持ち駒が増えるように戻す））
        [self subtractCapturedPiece:lastMove.capturedPiece
                             button:lastMove.capturedPieceButton
                               side:lastMove.side];
        

        
    } else {
        lastMove.currentSquare.locatedPiece = nil;
        [lastMove.currentSquare setImage:nil forState:UIControlStateNormal];
    }
    
    [self.moveArray removeLastObject];
}

- (NSInteger)getOppositeSide:(NSInteger)side {
    if (side == THIS_SIDE) {
        return COUNTER_SIDE;
    } else {
        return THIS_SIDE;
    }
}

// 持ち駒を追加
- (void)addCapturedPiece:(KFPiece *)piece side:(NSInteger)side {
    NSInteger capturedPieceCount;

    if (side == THIS_SIDE) {
        capturedPieceCount = [[self.thisSideCapturedPieces objectForKey:piece.pieceId] integerValue];
    } else {
        capturedPieceCount = [[self.counterSideCapturedPieces objectForKey:piece.pieceId] integerValue];
    }
    
    if (capturedPieceCount > 0) {
        capturedPieceCount++;
    } else {
        capturedPieceCount = 1;
    }
    
    if (side == THIS_SIDE) {
        NSLog(@"手前の持ち駒を追加します");
        [self.thisSideCapturedPieces setObject:[NSString stringWithFormat:@"%ld", capturedPieceCount] forKey:piece.pieceId];
        NSLog(@"pieceID : %@, object : %@", piece.pieceId, [NSString stringWithFormat:@"%ld", capturedPieceCount]);
        NSLog(@"追加後の数 : %ld", [self.thisSideCapturedPieces count]);
    } else {
        NSLog(@"相手の持ち駒を追加します");
        [self.counterSideCapturedPieces setObject:[NSString stringWithFormat:@"%ld", capturedPieceCount] forKey:piece.pieceId];
        NSLog(@"追加後の数 : %ld", [self.counterSideCapturedPieces count]);
    }
}

// 持ち駒のボタンを配置
- (void)locateCapturedPieceButtons:(NSInteger)side {
    //ボタンをひとつずつ配置に付ける
    int count = 0;
    if (side == THIS_SIDE) {
        for (KFCapturedPieceButton *button in [self.thisSideCapturedPieceButtons allValues]) {
            button.frame = CGRectMake(4 + 32 * count, 4, 32, 35);
            count++;
        }
    } else {
        //TODO:Adjust
        for (KFCapturedPieceButton *button in [self.counterSideCapturedPieceButtons allValues]) {
            button.frame = CGRectMake(4 + 32 * count, 4, 32, 35);
            count++;
        }
    }
}

// 持ち駒種別判定
- (void)addCapturedPiecesView:(UIView *)standView
                capturedPiece:(KFPiece *)capturedPiece
               capturedPieces:(NSMutableDictionary *)capturedPiecesDic
          capturedPieceButton:(KFCapturedPieceButton *)capturedPieceButton
         capturedPieceButtons:(NSMutableDictionary *)capturedPieceButtonsDic {
    // 持ち駒０のときは普通に表示、同じ駒を追加した場合は数を表示、異なる駒の場合は位置をずらして表示
    if ([capturedPiecesDic count] == 0) {
        NSLog(@"ひとつ目の持ち駒。");
        // ボタンリストに追加
        NSLog(@"元々のボタンの数は:%ld", [capturedPieceButtonsDic count]);
        [capturedPieceButtonsDic setObject:capturedPieceButton forKey:capturedPiece.pieceId];
        NSLog(@"ボタンの数が増えました:%ld, id : %@", [capturedPieceButtonsDic count], capturedPiece.pieceId);
        
        [self locateCapturedPieceButtons:self.selectedPiece.side];
    } else if ([capturedPiecesDic objectForKey:capturedPiece.pieceId] != nil) {
        NSLog(@"同じ持ち駒を追加！");
        
        //ボタンのオブジェクトを取得
        KFCapturedPieceButton *existingCapturedPiecebutton = [capturedPieceButtonsDic objectForKey:capturedPiece.pieceId];
        
        NSInteger capturedPieceCount = [[capturedPiecesDic objectForKey:capturedPiece.pieceId] integerValue];
        existingCapturedPiecebutton.countLabel.text = [NSString stringWithFormat:@"%ld", ++capturedPieceCount];
    } else {
        NSLog(@"異なる持ち駒を追加！");
        
        // ボタンリストに追加
        NSLog(@"元々のボタンの数は:%ld, ", [capturedPieceButtonsDic count]);
        [capturedPieceButtonsDic setObject:capturedPieceButton forKey:capturedPiece.pieceId];
        NSLog(@"ボタンの数が増えました:%ld, id : %@", [capturedPieceButtonsDic count], capturedPiece.pieceId);
        
        [self locateCapturedPieceButtons:self.selectedPiece.side];
    }
    
    [standView addSubview:capturedPieceButton];
}

// 駒を取る
- (void)capture:(KFPiece *)piece {
//    NSLog(@"駒を取る！！");
    if (piece.isPromoted) {
//        NSLog(@"成り駒を捕獲しました");
        piece = [piece getOriginalPiece];
    }
    
//    NSLog(@"Piece.side : %ld", piece.side);
    
    //持ち駒用のボタンを作成
    KFCapturedPieceButton *capturedPieceButton = [[KFCapturedPieceButton alloc] init];
    
    [capturedPieceButton addTarget:self action:@selector(selectCapturedPiece:) forControlEvents:UIControlEventTouchDown];

    // 持ち駒ボタンに駒を登録
    // コピーした方がいい？
//    capturedPieceButton.locatedPiece = piece;
    capturedPieceButton.locatedPiece = [piece copy];
    
    //持ち駒の属性を持ち駒を取った駒と同じにする
    capturedPieceButton.locatedPiece.side = self.selectedPiece.side;

    //持ち駒の画像を設定
    [capturedPieceButton setImage:[UIImage imageNamed:[piece getImageNameWithSide:self.selectedPiece.side]] forState:UIControlStateNormal];
    
    if (self.selectedPiece.side == THIS_SIDE) {
        [self addCapturedPiecesView:self.thisSideStandView
                         capturedPiece:piece
                        capturedPieces:self.thisSideCapturedPieces
                   capturedPieceButton:capturedPieceButton
                  capturedPieceButtons:self.thisSideCapturedPieceButtons];
    } else if (self.selectedPiece.side == COUNTER_SIDE) {
        [self addCapturedPiecesView:self.counterSideStandView
                         capturedPiece:piece
                        capturedPieces:self.counterSideCapturedPieces
                   capturedPieceButton:capturedPieceButton
                  capturedPieceButtons:self.counterSideCapturedPieceButtons];
    }

    // Add to captured pieces
    [self addCapturedPiece:piece side:self.selectedPiece.side];

//    NSLog(@"(駒取得処理終了時)Piece.side : %ld", piece.side);
}

// 持ち駒を選択
- (void)selectCapturedPiece:(id)sender {
    //TODO:持ち駒を盤上に打った場合はデータを消す、向きを調節
    KFCapturedPieceButton *selectedSquare = sender;

    NSLog(@"持ち駒が選択されました : %@ : %@, side : %ld", selectedSquare, selectedSquare.locatedPiece, selectedSquare.locatedPiece.side);
    
    // 同じ持ち駒をタップした場合はキャンセル
    if (selectedSquare.locatedPiece == self.selectedPiece) {
        NSLog(@"同じ持ち駒なのでキャンセルします (selectedSquare: %@)", selectedSquare);
        NSLog(@"ちなみにisCapturedPieceSelected : %@", self.isCapturedPieceSelected?@"YES":@"NO");

        self.isCapturedPieceSelected = NO;
        
        [self.selectedSquare setBackgroundColor:[UIColor clearColor]];
        self.selectedPiece = nil;
        self.selectedSquare = nil;
        
        return;
    }
    
    // タップされたボタンに持ち駒がない場合は何もしない
    if (selectedSquare.locatedPiece == nil) {
        NSLog(@"持ち駒に何も入ってないのでキャンセルします");
        return;
    }
    
    self.selectedSquare = selectedSquare;
    self.selectedPiece = selectedSquare.locatedPiece;
    
    // 選択されたマスの背景色を変える
    [self.selectedSquare setBackgroundColor:[UIColor grayColor]];
    
    self.isCapturedPieceSelected = YES;
    NSLog(@"持ち駒選択無事完了。");
}


// 持ち駒を駒台から減らす
- (void)subtractCapturedPiece:(KFPiece *)piece
                       button:(KFCapturedPieceButton *)button
                         side:(NSInteger)side {
    //数を１引いて１個以上残っていれば数字を表示、0になればボタンごと削除
    NSInteger capturedPieceCount;

    if (side == THIS_SIDE) {
        capturedPieceCount = [[self.thisSideCapturedPieces objectForKey:[piece pieceId]] integerValue];
    } else {
        capturedPieceCount = [[self.counterSideCapturedPieces objectForKey:[piece pieceId]] integerValue];
    }
    
    if (capturedPieceCount > 1) { //同じ種類の持ち駒が複数あった場合
        capturedPieceCount--;
        
        if (side == THIS_SIDE) {
            [self.thisSideCapturedPieces setObject:[NSString stringWithFormat:@"%ld", capturedPieceCount] forKey:[piece pieceId]];
        } else {
            [self.counterSideCapturedPieces setObject:[NSString stringWithFormat:@"%ld", capturedPieceCount] forKey:[piece pieceId]];
        }
        

        
//        KFCapturedPieceButton *button = (KFCapturedPieceButton *)self.selectedSquare;
        
        if (capturedPieceCount > 1) {
            button.countLabel.text = [NSString stringWithFormat:@"%ld", capturedPieceCount];
        } else {
            button.countLabel.text = nil;
        }
        
        self.shouldClearSelectedPiece = NO;
    } else { //同じ種類の持ち駒がなくなった場合
        NSLog(@"piece : %@", piece);
        NSLog(@"pieceID : %@", piece.pieceId);
        
        if (side == THIS_SIDE) {
            [self.thisSideCapturedPieces removeObjectForKey:piece.pieceId];
            
            //ボタンを消す
            [[self.thisSideCapturedPieceButtons objectForKey:piece.pieceId] removeFromSuperview];
            [self.thisSideCapturedPieceButtons removeObjectForKey:piece.pieceId];
        } else {
            [self.counterSideCapturedPieces removeObjectForKey:piece.pieceId];
            
            //ボタンを消す
            [[self.counterSideCapturedPieceButtons objectForKey:piece.pieceId] removeFromSuperview];
            [self.counterSideCapturedPieceButtons removeObjectForKey:piece.pieceId];
        }
        
        // ボタンを再配置
        [self locateCapturedPieceButtons:piece.side];
    }
}
/*
- (void)subtractCapturedPieces:(NSMutableDictionary *)capturedPiecesDic
          capturedPieceButtons:(NSMutableDictionary *)capturedPieceButtonsDic {
    //駒を打った場合は持ち駒をデータから消去する
    //数を１引いて１個以上残っていれば数字を表示、0になればボタンごと削除
    NSInteger capturedPieceCount = [[capturedPiecesDic objectForKey:[self.selectedPiece pieceId]] integerValue];
    if (capturedPieceCount > 1) { //同じ種類の持ち駒が複数あった場合
        capturedPieceCount--;
        [capturedPiecesDic setObject:[NSString stringWithFormat:@"%ld", capturedPieceCount] forKey:[self.selectedPiece pieceId]];
        
        //TODO:数を減らした上で表示を更新
        KFCapturedPieceButton *button = (KFCapturedPieceButton *)self.selectedSquare;
        
        if (capturedPieceCount > 1) {
            button.countLabel.text = [NSString stringWithFormat:@"%ld", capturedPieceCount];
        } else {
            button.countLabel.text = nil;
        }
        
        self.shouldClearSelectedPiece = NO;
    } else { //同じ種類の持ち駒がなくなった場合
        [capturedPiecesDic removeObjectForKey:[self.selectedPiece pieceId]];
        
        //ボタンを消す
        [[capturedPieceButtonsDic objectForKey:self.selectedPiece.pieceId] removeFromSuperview];
        [capturedPieceButtonsDic removeObjectForKey:[self.selectedPiece pieceId]];
        
        // ボタンを再配置
        [self locateCapturedPieceButtons:self.selectedPiece.side];
    }
}
 */

// 成り駒確認Alert表示
- (void)showPromotionAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"成りますか？"
                                                   delegate:self
                                          cancelButtonTitle:@"キャンセル"
                                          otherButtonTitles:@"はい", @"いいえ", nil];
    alert.tag = PROMOTION_ALERT_TAG;

    [alert show];
}

// 盤面を初期化
- (void)initializeBoard {
    self.isLocatedPieceSelected = NO;
    self.isCapturedPieceSelected = NO;
    
    // 指し手を初期化
    self.moveArray = [NSMutableArray array];
    
    // Captured pieces (持ち駒)を初期化
    self.thisSideCapturedPieces = [NSMutableDictionary dictionary];
    self.counterSideCapturedPieces = [NSMutableDictionary dictionary];

    // Captured pieces button (持ち駒ボタン)を初期化
    self.thisSideCapturedPieceButtons = [NSMutableDictionary dictionary];
    self.counterSideCapturedPieceButtons = [NSMutableDictionary dictionary];
    
    // Stand (駒台)を初期化
    for (UIView *view in [self.thisSideStandView subviews]) {
        [view removeFromSuperview];
    }

    for (UIView *view in [self.counterSideStandView subviews]) {
        [view removeFromSuperview];
    }
    
    // Pieces of counter side
    self.square11.locatedPiece = [[KFKyosha alloc] initWithSide:COUNTER_SIDE];
    self.square21.locatedPiece = [[KFKeima alloc] initWithSide:COUNTER_SIDE];
    self.square31.locatedPiece = [[KFGin alloc] initWithSide:COUNTER_SIDE];
    self.square41.locatedPiece = [[KFKin alloc] initWithSide:COUNTER_SIDE];
    self.square51.locatedPiece = [[KFGyoku alloc] initWithSide:COUNTER_SIDE];
    self.square61.locatedPiece = [[KFKin alloc] initWithSide:COUNTER_SIDE];
    self.square71.locatedPiece = [[KFGin alloc] initWithSide:COUNTER_SIDE];
    self.square81.locatedPiece = [[KFKeima alloc] initWithSide:COUNTER_SIDE];
    self.square91.locatedPiece = [[KFKyosha alloc] initWithSide:COUNTER_SIDE];
    self.square22.locatedPiece = [[KFKaku alloc] initWithSide:COUNTER_SIDE];
    self.square82.locatedPiece = [[KFHisha alloc] initWithSide:COUNTER_SIDE];
    self.square13.locatedPiece = [[KFFu alloc] initWithSide:COUNTER_SIDE];
    self.square23.locatedPiece = [[KFFu alloc] initWithSide:COUNTER_SIDE];
    self.square33.locatedPiece = [[KFFu alloc] initWithSide:COUNTER_SIDE];
    self.square43.locatedPiece = [[KFFu alloc] initWithSide:COUNTER_SIDE];
    self.square53.locatedPiece = [[KFFu alloc] initWithSide:COUNTER_SIDE];
    self.square63.locatedPiece = [[KFFu alloc] initWithSide:COUNTER_SIDE];
    self.square73.locatedPiece = [[KFFu alloc] initWithSide:COUNTER_SIDE];
    self.square83.locatedPiece = [[KFFu alloc] initWithSide:COUNTER_SIDE];
    self.square93.locatedPiece = [[KFFu alloc] initWithSide:COUNTER_SIDE];
    
    // Images of counter side
    [self.square11 setImage:[UIImage imageNamed:[self.square11.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square21 setImage:[UIImage imageNamed:[self.square21.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square31 setImage:[UIImage imageNamed:[self.square31.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square41 setImage:[UIImage imageNamed:[self.square41.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square51 setImage:[UIImage imageNamed:[self.square51.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square61 setImage:[UIImage imageNamed:[self.square61.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square71 setImage:[UIImage imageNamed:[self.square71.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square81 setImage:[UIImage imageNamed:[self.square81.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square91 setImage:[UIImage imageNamed:[self.square91.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square22 setImage:[UIImage imageNamed:[self.square22.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square82 setImage:[UIImage imageNamed:[self.square82.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square13 setImage:[UIImage imageNamed:[self.square13.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square23 setImage:[UIImage imageNamed:[self.square23.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square33 setImage:[UIImage imageNamed:[self.square33.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square43 setImage:[UIImage imageNamed:[self.square43.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square53 setImage:[UIImage imageNamed:[self.square53.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square63 setImage:[UIImage imageNamed:[self.square63.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square73 setImage:[UIImage imageNamed:[self.square73.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square83 setImage:[UIImage imageNamed:[self.square83.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square93 setImage:[UIImage imageNamed:[self.square93.locatedPiece getImageName]] forState:UIControlStateNormal];
    
    // Pieces of this side
    self.square19.locatedPiece = [[KFKyosha alloc] initWithSide:THIS_SIDE];
    self.square29.locatedPiece = [[KFKeima alloc] initWithSide:THIS_SIDE];
    self.square39.locatedPiece = [[KFGin alloc] initWithSide:THIS_SIDE];
    self.square49.locatedPiece = [[KFKin alloc] initWithSide:THIS_SIDE];
    self.square59.locatedPiece = [[KFGyoku alloc] initWithSide:THIS_SIDE];
    self.square69.locatedPiece = [[KFKin alloc] initWithSide:THIS_SIDE];
    self.square79.locatedPiece = [[KFGin alloc] initWithSide:THIS_SIDE];
    self.square89.locatedPiece = [[KFKeima alloc] initWithSide:THIS_SIDE];
    self.square99.locatedPiece = [[KFKyosha alloc] initWithSide:THIS_SIDE];
    self.square28.locatedPiece = [[KFHisha alloc] initWithSide:THIS_SIDE];
    self.square88.locatedPiece = [[KFKaku alloc] initWithSide:THIS_SIDE];
    self.square17.locatedPiece = [[KFFu alloc] initWithSide:THIS_SIDE];
    self.square27.locatedPiece = [[KFFu alloc] initWithSide:THIS_SIDE];
    self.square37.locatedPiece = [[KFFu alloc] initWithSide:THIS_SIDE];
    self.square47.locatedPiece = [[KFFu alloc] initWithSide:THIS_SIDE];
    self.square57.locatedPiece = [[KFFu alloc] initWithSide:THIS_SIDE];
    self.square67.locatedPiece = [[KFFu alloc] initWithSide:THIS_SIDE];
    self.square77.locatedPiece = [[KFFu alloc] initWithSide:THIS_SIDE];
    self.square87.locatedPiece = [[KFFu alloc] initWithSide:THIS_SIDE];
    self.square97.locatedPiece = [[KFFu alloc] initWithSide:THIS_SIDE];
    
    // Images of counter side
    [self.square19 setImage:[UIImage imageNamed:[self.square19.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square29 setImage:[UIImage imageNamed:[self.square29.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square39 setImage:[UIImage imageNamed:[self.square39.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square49 setImage:[UIImage imageNamed:[self.square49.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square59 setImage:[UIImage imageNamed:[self.square59.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square69 setImage:[UIImage imageNamed:[self.square69.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square79 setImage:[UIImage imageNamed:[self.square79.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square89 setImage:[UIImage imageNamed:[self.square89.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square99 setImage:[UIImage imageNamed:[self.square99.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square28 setImage:[UIImage imageNamed:[self.square28.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square88 setImage:[UIImage imageNamed:[self.square88.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square17 setImage:[UIImage imageNamed:[self.square17.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square27 setImage:[UIImage imageNamed:[self.square27.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square37 setImage:[UIImage imageNamed:[self.square37.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square47 setImage:[UIImage imageNamed:[self.square47.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square57 setImage:[UIImage imageNamed:[self.square57.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square67 setImage:[UIImage imageNamed:[self.square67.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square77 setImage:[UIImage imageNamed:[self.square77.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square87 setImage:[UIImage imageNamed:[self.square87.locatedPiece getImageName]] forState:UIControlStateNormal];
    [self.square97 setImage:[UIImage imageNamed:[self.square97.locatedPiece getImageName]] forState:UIControlStateNormal];
    
    // Pieces of blank square
    self.square12.locatedPiece = nil;
    self.square32.locatedPiece = nil;
    self.square42.locatedPiece = nil;
    self.square52.locatedPiece = nil;
    self.square62.locatedPiece = nil;
    self.square72.locatedPiece = nil;
    self.square92.locatedPiece = nil;
    self.square14.locatedPiece = nil;
    self.square24.locatedPiece = nil;
    self.square34.locatedPiece = nil;
    self.square44.locatedPiece = nil;
    self.square54.locatedPiece = nil;
    self.square64.locatedPiece = nil;
    self.square74.locatedPiece = nil;
    self.square84.locatedPiece = nil;
    self.square94.locatedPiece = nil;
    self.square15.locatedPiece = nil;
    self.square25.locatedPiece = nil;
    self.square35.locatedPiece = nil;
    self.square45.locatedPiece = nil;
    self.square55.locatedPiece = nil;
    self.square65.locatedPiece = nil;
    self.square75.locatedPiece = nil;
    self.square85.locatedPiece = nil;
    self.square95.locatedPiece = nil;
    self.square16.locatedPiece = nil;
    self.square26.locatedPiece = nil;
    self.square36.locatedPiece = nil;
    self.square46.locatedPiece = nil;
    self.square56.locatedPiece = nil;
    self.square66.locatedPiece = nil;
    self.square76.locatedPiece = nil;
    self.square86.locatedPiece = nil;
    self.square96.locatedPiece = nil;
    self.square18.locatedPiece = nil;
    self.square38.locatedPiece = nil;
    self.square48.locatedPiece = nil;
    self.square58.locatedPiece = nil;
    self.square68.locatedPiece = nil;
    self.square78.locatedPiece = nil;
    self.square98.locatedPiece = nil;
    
    // Images of blank square
    [self.square12 setImage:nil forState:UIControlStateNormal];
    [self.square32 setImage:nil forState:UIControlStateNormal];
    [self.square42 setImage:nil forState:UIControlStateNormal];
    [self.square52 setImage:nil forState:UIControlStateNormal];
    [self.square62 setImage:nil forState:UIControlStateNormal];
    [self.square72 setImage:nil forState:UIControlStateNormal];
    [self.square92 setImage:nil forState:UIControlStateNormal];
    [self.square14 setImage:nil forState:UIControlStateNormal];
    [self.square24 setImage:nil forState:UIControlStateNormal];
    [self.square34 setImage:nil forState:UIControlStateNormal];
    [self.square44 setImage:nil forState:UIControlStateNormal];
    [self.square54 setImage:nil forState:UIControlStateNormal];
    [self.square64 setImage:nil forState:UIControlStateNormal];
    [self.square74 setImage:nil forState:UIControlStateNormal];
    [self.square84 setImage:nil forState:UIControlStateNormal];
    [self.square94 setImage:nil forState:UIControlStateNormal];
    [self.square15 setImage:nil forState:UIControlStateNormal];
    [self.square25 setImage:nil forState:UIControlStateNormal];
    [self.square35 setImage:nil forState:UIControlStateNormal];
    [self.square45 setImage:nil forState:UIControlStateNormal];
    [self.square55 setImage:nil forState:UIControlStateNormal];
    [self.square65 setImage:nil forState:UIControlStateNormal];
    [self.square75 setImage:nil forState:UIControlStateNormal];
    [self.square85 setImage:nil forState:UIControlStateNormal];
    [self.square95 setImage:nil forState:UIControlStateNormal];
    [self.square16 setImage:nil forState:UIControlStateNormal];
    [self.square26 setImage:nil forState:UIControlStateNormal];
    [self.square36 setImage:nil forState:UIControlStateNormal];
    [self.square46 setImage:nil forState:UIControlStateNormal];
    [self.square56 setImage:nil forState:UIControlStateNormal];
    [self.square66 setImage:nil forState:UIControlStateNormal];
    [self.square76 setImage:nil forState:UIControlStateNormal];
    [self.square86 setImage:nil forState:UIControlStateNormal];
    [self.square96 setImage:nil forState:UIControlStateNormal];
    [self.square18 setImage:nil forState:UIControlStateNormal];
    [self.square38 setImage:nil forState:UIControlStateNormal];
    [self.square48 setImage:nil forState:UIControlStateNormal];
    [self.square58 setImage:nil forState:UIControlStateNormal];
    [self.square68 setImage:nil forState:UIControlStateNormal];
    [self.square78 setImage:nil forState:UIControlStateNormal];
    [self.square98 setImage:nil forState:UIControlStateNormal];
}

- (void)setCoordinate {
    [self.square11 setCoordinateX:1 Y:1];
    [self.square21 setCoordinateX:2 Y:1];
    [self.square31 setCoordinateX:3 Y:1];
    [self.square41 setCoordinateX:4 Y:1];
    [self.square51 setCoordinateX:5 Y:1];
    [self.square61 setCoordinateX:6 Y:1];
    [self.square71 setCoordinateX:7 Y:1];
    [self.square81 setCoordinateX:8 Y:1];
    [self.square91 setCoordinateX:9 Y:1];
    [self.square12 setCoordinateX:1 Y:2];
    [self.square22 setCoordinateX:2 Y:2];
    [self.square32 setCoordinateX:3 Y:2];
    [self.square42 setCoordinateX:4 Y:2];
    [self.square52 setCoordinateX:5 Y:2];
    [self.square62 setCoordinateX:6 Y:2];
    [self.square72 setCoordinateX:7 Y:2];
    [self.square82 setCoordinateX:8 Y:2];
    [self.square92 setCoordinateX:9 Y:2];
    [self.square13 setCoordinateX:1 Y:3];
    [self.square23 setCoordinateX:2 Y:3];
    [self.square33 setCoordinateX:3 Y:3];
    [self.square43 setCoordinateX:4 Y:3];
    [self.square53 setCoordinateX:5 Y:3];
    [self.square63 setCoordinateX:6 Y:3];
    [self.square73 setCoordinateX:7 Y:3];
    [self.square83 setCoordinateX:8 Y:3];
    [self.square93 setCoordinateX:9 Y:3];
    [self.square14 setCoordinateX:1 Y:4];
    [self.square24 setCoordinateX:2 Y:4];
    [self.square34 setCoordinateX:3 Y:4];
    [self.square44 setCoordinateX:4 Y:4];
    [self.square54 setCoordinateX:5 Y:4];
    [self.square64 setCoordinateX:6 Y:4];
    [self.square74 setCoordinateX:7 Y:4];
    [self.square84 setCoordinateX:8 Y:4];
    [self.square94 setCoordinateX:9 Y:4];
    [self.square15 setCoordinateX:1 Y:5];
    [self.square25 setCoordinateX:2 Y:5];
    [self.square35 setCoordinateX:3 Y:5];
    [self.square45 setCoordinateX:4 Y:5];
    [self.square55 setCoordinateX:5 Y:5];
    [self.square65 setCoordinateX:6 Y:5];
    [self.square75 setCoordinateX:7 Y:5];
    [self.square85 setCoordinateX:8 Y:5];
    [self.square95 setCoordinateX:9 Y:5];
    [self.square16 setCoordinateX:1 Y:6];
    [self.square26 setCoordinateX:2 Y:6];
    [self.square36 setCoordinateX:3 Y:6];
    [self.square46 setCoordinateX:4 Y:6];
    [self.square56 setCoordinateX:5 Y:6];
    [self.square66 setCoordinateX:6 Y:6];
    [self.square76 setCoordinateX:7 Y:6];
    [self.square86 setCoordinateX:8 Y:6];
    [self.square96 setCoordinateX:9 Y:6];
    [self.square17 setCoordinateX:1 Y:7];
    [self.square27 setCoordinateX:2 Y:7];
    [self.square37 setCoordinateX:3 Y:7];
    [self.square47 setCoordinateX:4 Y:7];
    [self.square57 setCoordinateX:5 Y:7];
    [self.square67 setCoordinateX:6 Y:7];
    [self.square77 setCoordinateX:7 Y:7];
    [self.square87 setCoordinateX:8 Y:7];
    [self.square97 setCoordinateX:9 Y:7];
    [self.square18 setCoordinateX:1 Y:8];
    [self.square28 setCoordinateX:2 Y:8];
    [self.square38 setCoordinateX:3 Y:8];
    [self.square48 setCoordinateX:4 Y:8];
    [self.square58 setCoordinateX:5 Y:8];
    [self.square68 setCoordinateX:6 Y:8];
    [self.square78 setCoordinateX:7 Y:8];
    [self.square88 setCoordinateX:8 Y:8];
    [self.square98 setCoordinateX:9 Y:8];
    [self.square19 setCoordinateX:1 Y:9];
    [self.square29 setCoordinateX:2 Y:9];
    [self.square39 setCoordinateX:3 Y:9];
    [self.square49 setCoordinateX:4 Y:9];
    [self.square59 setCoordinateX:5 Y:9];
    [self.square69 setCoordinateX:6 Y:9];
    [self.square79 setCoordinateX:7 Y:9];
    [self.square89 setCoordinateX:8 Y:9];
    [self.square99 setCoordinateX:9 Y:9];
}

# pragma mark - UIAlertViewDelegate method
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == MENU_ALERT_TAG) {
        //TODO:Imple
    } else if (alertView.tag == PROMOTION_ALERT_TAG) {
        switch (buttonIndex) {
            case 0: //キャンセル
                break;
            case 1: //成り
                if (self.targetSquare.locatedPiece) { //移動先に駒がある場合
                    NSLog(@"（敵陣で）駒を取る。サイドは？targetSquare.side : %ld", self.targetSquare.locatedPiece.side);
                    [self capture:self.targetSquare.locatedPiece];
                }

                // 指し手を保存
                [self saveMoveWithPromotion:YES];

                // 盤面を更新
                [self updateSquareViewWithPromotion:YES];
                
                /*
                //移動先の駒を表示する
                [self.targetSquare setImage:[UIImage imageNamed:[self.selectedPiece getPromotedImageName]] forState:UIControlStateNormal];
                
                // 移動先のマスの駒を更新する
                self.targetSquare.locatedPiece = [self.selectedPiece getPromotedPiece];
                
                // 移動元の背景色を消す
                [self.selectedSquare setBackgroundColor:[UIColor clearColor]];
                
                if (self.shouldClearSelectedPiece) {
                    // 移動元の駒、画像を消す
                    self.selectedSquare.locatedPiece = nil;
                    [self.selectedSquare setImage:nil forState:UIControlStateNormal];
                }

                // 選択された駒、マスを初期化
                self.selectedSquare = nil;
                self.selectedPiece = nil;
                 */
                
                self.isLocatedPieceSelected = NO;
                
                NSLog(@"成り処理終了, targetSquare.locatedPiece.side : %ld", self.targetSquare.locatedPiece.side);
                break;
            case 2: //成らず
                if (self.targetSquare.locatedPiece) { //移動先に駒がある場合
                    NSLog(@"（敵陣で）駒を取る。サイドは？targetSquare.side : %ld", self.targetSquare.locatedPiece.side);
                    [self capture:self.targetSquare.locatedPiece];
                }
                
                // 指し手を保存
                [self saveMoveWithPromotion:NO];

                // 盤面を更新
                [self updateSquareViewWithPromotion:NO];
                /*
                //移動先の駒を表示する
                [self.targetSquare setImage:[UIImage imageNamed:[self.selectedPiece getImageName]] forState:UIControlStateNormal];
                
                // 移動先のマスの駒を更新する
                self.targetSquare.locatedPiece = self.selectedPiece;
                
                // 移動元の背景色を消す
                [self.selectedSquare setBackgroundColor:[UIColor clearColor]];
                
                if (self.shouldClearSelectedPiece) {
                    // 移動元の駒、画像を消す
                    self.selectedSquare.locatedPiece = nil;
                    [self.selectedSquare setImage:nil forState:UIControlStateNormal];
                }
                
                // 選択された駒、マスを初期化
                self.selectedSquare = nil;
                self.selectedPiece = nil;
                 */
                
                self.isLocatedPieceSelected = NO;
                
                NSLog(@"成らず処理終了");
                break;
        }
    }
}

# pragma mark - Action method
/*
// 待った
- (IBAction)waitButtonTapped:(id)sender {
    // 駒が選択されている状態の時は何もしない
    if (self.isLocatedPieceSelected || self.isCapturedPieceSelected) {
        return;
    }
    
    KFMove *lastMove = [self.moveArray lastObject];
    
//    lastMove.previousSquare
//    self.squ
 
    [self.moveArray removeLastObject];
}
 */

// 盤面を初期化
- (IBAction)resetButtonTapped:(id)sender {
    [self initializeBoard];
    
    //将来的にリセットボタンをメニューボタンにしてHomeに戻る、棋譜保存等の選択肢を含めたAlertを表示させるかも
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"キャンセル"
                                          otherButtonTitles:@"ホームに戻る", @"棋譜を保存", @"盤面を初期化", nil];
    alert.tag = MENU_ALERT_TAG;
    
    [alert show];
     */
}

- (IBAction)square11tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square12tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square13tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square14tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square15tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square16tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square17tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square18tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square19tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square21tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square22tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square23tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square24tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square25tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square26tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square27tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square28tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square29tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square31tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square32tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square33tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square34tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square35tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square36tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square37tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square38tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square39tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square41tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square42tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square43tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square44tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square45tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square46tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square47tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square48tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square49tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square51tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square52tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square53tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square54tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square55tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square56tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square57tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square58tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square59tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square61tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square62tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square63tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square64tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square65tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square66tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square67tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square68tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square69tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square71tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square72tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square73tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square74tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square75tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square76tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square77tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square78tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square79tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square81tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square82tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square83tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square84tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square85tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square86tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square87tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square88tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square89tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square91tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square92tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square93tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square94tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square95tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square96tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square97tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square98tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square99tapped:(id)sender {
    [self selectSquare:sender];
}

/*
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/



@end
