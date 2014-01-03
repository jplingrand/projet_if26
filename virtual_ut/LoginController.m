//
//  LoginController.m
//  virtual_ut
//
//  Created by if26 on 26/11/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "LoginController.h"
#import "Interface_serveur.h"
#import "TabBarController.h"
#import "CompteController.h"
#import "UIViewController+TabBar.h"
#import "AppDelegate.h"

@implementation LoginController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    // Si le segue var vers l'inscription il est réalisé
    if (sender == self.boutonInscription)
    {
        return YES;
    }
    // Si tentative de connexion il n'est pas réalisé
    else if (sender == self.boutonConnexion)
    {
        if ([self.txtLogin.text  isEqual: @""] || [self.txtPassword.text  isEqual: @""] ) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Veuillez remplir tous les champs", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alert show];
        }else{
            // Lancement requete serveur
            [[Interface_serveur alloc]initConnexion: self.txtLogin.text withPassword:self.txtPassword.text fromViewController:self];
            return NO;
        }
    }
    return NO;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(IBAction)unwindToConnexion:(UIStoryboardSegue *)segue
{
    
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)getResponseFromServeur : (BOOL) reponse
{
    // Si pas d'erreur on réalise le segue 'unlock' qui va vers le tabbar
   if(!reponse)
   {
       ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.login = self.txtLogin.text;
       [self performSegueWithIdentifier:@"unlock" sender:self];
   }else{
       UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Erreur de connexion", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
       [alert show];
   }
}



@end
