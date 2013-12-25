//
//  KFBoardViewController.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/01.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFBoardViewController.h"
#import "KFSquareButton.h"
#import "KFPiece.h"
#import "KFFu.h"
#import "KFKyosya.h"
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
}

# pragma mark - Private method
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

- (void)locateCapturedPieceButtons:(NSInteger)side {
    //ボタンをひとつずつ配置に付ける
    int count = 0;
    if (side == THIS_SIDE) {
        for (KFSquareButton *button in [self.thisSideCapturedPieceButtons allValues]) {
            button.frame = CGRectMake(4 + 32 * count, 4, 32, 35);
            count++;
        }
    } else {
        //TODO:Imple
    }
}

- (void)capture:(KFPiece *)piece {
    KFSquareButton *capturedPieceButton = [[KFSquareButton alloc] init];
    [capturedPieceButton addTarget:self action:@selector(selectCapturedPiece:) forControlEvents:UIControlEventTouchDown];
    capturedPieceButton.locatedPiece = piece;
    
    //持ち駒の属性を持ち駒を取った駒と同じにする
    capturedPieceButton.locatedPiece.side = self.selectedPiece.side;

    [capturedPieceButton setImage:[UIImage imageNamed:[piece getImageNameWithSide:self.selectedPiece.side]] forState:UIControlStateNormal];
    
    if (self.selectedPiece.side == THIS_SIDE) {
        //TODO:持ち駒０のときは普通に表示、同じ駒を追加した場合は数を表示、異なる駒の場合は位置をずらして表示
        if ([self.thisSideCapturedPieces count] == 0) {
            NSLog(@"ひとつ目の持ち駒。");
            // ボタンリストに追加
            NSLog(@"元々のボタンの数は:%ld", [self.thisSideCapturedPieceButtons count]);
            [self.thisSideCapturedPieceButtons setObject:capturedPieceButton forKey:piece.pieceId];
            NSLog(@"ボタンの数が増えました:%ld, id : %@", [self.thisSideCapturedPieceButtons count], piece.pieceId);

            [self locateCapturedPieceButtons:self.selectedPiece.side];
        } else if ([self.thisSideCapturedPieces objectForKey:piece.pieceId] != nil) {
            NSLog(@"同じ持ち駒を追加！");
        } else {
            NSLog(@"異なる持ち駒を追加！");
            
            // ボタンリストに追加
            NSLog(@"元々のボタンの数は:%ld, ", [self.thisSideCapturedPieceButtons count]);
            [self.thisSideCapturedPieceButtons setObject:capturedPieceButton forKey:piece.pieceId];
            NSLog(@"ボタンの数が増えました:%ld, id : %@", [self.thisSideCapturedPieceButtons count], piece.pieceId);

            [self locateCapturedPieceButtons:self.selectedPiece.side];
        }
        
        [self.thisSideStandView addSubview:capturedPieceButton];
    } else if (self.selectedPiece.side == COUNTER_SIDE) {
        //TODO:counter side
        
        capturedPieceButton.frame = CGRectMake(4, 4, 32, 35);
        [self.counterSideStandView addSubview:capturedPieceButton];
    }

    // Add to captured pieces
    [self addCapturedPiece:piece side:self.selectedPiece.side];
}

- (void)selectCapturedPiece:(id)sender {
    //TODO:持ち駒を盤上に打った場合はデータを消す、向きを調節
    KFSquareButton *selectedSquare = sender;

    NSLog(@"持ち駒が選択されました : %@ : %@", selectedSquare, selectedSquare.locatedPiece);
    
    // 同じ持ち駒をタップした場合はキャンセル
    if (selectedSquare.locatedPiece == self.selectedPiece) {
        self.isCapturedPieceSelected = NO;
        
        [self.selectedSquare setBackgroundColor:[UIColor clearColor]];
        self.selectedPiece = nil;
        self.selectedSquare = nil;
        
        return;
    }
    
    // タップされたボタンに持ち駒がない場合は何もしない
    if (selectedSquare.locatedPiece == nil) {
        return;
    }
    
    self.selectedSquare = selectedSquare;
    self.selectedPiece = selectedSquare.locatedPiece;

    
    // 選択されたマスの背景色を変える
    [self.selectedSquare setBackgroundColor:[UIColor grayColor]];
    
    self.isCapturedPieceSelected = YES;
}

