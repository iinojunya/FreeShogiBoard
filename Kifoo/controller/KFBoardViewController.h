//
//  KFBoardViewController.h
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/01.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KFSquareButton;
@class KFPiece;

@interface KFBoardViewController : UIViewController

@property (strong, nonatomic) KFSquareButton *selectedSquare;
@property (strong, nonatomic) KFPiece *selectedPiece;

@property (strong, nonatomic) NSMutableDictionary *thisSideCapturedPieces;
@property (strong, nonatomic) NSMutableDictionary *counterSideCapturedPieces;

/*
@property (strong, nonatomic) NSMutableArray *thisSideCapturedPieceButtons;
@property (strong, nonatomic) NSMutableArray *counterSideCapturedPieceButtons;
 */
@property (strong, nonatomic) NSMutableDictionary *thisSideCapturedPieceButtons;
@property (strong, nonatomic) NSMutableDictionary *counterSideCapturedPieceButtons;

/*
@property (strong, nonatomic) NSMutableDictionary *selfCapturedPieces;
@property (strong, nonatomic) NSMutableDictionary *counterCapturedPieces;

@property (strong, nonatomic) NSMutableDictionary *capturedPiecesT;
@property (strong, nonatomic) NSMutableDictionary *capturedPiecesC;
 */

@property BOOL isLocatedPieceSelected;
@property BOOL isCapturedPieceSelected;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIView *thisSideStandView;
@property (weak, nonatomic) IBOutlet UIView *counterSideStandView;

