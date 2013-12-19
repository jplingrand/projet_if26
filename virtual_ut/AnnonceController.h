//
//  AnnonceController.h
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Annonce.h"

@interface AnnonceController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *boutonAnuller;
@property (weak, nonatomic) IBOutlet UIButton *boutonAcheter;
@property (weak, nonatomic) IBOutlet UILabel *titre;
@property (weak, nonatomic) IBOutlet UILabel *date;
- (IBAction)boutonAnnuler:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *texte;
@property (weak, nonatomic) IBOutlet UIButton *boutonNouveauMessage;
@property (weak, nonatomic) IBOutlet UILabel *prix;
@property (weak, nonatomic) IBOutlet UILabel *login;
@property (weak, nonatomic) IBOutlet UILabel *ecole;
- (IBAction)boutonAcheter:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *listeMessages;
@property Annonce * annonce;
-(void)achatWithError : (BOOL) reponse;
-(void)annulationWithError : (BOOL) reponse;
-(IBAction) unwindToAnnonce : (UIStoryboardSegue*)segue;

@end
