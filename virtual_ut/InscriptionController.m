//
//  InscriptionController.m
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "InscriptionController.h"
#import "Interface_serveur.h"


@implementation InscriptionController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    // Si tentative d'inscription on effectue pas le segue. On vérifie les champs et on réalise la connexion serveur via une instance d'Interface_serveur
    if (sender == self.boutonInscription)
    {
        if ([self.prenom.text  isEqual: @""] || [self.nom.text  isEqual: @""] || [self.email.text  isEqual: @""] || [self.password.text  isEqual: @""] || [self.ecole.text  isEqual: @""]|| [self.telephone.text  isEqual: @""]|| [self.login.text  isEqual: @""]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Veuillez remplir tous les champs", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alert show];
        }
        else {
            [[Interface_serveur alloc]initInscription:self withNom:self.nom.text withPrenom:self.prenom.text withEmail:self.email.text withTel:self.telephone.text withEcole:self.ecole.text withLogin:self.login.text withPassword:self.password.text];
        }
    }else{
        return YES;
    }
    return NO;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare for segue");
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

// Fonction réponse serveur. On averti le user. reponse = error. Si pas d'erreur on retourne à la vue de connexion
-(void) getResponseFromServeur : (BOOL) reponse
{
    if(reponse){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Echec de linscription", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
        [self performSegueWithIdentifier:@"retourVersLogin" sender:self];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Succès", @"") message:NSLocalizedString(@"Inscription réussie", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
