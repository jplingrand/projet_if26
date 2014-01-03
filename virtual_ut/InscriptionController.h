//
//  InscriptionController.h
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

// View controller responsable de la page d'inscription
#import <UIKit/UIKit.h>

@interface InscriptionController : UIViewController

// elements graphiques
@property (weak, nonatomic) IBOutlet UIButton *boutonInscription;
@property (weak, nonatomic) IBOutlet UITextField *prenom;
@property (weak, nonatomic) IBOutlet UITextField *nom;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *telephone;
@property (weak, nonatomic) IBOutlet UITextField *ecole;
@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *password;

// Permet de gérer la touche retour
-(IBAction)textFieldReturn:(id)sender;

// réponse de l'instnce serveur créé en cas de tentative d'inscription
-(void) getResponseFromServeur : (BOOL) reponse;

@end
