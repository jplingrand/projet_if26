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

// Tous les attributs sont redirigés vers l'appdelegate

- (Etudiant *) etudiant
{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant;
}
- (NSMutableArray *) listeAnnonces
{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).listeAnnonces;
}
- (NSMutableArray *) transactionsAcheteur
{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).transactionsAcheteur;
}
- (NSMutableArray *) transactionsVendeur
{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).transactionsVendeur;
}
- (NSString *) type
{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).type;
}
@end
