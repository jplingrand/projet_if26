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
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (sender == self.boutonInscription)
    {
        if ([self.prenom.text  isEqual: @""] || [self.nom.text  isEqual: @""] || [self.email.text  isEqual: @""] || [self.password.text  isEqual: @""] || [self.ecole.text  isEqual: @""]|| [self.telephone.text  isEqual: @""]|| [self.login.text  isEqual: @""]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Veuillez remplir tous les champs", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Succès", @"") message:NSLocalizedString(@"Inscription réussie", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alert show];
            [[Interface_serveur alloc]initInscription:self withNom:self.nom.text withPrenom:self.prenom.text withEmail:self.email.text withTel:self.telephone.text withEcole:self.ecole.text withLogin:self.login.text withPassword:self.password.text];
        }
    }
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare for segue");
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}
-(void) getResponseFromServeur : (BOOL) reponse
{
    NSLog(@"serveur ok: %@", reponse ? @"YES" : @"NO");
}


@end
