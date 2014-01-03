//
//  MonCompteRootViewController.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 19/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

// Affiche le menu de l'onglet 'mon compte' avec trois sections: infos persos - mes annonces - mes transactions
#import <UIKit/UIKit.h>

@interface MonCompteRootViewController : UITableViewController

@property NSString * segueIdentifier;
@property (weak, nonatomic) IBOutlet UITableViewCell *monCompteCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *mesAnnoncesEnCoursCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *mesAnnoncesArchiveesCell;

// Fonction réponse serveur appellée par l'instance crée lors de l'appel serveur
-(void)getResponseWithError:(BOOL)error;

-(IBAction)unwindToRoot:(id)sender;
@end
