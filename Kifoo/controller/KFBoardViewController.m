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

    self.square77.locatedPiece = [[KFFu alloc] initWithSide:THIS_SIDE];
//    self.square77.locatedPiece = [[KFFu alloc] initWithSide:THIS_SIDE];
    self.square88.locatedPiece = [[KFKaku alloc] initWithSide:THIS_SIDE];
    
//    self.square77.locatedPiece.delegate = [[KFFu alloc] initWithSide:THIS_SIDE];
//    self.square88.locatedPiece.delegate = [[KFKaku alloc] initWithSide:THIS_SIDE];

    /*
    self.square77.locatedPiece.side = THIS_SIDE;
    self.square76.locatedPiece.side = THIS_SIDE;
    self.square88.locatedPiece.side = THIS_SIDE;
     */
    self.square76.locatedPiece.side = THIS_SIDE;
    

    
    self.isPieceSelected = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (IBAction)button57tapped:(id)sender {
}

- (IBAction)button56tapped:(id)sender {
    [self.button57 setImage:[UIImage alloc] forState:UIControlStateNormal];
    [self.button56 setImage:[UIImage imageNamed:@"s_fu.png"] forState:UIControlStateNormal];
}
 */
- (IBAction)square11tapped:(id)sender {
}

- (IBAction)square12tapped:(id)sender {
}

- (IBAction)square13tapped:(id)sender {
}

- (IBAction)square14tapped:(id)sender {
}

- (IBAction)square15tapped:(id)sender {
}

- (IBAction)square16tapped:(id)sender {
}

- (IBAction)square17tapped:(id)sender {
}

- (IBAction)square18tapped:(id)sender {}
- (IBAction)square19tapped:(id)sender {}
- (IBAction)square21tapped:(id)sender {}
- (IBAction)square22tapped:(id)sender {}
- (IBAction)square23tapped:(id)sender {}
- (IBAction)square24tapped:(id)sender {}
- (IBAction)square25tapped:(id)sender {}
- (IBAction)square26tapped:(id)sender {}
- (IBAction)square27tapped:(id)sender {}
- (IBAction)square28tapped:(id)sender {}
- (IBAction)square29tapped:(id)sender {}
- (IBAction)square31tapped:(id)sender {}
- (IBAction)square32tapped:(id)sender {}
- (IBAction)square33tapped:(id)sender {}
- (IBAction)square34tapped:(id)sender {}
- (IBAction)square35tapped:(id)sender {}
- (IBAction)square36tapped:(id)sender {}
- (IBAction)square37tapped:(id)sender {}
- (IBAction)square38tapped:(id)sender {}
- (IBAction)square39tapped:(id)sender {}
- (IBAction)square41tapped:(id)sender {}
- (IBAction)square42tapped:(id)sender {}
- (IBAction)square43tapped:(id)sender {}
- (IBAction)square44tapped:(id)sender {}
- (IBAction)square45tapped:(id)sender {}
- (IBAction)square46tapped:(id)sender {}
- (IBAction)square47tapped:(id)sender {}
- (IBAction)square48tapped:(id)sender {}
- (IBAction)square49tapped:(id)sender {}
- (IBAction)square51tapped:(id)sender {}
- (IBAction)square52tapped:(id)sender {}
- (IBAction)square53tapped:(id)sender {}
- (IBAction)square54tapped:(id)sender {}
- (IBAction)square55tapped:(id)sender {}
- (IBAction)square56tapped:(id)sender {}
- (IBAction)square57tapped:(id)sender {}
- (IBAction)square58tapped:(id)sender {}
- (IBAction)square59tapped:(id)sender {}
- (IBAction)square61tapped:(id)sender {}
- (IBAction)square62tapped:(id)sender {}
- (IBAction)square63tapped:(id)sender {}
- (IBAction)square64tapped:(id)sender {}
- (IBAction)square65tapped:(id)sender {}
- (IBAction)square66tapped:(id)sender {}
- (IBAction)square67tapped:(id)sender {}
- (IBAction)square68tapped:(id)sender {}
- (IBAction)square69tapped:(id)sender {}
- (IBAction)square71tapped:(id)sender {}
- (IBAction)square72tapped:(id)sender {}
- (IBAction)square73tapped:(id)sender {}
- (IBAction)square74tapped:(id)sender {}

- (IBAction)square75tapped:(id)sender {
    [self selectSquare:sender];
}

- (IBAction)square76tapped:(id)sender {
    [self selectSquare:sender];
}

- (IBAction)square77tapped:(id)sender {
    [self selectSquare:sender];
}


- (IBAction)square78tapped:(id)sender {}
- (IBAction)square79tapped:(id)sender {}
- (IBAction)square81tapped:(id)sender {}
- (IBAction)square82tapped:(id)sender {}
- (IBAction)square83tapped:(id)sender {}
- (IBAction)square84tapped:(id)sender {}
- (IBAction)square85tapped:(id)sender {}
- (IBAction)square86tapped:(id)sender {}
- (IBAction)square87tapped:(id)sender {}
- (IBAction)square88tapped:(id)sender {
    [self selectSquare:sender];
}
- (IBAction)square89tapped:(id)sender {}
- (IBAction)square91tapped:(id)sender {}
- (IBAction)square92tapped:(id)sender {}
- (IBAction)square93tapped:(id)sender {}
- (IBAction)square94tapped:(id)sender {}
- (IBAction)square95tapped:(id)sender {}
- (IBAction)square96tapped:(id)sender {}
- (IBAction)square97tapped:(id)sender {}
- (IBAction)square98tapped:(id)sender {}
- (IBAction)square99tapped:(id)sender {}

- (void)selectSquare:(id)sender {
    if (self.isPieceSelected) { // 移動先のマスを選択した場合
        // 移動元の駒の画像と背景色を消す
        [self.selectedSquare setBackgroundColor:[UIColor clearColor]];
        [self.selectedSquare setImage:[UIImage alloc] forState:UIControlStateNormal];
        
        //選択された駒の種別を特定する
        
        //移動先の駒を表示する
        KFSquareButton *targetSquare = sender;
//        [targetSquare setImage:[UIImage imageNamed:@"s_fu.png"] forState:UIControlStateNormal];
        [targetSquare setImage:[UIImage imageNamed:[self.selectedPieace getImageName]] forState:UIControlStateNormal];
//        [targetSquare setImage:[UIImage imageNamed:[self.selectedPieace.delegate getImageName]] forState:UIControlStateNormal];
        
        self.isPieceSelected = NO;
        
    } else { // 移動元の駒を選択した場合
        KFSquareButton *selectedSquare = sender;
        self.selectedSquare = selectedSquare;
        self.selectedPieace = selectedSquare.locatedPiece;
        
        // 選択されたマスの背景を赤くする
        [self.selectedSquare setBackgroundColor:[UIColor grayColor]];
        
        self.isPieceSelected = YES;
    }
}

@end
