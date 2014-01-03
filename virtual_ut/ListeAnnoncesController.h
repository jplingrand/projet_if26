//
//  ListeAnnoncesController.h
//  virtual_ut
//
//  Created by if26 on 26/11/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//
// View controller qui gere l'affichage d'une liste d'annonces

#import <UIKit/UIKit.h>

@interface ListeAnnoncesController : UITableViewController

// La liste d'annonces (element graphique)
@property (strong, nonatomic) IBOutlet UITableView *annoncesTableView;

// La liste d'annonces (données)
@property NSMutableArray * annonces;
@end
