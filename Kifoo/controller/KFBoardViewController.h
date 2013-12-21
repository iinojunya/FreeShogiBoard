//
//  KFBoardViewController.h
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/01.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFBoardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *square58;
@property (weak, nonatomic) IBOutlet UIImageView *square59;

@property (weak, nonatomic) IBOutlet UIButton *button57;
@property (weak, nonatomic) IBOutlet UIButton *button56;

- (IBAction)button57tapped:(id)sender;
- (IBAction)button56tapped:(id)sender;


@end
