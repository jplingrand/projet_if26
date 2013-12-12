//
//  Interface_serveur.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 07/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+TabBar.h"
#import "LoginController.h"
#import "InscriptionController.h"

@interface Interface_serveur : NSObject

-(void)initConnexion : (NSString *) login withPassword :(NSString*)password fromViewController:(LoginController *)viewController;

-(void)initInscription : (InscriptionController *) viewController withNom : (NSString *) nom withPrenom : (NSString *) prenom withEmail : (NSString* ) email withTel : (NSString *) tel withEcole :(NSString *) ecole withLogin : (NSString*) login withPassword : (NSString *) password;

@property (strong,nonatomic) UIViewController * view;
@end
