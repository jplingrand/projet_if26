//
//  AppDelegate.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 26/11/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Etudiant.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property Etudiant*etudiant;
@property NSMutableArray * listeAnnonces;
@property NSMutableArray * transactionsVendeur;
@property NSMutableArray * transactionsAcheteur;
@property NSString * type;
@property (strong,nonatomic) NSArray * listeCategories ;

@end
