//
//  UIViewController+TabBar.h
//  virtual_ut
//
//  Created by if26 on 10/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//
// Catégorie pour partager la même source de données entre tous les view controllers du tabbar

#import <UIKit/UIKit.h>
#import "TabBarController.h"
#import "Etudiant.h"

@interface UIViewController (TabBar)
@property (readonly) TabBarController * tabBar;
@property (readonly) Etudiant * etudiant;
@property (readonly) NSMutableArray*listeAnnonces;
@property (readonly) NSMutableArray*transactionsVendeur;
@property (readonly) NSMutableArray*transactionsAcheteur;
@property (readonly) NSString*type;
@end
