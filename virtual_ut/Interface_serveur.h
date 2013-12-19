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
#import "NouvelleAnnonceController.h"
#import "RechercheController.h"
#import "AnnonceController.h"
#import "MessageViewController.h"
#import "MonCompteRootViewController.h"
#import "TransactionController.h"

@interface Interface_serveur : NSObject

-(void)initConnexion : (NSString *) login withPassword :(NSString*)password fromViewController:(LoginController *)viewController;

-(void)initInscription : (InscriptionController *) viewController withNom : (NSString *) nom withPrenom : (NSString *) prenom withEmail : (NSString* ) email withTel : (NSString *) tel withEcole :(NSString *) ecole withLogin : (NSString*) login withPassword : (NSString *) password;

-(void) initAnnonce : (NouvelleAnnonceController * ) viewController withType :(NSString*)type withTitle : (NSString * )titre withTexte:(NSString*)texte withCategorie : (NSString *)categorie withPrix:(NSString*) prix;

-(void) initRecherche : (RechercheController * ) viewController withCategorie : (NSString * )categorie withPrixMin : (NSString *) prixMin withPrixMax : (NSString*)prixMax withMotsCles : (NSString*)motsCles;

-(void)initNouveauMessage : (MessageViewController*)viewController withMessage :(NSString *) message forAnnonce: (int) idAnnonce;

-(void) initAchat : (AnnonceController * )viewController withAnnonce : (int) idAnnonce;

-(void) initMesAnnonces : (MonCompteRootViewController*) viewController;

-(void) initMesTransactions : (MonCompteRootViewController*) viewController;

-(void) annulerAnnonce : (AnnonceController*) viewController withIdAnnonce : (int) id;

-(void) annulerTransaction :(TransactionController *)viewController withIdTransaction : (int) id;

-(void) validerTransaction :(TransactionController *)viewController withIdTransaction : (int) id withCode : (NSString *) code;


@property (strong,nonatomic) UIViewController * view;
@property (strong,nonatomic) NSString * requete;
@end
