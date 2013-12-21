//
//  KFBoardViewController.m
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/01.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import "KFBoardViewController.h"

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button57tapped:(id)sender {
}

- (IBAction)button56tapped:(id)sender {
    [self.button57 setImage:[UIImage alloc] forState:UIControlStateNormal];
    [self.button56 setImage:[UIImage imageNamed:@"s_fu.png"] forState:UIControlStateNormal];
}
@end