@property (weak, nonatomic) IBOutlet KFSquareButton *square11;
@property (weak, nonatomic) IBOutlet KFSquareButton *square12;
@property (weak, nonatomic) IBOutlet KFSquareButton *square13;
@property (weak, nonatomic) IBOutlet KFSquareButton *square14;
@property (weak, nonatomic) IBOutlet KFSquareButton *square15;
@property (weak, nonatomic) IBOutlet KFSquareButton *square16;
@property (weak, nonatomic) IBOutlet KFSquareButton *square17;
@property (weak, nonatomic) IBOutlet KFSquareButton *square18;
@property (weak, nonatomic) IBOutlet KFSquareButton *square19;
@property (weak, nonatomic) IBOutlet KFSquareButton *square21;
@property (weak, nonatomic) IBOutlet KFSquareButton *square22;
@property (weak, nonatomic) IBOutlet KFSquareButton *square23;
@property (weak, nonatomic) IBOutlet KFSquareButton *square24;
@property (weak, nonatomic) IBOutlet KFSquareButton *square25;
@property (weak, nonatomic) IBOutlet KFSquareButton *square26;
@property (weak, nonatomic) IBOutlet KFSquareButton *square27;
@property (weak, nonatomic) IBOutlet KFSquareButton *square28;
@property (weak, nonatomic) IBOutlet KFSquareButton *square29;
@property (weak, nonatomic) IBOutlet KFSquareButton *square31;
@property (weak, nonatomic) IBOutlet KFSquareButton *square32;
@property (weak, nonatomic) IBOutlet KFSquareButton *square33;
@property (weak, nonatomic) IBOutlet KFSquareButton *square34;
@property (weak, nonatomic) IBOutlet KFSquareButton *square35;
@property (weak, nonatomic) IBOutlet KFSquareButton *square36;
@property (weak, nonatomic) IBOutlet KFSquareButton *square37;
@property (weak, nonatomic) IBOutlet KFSquareButton *square38;
@property (weak, nonatomic) IBOutlet KFSquareButton *square39;
@property (weak, nonatomic) IBOutlet KFSquareButton *square41;
@property (weak, nonatomic) IBOutlet KFSquareButton *square42;
@property (weak, nonatomic) IBOutlet KFSquareButton *square43;
@property (weak, nonatomic) IBOutlet KFSquareButton *square44;
@property (weak, nonatomic) IBOutlet KFSquareButton *square45;
@property (weak, nonatomic) IBOutlet KFSquareButton *square46;
@property (weak, nonatomic) IBOutlet KFSquareButton *square47;
@property (weak, nonatomic) IBOutlet KFSquareButton *square48;
@property (weak, nonatomic) IBOutlet KFSquareButton *square49;
@property (weak, nonatomic) IBOutlet KFSquareButton *square51;
@property (weak, nonatomic) IBOutlet KFSquareButton *square52;
@property (weak, nonatomic) IBOutlet KFSquareButton *square53;
@property (weak, nonatomic) IBOutlet KFSquareButton *square54;
@property (weak, nonatomic) IBOutlet KFSquareButton *square55;
@property (weak, nonatomic) IBOutlet KFSquareButton *square56;
@property (weak, nonatomic) IBOutlet KFSquareButton *square57;
@property (weak, nonatomic) IBOutlet KFSquareButton *square58;
@property (weak, nonatomic) IBOutlet KFSquareButton *square59;
@property (weak, nonatomic) IBOutlet KFSquareButton *square61;
@property (weak, nonatomic) IBOutlet KFSquareButton *square62;
@property (weak, nonatomic) IBOutlet KFSquareButton *square63;
@property (weak, nonatomic) IBOutlet KFSquareButton *square64;
@property (weak, nonatomic) IBOutlet KFSquareButton *square65;
@property (weak, nonatomic) IBOutlet KFSquareButton *square66;
@property (weak, nonatomic) IBOutlet KFSquareButton *square67;
@property (weak, nonatomic) IBOutlet KFSquareButton *square68;
@property (weak, nonatomic) IBOutlet KFSquareButton *square69;
@property (weak, nonatomic) IBOutlet KFSquareButton *square71;
@property (weak, nonatomic) IBOutlet KFSquareButton *square72;
@property (weak, nonatomic) IBOutlet KFSquareButton *square73;
@property (weak, nonatomic) IBOutlet KFSquareButton *square74;
@property (weak, nonatomic) IBOutlet KFSquareButton *square75;
@property (weak, nonatomic) IBOutlet KFSquareButton *square76;
@property (weak, nonatomic) IBOutlet KFSquareButton *square77;
@property (weak, nonatomic) IBOutlet KFSquareButton *square78;
@property (weak, nonatomic) IBOutlet KFSquareButton *square79;
@property (weak, nonatomic) IBOutlet KFSquareButton *square81;
@property (weak, nonatomic) IBOutlet KFSquareButton *square82;
@property (weak, nonatomic) IBOutlet KFSquareButton *square83;
@property (weak, nonatomic) IBOutlet KFSquareButton *square84;
@property (weak, nonatomic) IBOutlet KFSquareButton *square85;
@property (weak, nonatomic) IBOutlet KFSquareButton *square86;
@property (weak, nonatomic) IBOutlet KFSquareButton *square87;
@property (weak, nonatomic) IBOutlet KFSquareButton *square88;
@property (weak, nonatomic) IBOutlet KFSquareButton *square89;
@property (weak, nonatomic) IBOutlet KFSquareButton *square91;
@property (weak, nonatomic) IBOutlet KFSquareButton *square92;
@property (weak, nonatomic) IBOutlet KFSquareButton *square93;
@property (weak, nonatomic) IBOutlet KFSquareButton *square94;
@property (weak, nonatomic) IBOutlet KFSquareButton *square95;
@property (weak, nonatomic) IBOutlet KFSquareButton *square96;
@property (weak, nonatomic) IBOutlet KFSquareButton *square97;
@property (weak, nonatomic) IBOutlet KFSquareButton *square98;
@property (weak, nonatomic) IBOutlet KFSquareButton *square99;


- (IBAction)resetButtonTapped:(id)sender;