- (void)selectSquare:(id)sender {
    if (self.isLocatedPieceSelected || self.isCapturedPieceSelected) { // 移動先のマスを選択した場合
        NSLog(@"駒の移動先が選択されました");
        
        //移動先の駒を表示する
        KFSquareButton *targetSquare = sender;
        [targetSquare setImage:[UIImage imageNamed:[self.selectedPiece getImageName]] forState:UIControlStateNormal];
        
        if (self.isLocatedPieceSelected) { //盤上の駒を動かした場合
            if (targetSquare.locatedPiece) { //移動先に駒がある場合
                //自分の駒を選択した場合は選択状態をキャンセルする
                if (self.selectedPiece == targetSquare.locatedPiece) {
                    self.isLocatedPieceSelected = NO;
                    
                    [self.selectedSquare setBackgroundColor:[UIColor clearColor]];
                    self.selectedPiece = nil;
                    self.selectedSquare = nil;

                    return;
                }
                
                // 移動先に駒があれば駒を取る
                [self capture:targetSquare.locatedPiece];
            }
            
            self.isLocatedPieceSelected = NO;
        } else if (self.isCapturedPieceSelected) { //持ち駒を盤上に打つ場合
            if (targetSquare.locatedPiece) { //移動先に駒がある場合
                // 何もしない
                return;
            }
            
            //TODO:駒を打った場合は持ち駒をデータから消去する
            //数を１引いて１個以上残っていれば数字を表示、0になればボタンごと削除
            if (self.selectedPiece.side == THIS_SIDE) {
                NSInteger capturedPieceCount = [[self.thisSideCapturedPieces objectForKey:[self.selectedPiece pieceId]] integerValue];
                if (--capturedPieceCount > 0) {
                    [self.thisSideCapturedPieces setObject:[NSString stringWithFormat:@"%ld", capturedPieceCount--] forKey:[self.selectedPiece pieceId]];
                } else {
                    [self.thisSideCapturedPieces removeObjectForKey:[self.selectedPiece pieceId]];

                    //ボタンを消す
                    [[self.thisSideCapturedPieceButtons objectForKey:self.selectedPiece.pieceId] removeFromSuperview];
                    [self.thisSideCapturedPieceButtons removeObjectForKey:[self.selectedPiece pieceId]];
                    
                    // ボタンを再配置
                    [self locateCapturedPieceButtons:self.selectedPiece.side];
                }
            } else {
                //TODO:CounterSide
            }
            
            self.isCapturedPieceSelected = NO;
        }

        // 移動先のマスの駒を更新する
        targetSquare.locatedPiece = self.selectedPiece;
        
        // 移動元の駒、画像、背景色を消す
        self.selectedSquare.locatedPiece = nil;
        [self.selectedSquare setBackgroundColor:[UIColor clearColor]];
        [self.selectedSquare setImage:nil forState:UIControlStateNormal];
        
        //TODO:TEST
        self.selectedSquare = nil;
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
        
        self.isLocatedPieceSelected = YES;
    }
}

- (void)initializeBoard {
    self.isLocatedPieceSelected = NO;
    self.isCapturedPieceSelected = NO;
    
    // Captured pieces (持ち駒)
    self.thisSideCapturedPieces = [NSMutableDictionary dictionary];
    self.counterSideCapturedPieces = [NSMutableDictionary dictionary];

    // Captured pieces button (持ち駒ボタン)
    self.thisSideCapturedPieceButtons = [NSMutableDictionary dictionary];
    self.counterSideCapturedPieceButtons = [NSMutableDictionary dictionary];
    
    // Stand (駒台)
    for (UIView *view in [self.thisSideStandView subviews]) {
        [view removeFromSuperview];
    }

    for (UIView *view in [self.counterSideStandView subviews]) {
        [view removeFromSuperview];
    }
    
    // Pieces of counter side
    self.square11.locatedPiece = [[KFKyosya alloc] initWithSide:COUNTER_SIDE];
    self.square21.locatedPiece = [[KFKeima alloc] initWithSide:COUNTER_SIDE];
    self.square31.locatedPiece = [[KFGin alloc] initWithSide:COUNTER_SIDE];
    self.square41.locatedPiece = [[KFKin alloc] initWithSide:COUNTER_SIDE];
    self.square51.locatedPiece = [[KFGyoku alloc] initWithSide:COUNTER_SIDE];
    self.square61.locatedPiece = [[KFKin alloc] initWithSide:COUNTER_SIDE];
    self.square71.locatedPiece = [[KFGin alloc] initWithSide:COUNTER_SIDE];
    self.square81.locatedPiece = [[KFKeima alloc] initWithSide:COUNTER_SIDE];
    self.square91.locatedPiece = [[KFKyosya alloc] initWithSide:COUNTER_SIDE];
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
    self.square19.locatedPiece = [[KFKyosya alloc] initWithSide:THIS_SIDE];
    self.square29.locatedPiece = [[KFKeima alloc] initWithSide:THIS_SIDE];
    self.square39.locatedPiece = [[KFGin alloc] initWithSide:THIS_SIDE];
    self.square49.locatedPiece = [[KFKin alloc] initWithSide:THIS_SIDE];
    self.square59.locatedPiece = [[KFGyoku alloc] initWithSide:THIS_SIDE];
    self.square69.locatedPiece = [[KFKin alloc] initWithSide:THIS_SIDE];
    self.square79.locatedPiece = [[KFGin alloc] initWithSide:THIS_SIDE];
    self.square89.locatedPiece = [[KFKeima alloc] initWithSide:THIS_SIDE];
    self.square99.locatedPiece = [[KFKyosya alloc] initWithSide:THIS_SIDE];
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



# pragma mark - Action method
- (IBAction)resetButtonTapped:(id)sender {
    [self initializeBoard];
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
