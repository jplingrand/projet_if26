//
//  UIViewController+TabBar.m
//  virtual_ut
//
//  Created by if26 on 10/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "UIViewController+TabBar.h"


@implementation UIViewController (TabBar)
 - (TabBarController *)tabBar
{
    return (TabBarController *)self.tabBarController;
}

- (Etudiant *) etudiant
{
    return self.tabBar.etudiant;
}
@end
