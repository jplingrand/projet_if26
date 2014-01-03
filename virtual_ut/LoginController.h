//
//  LoginController.h
//  virtual_ut
//
//  Created by if26 on 26/11/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//


// View controller responsable de la vue de connexion

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController

// Elements graphiques
@property (weak, nonatomic) IBOutlet UIButton *boutonConnexion;
@property (weak, nonatomic) IBOutlet UIButton *boutonInscription;

@property (weak, nonatomic) IBOutlet UITextField *txtLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

// Pour gérer le clavier
-(IBAction)textFieldReturn:(id)sender;

-(void) getResponseFromServeur : (BOOL) reponse;
@end
