//
//  UIViewController+TabBar.h
//  virtual_ut
//
//  Created by if26 on 10/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"
#import "Etudiant.h"

@interface UIViewController (TabBar)
@property (readonly) TabBarController * tabBar;
@property (readonly) Etudiant * etudiant;
@end
