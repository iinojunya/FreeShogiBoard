//
//  KFAppDelegate.h
//  Kifoo
//
//  Created by Maeda Kazuya on 2013/12/01.
//  Copyright (c) 2013年 Kifoo, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KFTitleViewController;
@class KFBoardViewController;

@interface KFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) KFTitleViewController *titleViewController;
@property (strong, nonatomic) KFBoardViewController *boardViewController;

@end
