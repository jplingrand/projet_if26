//
//  AnnonceController.h
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//
// View controller qui affiche une annonce

#import <UIKit/UIKit.h>
#import "Annonce.h"

@interface AnnonceController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

// Elements graphiques
@property (weak, nonatomic) IBOutlet UIButton *boutonAnuller;
@property (weak, nonatomic) IBOutlet UIButton *boutonAcheter;
@property (weak, nonatomic) IBOutlet UILabel *titre;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *categorie;
@property (weak, nonatomic) IBOutlet UITextView *texte;
@property (weak, nonatomic) IBOutlet UIButton *boutonNouveauMessage;
@property (weak, nonatomic) IBOutlet UILabel *prix;
@property (weak, nonatomic) IBOutlet UILabel *login;
@property (weak, nonatomic) IBOutlet UILabel *ecole;
@property (weak, nonatomic) IBOutlet UITableView *listeMessages;

// L'annonnce (donnée)
@property Annonce * annonce;

// Fonctions réponse serveur
-(void)achatWithError : (BOOL) reponse;
-(void)annulationWithError : (BOOL) reponse;

-(IBAction) unwindToAnnonce : (UIStoryboardSegue*)segue;

// actions d'acheter det d'annuler
- (IBAction)boutonAcheter:(id)sender;
- (IBAction)boutonAnnuler:(id)sender;

@end
