//
//  UIViewController+TabBar.m
//  virtual_ut
//
//  Created by if26 on 10/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "UIViewController+TabBar.h"
#import "AppDelegate.h"


@implementation UIViewController (TabBar)
 - (TabBarController *)tabBar
{
    return (TabBarController *)self.tabBarController;
}

- (Etudiant *) etudiant
{
    NSLog(@"%@",self.tabBar);
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant;
}
@end