- (IBAction)square11tapped:(id)sender;
- (IBAction)square12tapped:(id)sender;
- (IBAction)square13tapped:(id)sender;
- (IBAction)square14tapped:(id)sender;
- (IBAction)square15tapped:(id)sender;
- (IBAction)square16tapped:(id)sender;
- (IBAction)square17tapped:(id)sender;
- (IBAction)square18tapped:(id)sender;
- (IBAction)square19tapped:(id)sender;
- (IBAction)square21tapped:(id)sender;
- (IBAction)square22tapped:(id)sender;
- (IBAction)square23tapped:(id)sender;
- (IBAction)square24tapped:(id)sender;
- (IBAction)square25tapped:(id)sender;
- (IBAction)square26tapped:(id)sender;
- (IBAction)square27tapped:(id)sender;
- (IBAction)square28tapped:(id)sender;
- (IBAction)square29tapped:(id)sender;
- (IBAction)square31tapped:(id)sender;
- (IBAction)square32tapped:(id)sender;
- (IBAction)square33tapped:(id)sender;
- (IBAction)square34tapped:(id)sender;
- (IBAction)square35tapped:(id)sender;
- (IBAction)square36tapped:(id)sender;
- (IBAction)square37tapped:(id)sender;
- (IBAction)square38tapped:(id)sender;
- (IBAction)square39tapped:(id)sender;
- (IBAction)square41tapped:(id)sender;
- (IBAction)square42tapped:(id)sender;
- (IBAction)square43tapped:(id)sender;
- (IBAction)square44tapped:(id)sender;
- (IBAction)square45tapped:(id)sender;
- (IBAction)square46tapped:(id)sender;
- (IBAction)square47tapped:(id)sender;
- (IBAction)square48tapped:(id)sender;
- (IBAction)square49tapped:(id)sender;
- (IBAction)square51tapped:(id)sender;
- (IBAction)square52tapped:(id)sender;
- (IBAction)square53tapped:(id)sender;
- (IBAction)square54tapped:(id)sender;
- (IBAction)square55tapped:(id)sender;
- (IBAction)square56tapped:(id)sender;
- (IBAction)square57tapped:(id)sender;
- (IBAction)square58tapped:(id)sender;
- (IBAction)square59tapped:(id)sender;
- (IBAction)square61tapped:(id)sender;
- (IBAction)square62tapped:(id)sender;
- (IBAction)square63tapped:(id)sender;
- (IBAction)square64tapped:(id)sender;
- (IBAction)square65tapped:(id)sender;
- (IBAction)square66tapped:(id)sender;
- (IBAction)square67tapped:(id)sender;
- (IBAction)square68tapped:(id)sender;
- (IBAction)square69tapped:(id)sender;
- (IBAction)square71tapped:(id)sender;
- (IBAction)square72tapped:(id)sender;
- (IBAction)square73tapped:(id)sender;
- (IBAction)square74tapped:(id)sender;
- (IBAction)square75tapped:(id)sender;
- (IBAction)square76tapped:(id)sender;
- (IBAction)square77tapped:(id)sender;
- (IBAction)square78tapped:(id)sender;
- (IBAction)square79tapped:(id)sender;
- (IBAction)square81tapped:(id)sender;
- (IBAction)square82tapped:(id)sender;
- (IBAction)square83tapped:(id)sender;
- (IBAction)square84tapped:(id)sender;
- (IBAction)square85tapped:(id)sender;
- (IBAction)square86tapped:(id)sender;
- (IBAction)square87tapped:(id)sender;
- (IBAction)square88tapped:(id)sender;
- (IBAction)square89tapped:(id)sender;
- (IBAction)square91tapped:(id)sender;
- (IBAction)square92tapped:(id)sender;
- (IBAction)square93tapped:(id)sender;
- (IBAction)square94tapped:(id)sender;
- (IBAction)square95tapped:(id)sender;
- (IBAction)square96tapped:(id)sender;
- (IBAction)square97tapped:(id)sender;
- (IBAction)square98tapped:(id)sender;
- (IBAction)square99tapped:(id)sender;








@end
